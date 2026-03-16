#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'
BOLD_WHITE='\033[1;37m'

DOCUMENTS="$HOME/Documents"
DEVELOPMENT="$HOME/Development"
DOTFILES="$HOME/Development/dotfiles"

error() {
    echo -e "${RED}\n✘ An error occurred. Try again...${RESET}"
}

# ===== INSTALLATIONS / UPDATE ===== #
install_jetbrains_font() {
    echo -e "${BOLD_WHITE}Installing JetBrains Mono NerdFont...${RESET}"

    command -v ttx >/dev/null 2>&1 || { echo >&2 "fonttools/ttx not installed. Run: sudo apt install fonttools"; return 1; }

    local tmp_dir
    tmp_dir=$(mktemp -d)

    curl -fLo "$tmp_dir/JetBrainsMonoNerdFont.zip" \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

    unzip -q "$tmp_dir/JetBrainsMonoNerdFont.zip" -d "$tmp_dir/fonts"

    for fontfile in "$tmp_dir/fonts"/*.ttf; do
        local basename
        basename=$(basename "$fontfile")
        echo "Processing: $basename"

        ttx -q "$fontfile"
        local ttxfile="${fontfile%.ttf}.ttx"

        sed -i \
            -e 's/JetBrainsMono Nerd Font/JetBrains Mono/g' \
            -e 's/JetBrainsMonoNerdFont/JetBrainsMono/g' \
            -e 's/JetBrainsMono NF/JetBrains Mono/g' \
            "$ttxfile"

        ttx -q -m "$fontfile" "$ttxfile"

        local newfont="${fontfile%.ttf}#1.ttf"
        mv "$newfont" "$tmp_dir/fonts/$basename"
        rm "$ttxfile"
    done

    if sudo cp "$tmp_dir/fonts"/*.ttf /usr/share/fonts/ && sudo fc-cache -fv; then
        echo -e "${GREEN}✔ JetBrains Mono NerdFont successfully installed!${RESET}"
    else
        error
    fi

    rm -rf "$tmp_dir"
}

update_discord() {
    echo -e "${BOLD_WHITE}Updating Discord...${RESET}"
    curl -sL "https://discord.com/api/download/stable?platform=linux&format=deb" -o /tmp/discord.deb && \
    sudo dpkg -i /tmp/discord.deb && \
    rm /tmp/discord.deb && \
    echo -e "${GREEN}✔ Discord successfully updated!${RESET}" || error
}

update_bruno() {
    echo -e "${BOLD_WHITE}Updating Bruno...${RESET}"
    local bruno_url=$(curl -s https://api.github.com/repos/usebruno/bruno/releases/latest | grep -o 'https://[^"]*_amd64_linux\.deb' | head -n1)
    curl -sL "$bruno_url" -o /tmp/bruno.deb && \
    sudo dpkg -i /tmp/bruno.deb && \
    rm /tmp/bruno.deb && \
    echo -e "${GREEN}✔ Bruno successfully updated!${RESET}" || error
}

update_dbeaver() {
    echo -e "${BOLD_WHITE}Updating DBeaver...${RESET}"
    curl -sL "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" -o /tmp/dbeaver.deb && \
    sudo dpkg -i /tmp/dbeaver.deb && \
    rm /tmp/dbeaver.deb && \
    echo -e "${GREEN}✔ DBeaver successfully updated!${RESET}" || error
}

# =========== BACKUPS AND SYNCHRONIZATIONS ========== #

lsync() {
  echo -e "${BOLD_WHITE}Syncing config files...${RESET}"

  mkdir -p "$HOME"/.config/{nvim,wezterm,fastfetch}

  cp -r "$DOTFILES/environments/linux/nvim" "$HOME/.config/" && \
  cp -r "$DOTFILES/environments/linux/wezterm" "$HOME/.config/" && \
  cp -r "$DOTFILES/environments/linux/fastfetch" "$HOME/.config/" && \
  cp "$DOTFILES/environments/linux/zsh/.zshrc" "$HOME/" && \
  cp "$DOTFILES/environments/linux/zsh/themes/"*.zsh-theme "$HOME/.oh-my-zsh/themes/" && \
  echo -e "${GREEN}✔ Configuration files successfully synced!${RESET}" || error
}

dsync() {
  echo -e "${BOLD_WHITE}↑ Syncing documents with Dropbox...${RESET}"

  rclone sync "$DOCUMENTS/Obsidian" dropbox:Obsidian && \
  rclone sync "$DOCUMENTS/Async" dropbox:Async && \
  rclone sync "$DOCUMENTS/Currículos" dropbox:Curriculos && \
  echo -e "${GREEN}✔ Documents successfully synced!${RESET}" || error
}

dtfcp() {
  echo -e "${BOLD_WHITE}Backing up dotfiles...${RESET}"

  cp "$HOME/.zshrc" "$DOTFILES/environments/linux/zsh/" && \
  cp -r "$HOME/.config/nvim/." "$DOTFILES/environments/linux/nvim/" && \
  cp "$HOME/.config/wezterm/wezterm.lua" "$DOTFILES/environments/linux/wezterm/" && \
  cp "$HOME/.config/fastfetch/config.jsonc" "$DOTFILES/environments/linux/fastfetch/" && \
  echo -e "${GREEN}✔ Dotfiles successfully backed up!${RESET}" || error
}

bkp() {
  echo -e "${BOLD_WHITE}Starting backup process...${RESET}"

  # Development folder
  echo -e "${BOLD_WHITE}Backing up Development folder...${RESET}"
  zip -qr /tmp/development.zip "$DEVELOPMENT" && \
  echo -e "${BOLD_WHITE}↑ Syncing Development folder with Dropbox...${RESET}" && \
  rclone sync /tmp/development.zip dropbox:Development && \
  rm /tmp/development.zip

  # Full backup
  local file="backup_$(date +%Y-%m-%d_%H-%M).zip"
  echo -e "${BOLD_WHITE}Creating $file...${RESET}"

  zip -qr "$HOME/$file" \
      "$HOME/.themes" \
      "$HOME/.icons" \
      "$DEVELOPMENT" \
      "$DOCUMENTS" \
      "$HOME/Downloads" \
      "$HOME/Pictures" \
      "$HOME/Music" \
      "$HOME/Videos"

  echo -e "${BOLD_WHITE}Moving backup to external drive...${RESET}"
  mv "$HOME/$file" /mnt/sda1/ && \
  local backup_size=$(du -h /mnt/sda1/"$file" | cut -f1) && \
  echo -e "${GREEN}✔ Backup completed: $file (${backup_size})${RESET}" || error
}

# Backup script of Clipboard Indicator favorites
# Date format: $(date +"%Y-%m-%d %H:%M:%S")
clipboard_backup() {
  REGISTRY_FILE="$HOME/.cache/clipboard-indicator@tudmotu.com/registry.txt"
  BACKUP_DIR="$DEVELOPMENT"
  BACKUP_FILE="$BACKUP_DIR/clipboard-favorites-$(date +%Y%m%d-%H%M%S).txt"
  LATEST_BACKUP="$BACKUP_DIR/clipboard-favorites-LATEST.txt"

  echo -e "${BOLD_WHITE}Backing up Clipboard favorites (Date: $(date)) ${RESET}"

  if ! command -v jq >/dev/null; then
      echo "ERROR: Install jq to process multiline favorites."
      exit 1
  fi

  if [ ! -f "$REGISTRY_FILE" ]; then
      echo "ERROR: Registry file not found at $REGISTRY_FILE"
      exit 1
  fi

  echo "Extracting favorites..."

  FAVORITES=$(jq -r '.[] | select(.favorite == true) | .contents' "$REGISTRY_FILE" 2>/dev/null)

  if [ -z "$FAVORITES" ]; then
      echo "No favorites found."
      echo "Make sure you have items starred."
      exit 0
  fi

  COUNT=$(echo "$FAVORITES" | grep -c '.')
  echo "Favorites found: $COUNT"

  echo "=== CURRENT FAVORITES ===" > "$BACKUP_FILE"
  echo "Backup date: $(date)" >> "$BACKUP_FILE"
  echo "" >> "$BACKUP_FILE"

  echo "=== CURRENT FAVORITES ===" > "$LATEST_BACKUP"
  echo "Backup date: $(date)" >> "$LATEST_BACKUP"
  echo "" >> "$LATEST_BACKUP"

  COUNTER=1
  echo "$FAVORITES" | while IFS= read -r CONTENT; do
      if [ -n "$CONTENT" ]; then
          echo "$COUNTER. $CONTENT" >> "$BACKUP_FILE"
          echo "$COUNTER. $CONTENT" >> "$LATEST_BACKUP"
          COUNTER=$((COUNTER + 1))
      fi
  done

  echo "Timestamped backup file saved to: $BACKUP_FILE"
  echo "Latest backup file updated: $LATEST_BACKUP"

  ls -t "$BACKUP_DIR"/clipboard-favorites-*.txt | tail -n +3 | xargs rm -f 2>/dev/null

  echo -e "${GREEN}✔ Backup successfully finished!${RESET}" || error
}
