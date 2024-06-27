#!/bin/bash

mkdir -p ~/.config/nvim/
ln -sf $PWD/nvim ~/.config/nvim/

ln -sf $PWD/zsh/.zshrc ~/.zshrc

touch ~/.oh-my-zsh/themes/dcf.zsh-theme
ln -sf $PWD/themes/dcf.zsh-theme ~/.oh-my-zsh/themes/dcf.zsh-theme