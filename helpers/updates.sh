#!/bin/bash

GREEN='\033[0;32m'
BLUE="\033[1;34m"
RESET='\033[0m'

# ===== DISCORD UPDATE ===== #
update_discord() {
    echo -e "\n${BLUE}↑ Updating Discord...${RESET}"

    curl -sL "https://discord.com/api/download/stable?platform=linux&format=deb" -o /tmp/discord.deb
    sudo dpkg -i /tmp/discord.deb
    rm /tmp/discord.deb

    echo -e "${GREEN}✔ Discord successfully updated!${RESET}"
}

# ===== BRUNO UPDATE ===== #
update_bruno() {
    echo -e "\n${BLUE}↑ Updating Bruno...${RESET}"

    local bruno_url=$(curl -s https://api.github.com/repos/usebruno/bruno/releases/latest | grep -o 'https://[^"]*_amd64_linux\.deb' | head -n1)
    curl -sL "$bruno_url" -o /tmp/bruno.deb
    sudo dpkg -i /tmp/bruno.deb
    rm /tmp/bruno.deb

    echo -e "${GREEN}✔ Bruno successfully updated!${RESET}"
}

# ===== DBEAVER UPDATE ===== #
update_dbeaver() {
    echo -e "\n${BLUE}↑ Updating DBeaver...${RESET}"

    curl -sL "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" -o /tmp/dbeaver.deb
    sudo dpkg -i /tmp/dbeaver.deb
    rm /tmp/dbeaver.deb

    echo -e "${GREEN}✔ DBeaver successfully updated!${RESET}"
}
