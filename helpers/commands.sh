#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'
BOLD_WHITE='\033[1;37m'

DOCUMENTS="$HOME/Documents"
DEVELOPMENT="$HOME/Development"
DOTFILES="$HOME/Development/dotfiles"

# ===== INSTALLATIONS / UPDATE ===== #
install_jetbrains_font() {
  echo -e "${BOLD_WHITE}Installing JetBrains Mono NerdFont...${RESET}"

  command -v ttx >/dev/null 2>&1 || { echo >&2 "fonttools/ttx not installed. Run: sudo apt install fonttools"; return 1; }

  local tmp_dir
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' RETURN

  curl -fLo "$tmp_dir/JetBrainsMonoNerdFont.zip" \
    "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

  unzip -q "$tmp_dir/JetBrainsMonoNerdFont.zip" -d "$tmp_dir/fonts"

  shopt -s nullglob
  for fontfile in "$tmp_dir/fonts"/*.ttf; do
    local base
    base="$(basename "$fontfile")"
    echo "Processing: $base"

    ttx -q "$fontfile"
    local ttxfile="${fontfile%.ttf}.ttx"

    sed -i \
      -e 's/JetBrainsMono Nerd Font/JetBrains Mono/g' \
      -e 's/JetBrainsMonoNerdFont/JetBrainsMono/g' \
      -e 's/JetBrainsMono NF/JetBrains Mono/g' \
      "$ttxfile"

    ttx -q -m "$fontfile" "$ttxfile"

    local newfont="${fontfile%.ttf}#1.ttf"
    if [[ -f "$newfont" ]]; then
      mv "$newfont" "$tmp_dir/fonts/$base"
    fi
    rm -f "$ttxfile"
  done
  shopt -u nullglob

  sudo cp "$tmp_dir/fonts"/*.ttf /usr/share/fonts/
  sudo fc-cache -fv

  echo -e "${GREEN}✔ JetBrains Mono NerdFont successfully installed!${RESET}"
}

update_discord() {
  echo -e "${BOLD_WHITE}Updating Discord...${RESET}"
  curl -fL "https://discord.com/api/download/stable?platform=linux&format=deb" -o /tmp/discord.deb
  sudo dpkg -i /tmp/discord.deb || { sudo apt -f install -y; sudo dpkg -i /tmp/discord.deb; }
  rm -f /tmp/discord.deb
  echo -e "${GREEN}✔ Discord successfully updated!${RESET}"
}

update_bruno() {
  echo -e "${BOLD_WHITE}Updating Bruno...${RESET}"
  local bruno_url=$(curl -s https://api.github.com/repos/usebruno/bruno/releases/latest | grep -o 'https://[^"]*_amd64_linux\.deb' | head -n1)
  curl -fL "$bruno_url" -o /tmp/bruno.deb
  sudo dpkg -i /tmp/bruno.deb || { sudo apt -f install -y; sudo dpkg -i /tmp/bruno.deb; }
  rm -f /tmp/bruno.deb
  echo -e "${GREEN}✔ Bruno successfully updated!${RESET}"
}

update_dbeaver() {
  echo -e "${BOLD_WHITE}Updating DBeaver...${RESET}"
  curl -fL "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" -o /tmp/dbeaver.deb
  sudo dpkg -i /tmp/dbeaver.deb || { sudo apt -f install -y; sudo dpkg -i /tmp/dbeaver.deb; }
  rm -f /tmp/dbeaver.deb
  echo -e "${GREEN}✔ DBeaver successfully updated!${RESET}"
}

# =========== BACKUPS AND SYNCHRONIZATIONS ========== #

lsync() {
  echo -e "${BOLD_WHITE}Syncing config files...${RESET}"

  mkdir -p "$HOME"/.config/{nvim,wezterm,fastfetch}

  cp -r "$DOTFILES/environments/linux/nvim" "$HOME/.config/"
  cp -r "$DOTFILES/environments/linux/wezterm" "$HOME/.config/"
  cp -r "$DOTFILES/environments/linux/fastfetch" "$HOME/.config/"
  cp "$DOTFILES/environments/linux/zsh/.zshrc" "$HOME/"
  cp "$DOTFILES/environments/linux/zsh/themes/"*.zsh-theme "$HOME/.oh-my-zsh/themes/"
  echo -e "${GREEN}✔ Configuration files successfully synced!${RESET}"
}

dsync() {
  echo -e "${BOLD_WHITE}↑ Syncing documents with Dropbox...${RESET}"
  rclone sync "$DOCUMENTS/Obsidian" dropbox:Obsidian --exclude ".trash/**"
  rclone sync "$DOCUMENTS/Async" dropbox:Async
  rclone sync "$DOCUMENTS/Currículos" dropbox:Curriculos
  echo -e "${GREEN}✔ Documents successfully synced!${RESET}"
}

dtfcp() {
  echo -e "${BOLD_WHITE}Backing up dotfiles...${RESET}"
  cp "$HOME/.zshrc" "$DOTFILES/environments/linux/zsh/"
  cp -r "$HOME/.config/nvim/." "$DOTFILES/environments/linux/nvim/"
  cp "$HOME/.config/wezterm/wezterm.lua" "$DOTFILES/environments/linux/wezterm/"
  cp "$HOME/.config/fastfetch/config.jsonc" "$DOTFILES/environments/linux/fastfetch/"
  echo -e "${GREEN}✔ Dotfiles successfully backed up!${RESET}"
}

bkp() {
  echo -e "${BOLD_WHITE}Starting backup process...${RESET}"

  # Development folder
  echo -e "${BOLD_WHITE}Backing up Development folder...${RESET}"
  zip -qr /tmp/development.zip "$DEVELOPMENT"
  echo -e "${BOLD_WHITE}↑ Syncing Development folder with Dropbox...${RESET}"
  rclone sync /tmp/development.zip dropbox:Development
  rm -f /tmp/development.zip

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
      "$HOME/Videos" \
      -x "*/node_modules/*"

  local mount_dir="/mnt/sda1"

  echo -e "${BOLD_WHITE}Moving backup to external drive...${RESET}"
  mv "$HOME/$file" "$mount_dir/"
  local backup_size=$(du -h "$mount_dir/$file" | cut -f1)
  echo -e "${GREEN}✔ Backup completed: $file (${backup_size})${RESET}"
}

clipboard_backup() {
  command -v jq >/dev/null 2>&1 || { echo -e "${RED}Missing dependency: 'jq'. Run: sudo apt install jq${RESET}"; return 1; }

  local REGISTRY_FILE="$HOME/.cache/clipboard-indicator@tudmotu.com/registry.txt"
  local BACKUP_DIR="$DEVELOPMENT"
  local BACKUP_FILE="$BACKUP_DIR/clipboard-favorites-$(date +%Y%m%d-%H%M%S).txt"
  local LATEST_BACKUP="$BACKUP_DIR/clipboard-favorites-LATEST.txt"

  echo -e "${BOLD_WHITE}Backing up Clipboard favorites (Date: $(date)) ${RESET}"

  [[ -f "$REGISTRY_FILE" ]] || { echo -e "${RED}ERROR: Registry file not found at $REGISTRY_FILE${RESET}"; return 1; }

  echo "Extracting favorites..."

  local favorites
  favorites="$(jq -er '.[] | select(.favorite == true) | .contents' "$REGISTRY_FILE" 2>/dev/null)" || {
    echo -e "${RED}ERROR: could not parse registry or filter favorites (format changed?)${RESET}"
    return 1
  }

  [[ -n "$favorites" ]] || { echo "No favorites found."; return 0; }

  {
    echo "=== CURRENT FAVORITES ==="
    echo "Backup date: $(date)"
    echo
  } > "$BACKUP_FILE"

  cp "$BACKUP_FILE" "$LATEST_BACKUP"

  local counter=1
  while IFS= read -r content; do
    [[ -n "$content" ]] || continue
    printf "%s. %s\n" "$counter" "$content" >> "$BACKUP_FILE"
    printf "%s. %s\n" "$counter" "$content" >> "$LATEST_BACKUP"
    counter=$((counter + 1))
  done <<< "$favorites"

  echo "Timestamped backup file saved to: $BACKUP_FILE"
  echo "Latest backup file updated: $LATEST_BACKUP"

  ls -t "$BACKUP_DIR"/clipboard-favorites-*.txt 2>/dev/null | tail -n +3 | xargs -r rm -f

  echo -e "${GREEN}✔ Backup successfully finished!${RESET}"
}

cleanup_system() {
  echo -e "${BOLD_WHITE}Starting system cleanup...${RESET}"

  echo -e "${BOLD_WHITE}Updating package lists...${RESET}"
  sudo apt update -y

  echo -e "${BOLD_WHITE}Removing orphaned packages...${RESET}"
  sudo apt autoremove -y --purge

  echo -e "${BOLD_WHITE}Cleaning APT cache...${RESET}"
  sudo apt clean

  echo -e "${BOLD_WHITE}Removing old snap revisions...${RESET}"
  if command -v snap >/dev/null 2>&1; then
    snap list --all | awk '/disabled/{print $1, $3}' | while read -r name revision; do
      sudo snap remove "$name" --revision="$revision" || true
    done
  else
    echo -e "${BOLD_WHITE}snap not found, skipping...${RESET}"
  fi

  echo -e "${BOLD_WHITE}Removing temporary files (safe)...${RESET}"
  sudo find /tmp -mindepth 1 -maxdepth 1 -exec rm -rf -- {} + 2>/dev/null || true
  sudo find /var/tmp -mindepth 1 -maxdepth 1 -exec rm -rf -- {} + 2>/dev/null || true

  echo -e "${BOLD_WHITE}Vacuuming old logs (keeping last 7 days)...${RESET}"
  sudo journalctl --vacuum-time=7d

  echo -e "${BOLD_WHITE}Dropping RAM cache (optional)...${RESET}"
  if [[ "${DROP_CACHES:-0}" == "1" ]]; then
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
  else
    echo -e "${BOLD_WHITE}Skipping drop_caches (set DROP_CACHES=1 to enable).${RESET}"
  fi

  echo -e "${GREEN}✔ Cleanup complete!${RESET}"
}
