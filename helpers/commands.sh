#!/bin/bash

GREEN='\033[0;32m'
BLUE="\033[1;34m"
RED='\033[0;31m'
RESET='\033[0m'

DEVELOPMENT="$HOME/Development"
DOTFILES="$HOME/Development/dotfiles"

error() {
    echo -e "${RED}\n✘ An error occurred. Try again...${RESET}"
}

# ===== INSTALLATIONS / UPDATE ===== #
install_jetbrains_font() {
    echo -e "\n${BLUE}Installing JetBrains Mono NerdFont...${RESET}"
    sudo cp -r "$DOTFILES/assets/fonts/JetBrainsMonoNerdFont/"*.ttf /usr/share/fonts/ && \
    sudo fc-cache -fv && \
    echo -e "${GREEN}\n✔ JetBrains Mono NerdFont successfully installed!${RESET}" || error
}

update_discord() {
    echo -e "\n${BLUE}Updating Discord...${RESET}"
    curl -sL "https://discord.com/api/download/stable?platform=linux&format=deb" -o /tmp/discord.deb && \
    sudo dpkg -i /tmp/discord.deb && \
    rm /tmp/discord.deb && \
    echo -e "${GREEN}\n✔ Discord successfully updated!${RESET}" || error
}

update_bruno() {
    echo -e "\n${BLUE}Updating Bruno...${RESET}"
    local bruno_url=$(curl -s https://api.github.com/repos/usebruno/bruno/releases/latest | grep -o 'https://[^"]*_amd64_linux\.deb' | head -n1)
    curl -sL "$bruno_url" -o /tmp/bruno.deb && \
    sudo dpkg -i /tmp/bruno.deb && \
    rm /tmp/bruno.deb && \
    echo -e "${GREEN}\n✔ Bruno successfully updated!${RESET}" || error
}

update_dbeaver() {
    echo -e "\n${BLUE}Updating DBeaver...${RESET}"
    curl -sL "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" -o /tmp/dbeaver.deb && \
    sudo dpkg -i /tmp/dbeaver.deb && \
    rm /tmp/dbeaver.deb && \
    echo -e "${GREEN}\n✔ DBeaver successfully updated!${RESET}" || error
}

# =========== BACKUPS AND SYNCHRONIZATIONS ========== #

lsync() {
  echo -e "\n${BLUE}Syncing config files...${RESET}"

  mkdir -p "$HOME/.config/{nvim,wezterm,fastfetch}"

  cp -r "$DOTFILES/environments/linux/nvim" "$HOME/.config/" && \
  cp -r "$DOTFILES/environments/linux/wezterm" "$HOME/.config/" && \
  cp -r "$DOTFILES/environments/linux/fastfetch" "$HOME/.config/" && \
  cp "$DOTFILES/environments/linux/zsh/.zshrc" "$HOME/" && \
  cp "$DOTFILES/environments/linux/zsh/themes/dcf.zsh-theme" "$HOME/.oh-my-zsh/themes/" && \
  echo -e "${GREEN}\n✔ Configuration files successfully synced!${RESET}" || error
}

dsync() {
  echo -e "\n${BLUE}↑ Syncing documents with Dropbox...${RESET}"

  rclone sync "$HOME/Documents/Obsidian" dropbox:Obsidian && \
  rclone sync "$HOME/Documents/Async" dropbox:Async && \
  rclone sync "$HOME/Documents/Currículos" dropbox:Curriculos && \
  echo -e "${GREEN}\n✔ Documents successfully synced!${RESET}" || error
}

dtfcp() {
  echo -e "\n${BLUE}Backing up dotfiles...${RESET}"

  cp "$HOME/.zshrc" "$DOTFILES/environments/linux/zsh/" && \
  cp -r "$HOME/.config/nvim/." "$DOTFILES/environments/linux/nvim/" && \
  cp "$HOME/.config/wezterm/wezterm.lua" "$DOTFILES/environments/linux/wezterm/" && \
  cp "$HOME/.config/fastfetch/config.jsonc" "$DOTFILES/environments/linux/fastfetch/" && \
  echo -e "${GREEN}\n✔ Dotfiles successfully backed up!${RESET}" || error
}


bkp() {
  echo -e "\n${BLUE}Starting backup process...${RESET}"

  # Development folder
  echo -e "\n${BLUE}Backing up Development folder...${RESET}"
  zip -qr /tmp/development.zip "$HOME/Development" && \
  echo -e "\n${BLUE}↑ Syncing Development folder with Dropbox...${RESET}" && \
  rclone sync /tmp/development.zip dropbox:Development && \
  rm /tmp/development.zip

  # Full backup
  local file="backup_$(date +%Y-%m-%d_%H-%M).zip"
  echo -e "\n${BLUE}Creating $file...${RESET}"

  zip -qr "$HOME/$file" \
      "$HOME/.themes" \
      "$HOME/.icons" \
      "$HOME/Development" \
      "$HOME/Downloads" \
      "$HOME/Documents" \
      "$HOME/Pictures" \
      "$HOME/Music" \
      "$HOME/Videos"

  echo -e "\n${BLUE}Moving backup to external drive...${RESET}"
  mv "$HOME/$file" /mnt/sda1/ && \
  local backup_size=$(du -h /mnt/sda1/"$file" | cut -f1) && \
  echo -e "${GREEN}\n✔ Backup completed: $file (${backup_size})${RESET}" || error
}
