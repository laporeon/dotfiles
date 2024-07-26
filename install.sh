#!/bin/bash

YELLOW="\033[1;33m";
RESET_COLOR="\033[0m";

sudo apt update

echo -e "\n${YELLOW}Installing Neovim:${RESET_COLOR}"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract --destination $HOME
./squashfs-root/AppRun --version 
sudo mv squashfs-root /
sudo ln -s $HOME/squashfs-root/AppRun /usr/bin/nvim


echo -e "\n${YELLOW}Installing Vim Plug:${RESET_COLOR}"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


echo -e "\n${YELLOW}Installing ZSH:${RESET_COLOR}"
sudo apt install zsh -y

echo -e "\n${YELLOW}Installing Oh My ZSH:${RESET_COLOR}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"