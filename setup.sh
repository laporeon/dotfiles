#!/bin/bash

BLUE="\033[1;34m"
RESET='\033[0m'

DEVELOPMENT="$HOME/Development"
DOTFILES="$HOME/Development/dotfiles"

echo -e "\n${BLUE}Installing JetBrains Mono NerdFont...${RESET}"
sudo cp -r $DOTFILES/assets/fonts/JetBrainsMonoNerdFont/*.ttf /usr/share/fonts/
sudo fc-cache -fv

echo -e "\n${BLUE}Copying nvim, zsh and custom theme configuration...${RESET}"
cp -r $DOTFILES/environments/linux/nvim $HOME/.config/nvim/
cp $DOTFILES/environments/linux/zsh/.zshrc $HOME/
cp $DOTFILES/environments/linux/zsh/themes/dcf.zsh-theme $HOME/.oh-my-zsh/themes/

echo -e "\n${BLUE}Copying conventional commits guide...${RESET}"
cp $DOTFILES/helpers/conventional-commits.sh $DEVELOPMENT

echo -e "\n${BLUE}Setup completed!${RESET}"
