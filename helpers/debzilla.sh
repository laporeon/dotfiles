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
  ["MongoDB Compass"]=$(curl -s https://api.github.com/repos/mongodb-js/compass/releases/latest | grep -o 'https://[^"]*amd64\.deb' | head -n1)
  ["DBeaver"]="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
  ["Obsidian"]=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep -o 'https://[^"]*amd64\.deb' | head -n1)
  ["Beekeeper Studio"]=$(curl -s https://api.github.com/repos/beekeeper-studio/beekeeper-studio/releases/latest | grep -o 'https://[^"]*_amd64\.deb' | head -n1)
)

display_logo() {
  echo -e "${BLUE}"
  echo -e "------------------------------------------"
  echo -e "▗▄▄▄  ▗▄▄▄▖▗▄▄▖ ▗▄▄▄▄▖▗▄▄▄▖▗▖   ▗▖    ▗▄▖ "
  echo -e "▐▌  █ ▐▌   ▐▌ ▐▌   ▗▞▘  █  ▐▌   ▐▌   ▐▌ ▐▌"
  echo -e "▐▌  █ ▐▛▀▀▘▐▛▀▚▖ ▗▞▘    █  ▐▌   ▐▌   ▐▛▀▜▌"
  echo -e "▐▙▄▄▀ ▐▙▄▄▖▐▙▄▞▘▐▙▄▄▄▖▗▄█▄▖▐▙▄▄▖▐▙▄▄▖▐▌ ▐▌"
  echo -e "------------------------------------------"
  echo -e "${RESET}"
}

show_menu() {
  clear

  display_logo

  list_apps

  echo -e "\nUsage: Type apps number separated by a blank space or press ENTER to exit.\n"
}

list_apps() {

  echo -e "Supported apps:\n"

  mapfile -t sorted_apps < <(printf '%s\n' "${!apps[@]}" | sort)

  local half=$(((${#sorted_apps[@]} + 1) / 2))

  for ((i = 0; i < half; i++)); do
    local left_index=$i
    local right_index=$((i + half))

    printf "(${BLUE}%2d ${RESET}) %-25s" $((left_index + 1)) "${sorted_apps[left_index]}"

    if [[ ${sorted_apps[right_index]+isset} ]]; then
      printf "(${BLUE}%2d ${RESET}) %s" $((right_index + 1)) "${sorted_apps[right_index]}"
    fi

    printf "\n"
  done

  echo -e "\n(${BLUE} 0 ${RESET}) Install/Update all apps"
}

get_app_info() {
  local temp_file="$1"

  pkg_name=$(dpkg-deb -f "$temp_file" Package 2>/dev/null | tr -d '\r')
  latest_version=$(dpkg-deb -f "$temp_file" Version 2>/dev/null | tr -d '\r')
  installed_version=$(dpkg-query -W -f='${Version}' "$pkg_name" 2>/dev/null || echo "")
}

verify_app() {
  local app_name="$1"
  local url="$2"
  local normalized_name=$(echo "$app_name" | tr -d ' ' | tr '[:upper:]' '[:lower:]')
  local temp_file="/tmp/${normalized_name}.deb"

  echo -e "\n${YELLOW}❯ Checking $app_name...${RESET}"

  if ! curl -sS -L "$url" -o "$temp_file"; then
    echo -e "${RED}✗ Failed to download ${app_name}.${RESET}"
    return 1
  fi

  get_app_info "$temp_file"

  if [[ -z "$installed_version" ]]; then
    install_app "$app_name" "$temp_file"
  else
    update_app "$app_name" "$temp_file"
  fi

  rm -f "$temp_file"
}

install_app() {
  local app_name="$1"
  local temp_file="$2"

  echo -e "${CYAN}⭑ $app_name is not installed. Installing...${RESET}"

  if { sudo dpkg -i "$temp_file" || sudo apt-get install -f -y; } >/dev/null 2>&1; then
    echo -e "${GREEN}✔ ${app_name} successfully installed!${RESET}"
  else
    echo -e "${RED}✗ Failed to install ${app_name}.${RESET}"
  fi
}

update_app() {
  local app_name="$1"
  local temp_file="$2"

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
}

validate_options() {
  local options="$1"
  local invalid_choices=()

  for option in $options; do
    if ((option < 1 || option > ${#sorted_apps[@]})); then
      invalid_choices+=("$option")
    fi
  done

  if [[ ${#invalid_choices[@]} -gt 0 ]]; then
    echo -e "${RED}Invalid choice(s): ${invalid_choices[*]}. Try again.\n${RESET}"
    return 1
  fi

  return 0
}

get_user_options() {
  while true; do
    read -r -p "OPTION(S): " options

    if [[ -z "$options" ]]; then
      echo -e "\nExiting..."
      exit 0
    fi

    if [[ "$options" == "0" ]]; then
      for app_name in "${!apps[@]}"; do
        verify_app "$app_name" "${apps[$app_name]}"
      done
      break
    fi

    if validate_options "$options"; then
      for option in $options; do
        index=$((option - 1))
        verify_app "${sorted_apps[index]}" "${apps[${sorted_apps[index]}]}"
      done
      break
    fi

  done

}

main() {
  show_menu

  get_user_options

  echo -e "\nFinished! Exiting...${RESET}"
}

main
