#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE="\033[1;34m"
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
RESET='\033[0m'

declare -A apps=(
  ["Discord"]="https://discord.com/api/download/stable?platform=linux&format=deb"
  ["Visual Studio Code"]="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  ["Bruno"]=$(curl -s https://api.github.com/repos/usebruno/bruno/releases/latest | grep -o 'https://[^"]*_amd64_linux\.deb' | head -n1)
  ["MongoDB Compass"]=$(curl -s https://api.github.com/repos/mongodb-js/compass/releases/latest | grep -o 'https://[^"]*amd64\.deb' | grep -v -e isolated -e readonly | head -n1)
  ["DBeaver"]="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
  ["Obsidian"]=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep -o 'https://[^"]*amd64\.deb' | head -n1)
  ["Beekeeper Studio"]=$(curl -s https://api.github.com/repos/beekeeper-studio/beekeeper-studio/releases/latest | grep -o 'https://[^"]*_amd64\.deb' | head -n1)
)

menu() {
  clear
  echo -e "${BLUE}"
  echo -e "----------------------------"
  echo -e "-       APPS MANAGER       -"
  echo -e "----------------------------"
  echo -e "${RESET}"

  list_apps
}

list_apps() {

  echo -e "Supported apps:\n"

  mapfile -t sorted_apps < <(printf '%s\n' "${!apps[@]}" | sort)

  half=$(((${#sorted_apps[@]} + 1) / 2))

  for ((i = 0; i < half; i++)); do
    left_index=$i
    right_index=$((i + half))

    printf "(${BLUE}%2d ${RESET}) %-25s" $((left_index + 1)) "${sorted_apps[left_index]}"

    if [[ ${sorted_apps[right_index]+isset} ]]; then
      printf "(${BLUE}%2d ${RESET}) %s" $((right_index + 1)) "${sorted_apps[right_index]}"
    fi

    printf "\n"
  done

  echo -e "\n(${BLUE} 0 ${RESET}) Install/Update all apps"
}

manage_app() {
  local app_name="$1"
  local url="$2"
  local normalized_name=$(echo "$app_name" | tr -d ' ' | tr '[:upper:]' '[:lower:]')
  local temp_file="/tmp/${normalized_name}.deb"

  echo -e "\n${YELLOW}❯ Checking $app_name...${RESET}"

  if ! curl -sS -L "$url" -o "$temp_file"; then
    echo -e "${RED}✗ Failed to download ${app_name}.${RESET}"
    return 1
  fi

  local pkg_name=$(dpkg-deb -f "$temp_file" Package 2>/dev/null | tr -d '\r')
  local latest_version=$(dpkg-deb -f "$temp_file" Version 2>/dev/null | tr -d '\r')
  local installed_version=$(dpkg-query -W -f='${Version}' "$pkg_name" 2>/dev/null || echo "")

  if [[ -z "$installed_version" ]]; then
    echo -e "${CYAN}⭑ $app_name is not installed. Installing...${RESET}"
    if { sudo dpkg -i "$temp_file" || sudo apt-get install -f -y; } >/dev/null 2>&1; then
      echo -e "${GREEN}✔ ${app_name} successfully installed!${RESET}"
    else
      echo -e "${RED}✗ Failed to install ${app_name}.${RESET}"
    fi
  else
    echo -e "Installed version: $installed_version"
    echo -e "Latest version: $([[ "$installed_version" != "$latest_version" ]] && echo -n "${RED}↑ ")$latest_version${RESET}"

    if [[ "$installed_version" == "$latest_version" ]]; then
      echo -e "${YELLOW}⭑ ${app_name} is up to date!${RESET}"
    else
      echo -e "\n${BLUE}↑ Updating ${app_name}...${RESET}"
      if { sudo dpkg -i "$temp_file" || sudo apt-get install -f -y; } >/dev/null 2>&1; then
        echo -e "${GREEN}✔ ${app_name} was successfully updated to v${latest_version}${RESET}"
      else
        echo -e "${RED}✗ Failed to update ${app_name}.${RESET}"
      fi
    fi
  fi

  rm -f "$temp_file"
}

main() {
  menu

  echo -e "\nUsage: Type apps number separated by a blank space or press ENTER to exit.\n"

  while true; do
    read -r -p "OPTION(S): " options

    [[ -z "$options" ]] && {
      echo -e "\nExiting..."
      exit 0
    }

    [[ "$options" == "0" ]] && break

    invalid=()
    for opt in $options; do
      ((opt < 1 || opt > ${#sorted_apps[@]})) && invalid+=("$opt")
    done

    [[ ${#invalid[@]} -eq 0 ]] && break

    echo -e "${RED}Invalid choice(s): ${invalid[*]}. Try again.\n${RESET}"
  done

  if [[ "$options" == "0" ]]; then
    for app_name in "${!apps[@]}"; do
      manage_app "$app_name" "${apps[$app_name]}"
    done
  else
    for option in $options; do
      index=$((option - 1))
      manage_app "${sorted_apps[index]}" "${apps[${sorted_apps[index]}]}"
    done
  fi

  echo -e "\nFinished! Exiting...${RESET}"
}

main
