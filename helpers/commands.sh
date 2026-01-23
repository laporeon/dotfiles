#!/bin/bash

GREEN='\033[0;32m'
BLUE="\033[1;34m"
RESET='\033[0m'

DEVELOPMENT="$HOME/Development"
DOTFILES="$HOME/Development/dotfiles"

# ===== INSTALLATIONS ===== #
install_jetbrains_font() {
    echo -e "\n${BLUE}Installing JetBrains Mono NerdFont...${RESET}"
    sudo cp -r "$DOTFILES/assets/fonts/JetBrainsMonoNerdFont/"*.ttf /usr/share/fonts/
    sudo fc-cache -fv
    echo -e "${GREEN}✔ JetBrains Mono NerdFont successfully installed!${RESET}"
}

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

# =========== BACKUPS AND SYNCHRONIZATIONS ========== #

lsync() {
  echo -e "\n${BLUE}Copying configuration files to local folders...${RESET}"

  mkdir -p ~/.config/{nvim,wezterm,fastfetch}

  cp -r "$DOTFILES/environments/linux/nvim" "$HOME/.config/nvim/" && \
  cp -r "$DOTFILES/environments/linux/wezterm" "$HOME/.config/wezterm/" && \
  cp -r "$DOTFILES/environments/linux/fastfetch" "$HOME/.config/fastfetch/" && \
  cp "$DOTFILES/environments/linux/zsh/.zshrc" "$HOME/" && \
  cp "$DOTFILES/environments/linux/zsh/themes/dcf.zsh-theme" "$HOME/.oh-my-zsh/themes/"

  echo -e "${GREEN}✔ Configuration files successfully copied!${RESET}"
}

dsync() {
  echo -e "\n${BLUE}↑ Syncing documents with Dropbox...${RESET}"

  rclone sync ~/Documents/Obsidian dropbox:Obsidian && \
  rclone sync ~/Documents/Async dropbox:Async && \
  rclone sync ~/Documents/Currículos dropbox:Curriculos

  echo -e "${GREEN}✔ Documents successfully synced with Dropbox!${RESET}"
}

dtfcp() {
  echo -e "\n${BLUE}↑ Backing up dotfiles...${RESET}"

  cp ~/.zshrc ~/Development/dotfiles/environments/linux/zsh/ && \
  cp ~/.config/nvim/. ~/Development/dotfiles/environments/linux/nvim/ && \
  cp ~/.config/wezterm/wezterm.lua ~/Development/dotfiles/environments/linux/wezterm/ && \
  cp ~/.config/fastfetch/config.jsonc ~/Development/dotfiles/environments/linux/fastfetch

  echo -e "${GREEN}✔ Dotfiles successfully synced!${RESET}"
}

bkp() {
  echo -e "\n${BLUE}💾 Starting backup process...${RESET}"

  echo -e "\n${BLUE}↑ Backing up Development folder...${RESET}"
  zip -qr ~/development.zip ~/Development && \
  echo -e "\n${BLUE}↑ Synching Development folder with Dropbox...${RESET}"
  rclone sync ~/development.zip dropbox:Development && \
  local file="backup_$(date +%Y-%m-%d).zip"
  echo -e "\n${BLUE}↑ Creating full backup...${RESET}"
  zip -qr ~/$file ~/Development ~/Documents ~/Pictures ~/Music ~/Videos && \
  echo -e "\n${BLUE}↑ Moving backup to external drive...${RESET}"
  mv ~/$file /mnt/sda1/

  local backup_size=$(du -h /mnt/sda1/"$file" | cut -f1)
  echo -e "${GREEN}✔ Backup completed: $file (${backup_size})${RESET}"
}
