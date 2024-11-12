#!/bin/bash

YELLOW="\033[1;33m";
RESET_COLOR="\033[0m";

sudo apt update

echo -e "\n${YELLOW}Installing ZSH:${RESET_COLOR}"
sudo apt install zsh -y

echo -e "\n${YELLOW}Installing Oh My ZSH:${RESET_COLOR}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"