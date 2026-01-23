#!/bin/bash

GREEN='\033[0;32m'
BLUE="\033[1;34m"
RESET='\033[0m'

# =========== UPDATES ========== #
update_discord() {
    echo -e "\n${BLUE}↑ Updating Discord...${RESET}"

    curl -sL "https://discord.com/api/download/stable?platform=linux&format=deb" -o /tmp/discord.deb
    sudo dpkg -i /tmp/discord.deb
    rm /tmp/discord.deb

    echo -e "${GREEN}✔ Discord successfully updated!${RESET}"
}

update_bruno() {
    echo -e "\n${BLUE}↑ Updating Bruno...${RESET}"

    local bruno_url=$(curl -s https://api.github.com/repos/usebruno/bruno/releases/latest | grep -o 'https://[^"]*_amd64_linux\.deb' | head -n1)
    curl -sL "$bruno_url" -o /tmp/bruno.deb
    sudo dpkg -i /tmp/bruno.deb
    rm /tmp/bruno.deb

    echo -e "${GREEN}✔ Bruno successfully updated!${RESET}"
}

update_dbeaver() {
    echo -e "\n${BLUE}↑ Updating DBeaver...${RESET}"

    curl -sL "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" -o /tmp/dbeaver.deb
    sudo dpkg -i /tmp/dbeaver.deb
    rm /tmp/dbeaver.deb

    echo -e "${GREEN}✔ DBeaver successfully updated!${RESET}"
}

# =========== BACKUPS ========== #

dsync() {
  rclone sync ~/Documents/Obsidian dropbox:Obsidian && \
  rclone sync ~/Documents/Async dropbox:Async && \
  rclone sync ~/Documents/Currículos dropbox:Curriculos

  echo -e "${GREEN}✔ All documents synced with Dropbox!${RESET}"
}

dtfcp() {
  cp ~/.zshrc ~/Development/dotfiles/environments/linux/zsh/ && \
  cp ~/.config/wezterm/wezterm.lua ~/Development/dotfiles/environments/linux/wezterm/ && \
  cp ~/.config/fastfetch/config.jsonc ~/Development/dotfiles/environments/linux/fastfetch

  echo -e "${GREEN}✔ All dotfiles synced to dotfiles${RESET}"
}

bkp() {
  zip -r ~/development.zip ~/Development && \
  rclone sync ~/development.zip dropbox:Development && \
  local file="backup_$(date +%Y-%m-%d).zip"
  zip -r ~/$file ~/Development ~/Documents ~/Pictures ~/Music ~/Videos && \
  mv ~/$file /mnt/sda1/

  echo -e "${GREEN}✔ Backup completed${RESET}"
}
