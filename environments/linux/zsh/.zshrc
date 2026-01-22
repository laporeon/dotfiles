# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:/usr/sbin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ===== THEME AND COLORS ===== #
ZSH_THEME="dcf"
LS_COLORS=$LS_COLORS:'ow=02;34:' ; export LS_COLORS

# ===== PLUGINS ===== #
plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh
source $HOME/Development/dotfiles/helpers/updates.sh

# ===== HISTORY CONFIGURATION ===== #
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS

# ===== ALIASES ===== #

# Directories
alias ..="cd .."
alias ....="cd ../.."
alias dev="cd ~/Development"
alias projects="cd ~/Development/Projects"
alias studies="cd ~/Development/Studies"
alias dwl="cd ~/Downloads"
alias docs="cd ~/Documents"
# Personal scripts
alias dtf="code ~/Development/dotfiles"
alias commit="bash ~/Development/dotfiles/helpers/conventional-commits.sh"
alias zshr="source ~/.zshrc"
alias zcp="cp ~/.zshrc ~/Development/dotfiles/environments/linux/zsh/"
alias wztcp="cp ~/.config/wezterm/wezterm.lua ~/Development/dotfiles/environments/linux/wezterm/"
alias clsn="rm -rf node_modules/"
alias clsg="rm -rf .git/"
alias kpsxc="sed -n '1p' ~/Documents/setup.txt | tr -d '[:space:]' | xclip -selection clipboard"
alias ente="sed -n '2p' ~/Documents/setup.txt | tr -d '[:space:]' | xclip -selection clipboard"
alias ytd="yt-dlp -f \"bv*+ba/b\" --merge-output-format mp4 -o \"%(title)s.%(ext)s\""
alias obsidian="rclone sync ~/Documents/Obsidian dropbox:Obsidian"
alias async="rclone sync ~/Documents/Async dropbox:Async"
alias cv="rclone sync ~/Documents/Currículos dropbox:Curriculos"
alias bdev='zip -r ~/development.zip ~/Development && rclone sync ~/development.zip dropbox:Development'
alias bkp='zip -r ~/backup_$(date +%Y-%m-%d).zip ~/Development ~/Documents ~/Pictures ~/Music ~/Videos && mv backup_$(date +%Y-%m-%d).zip /mnt/sda1/'
alias udisc=update_discord
alias ubruno=update_bruno
alias udbeaver=update_dbeaver
alias clp="bash ~/Development/dotfiles/helpers/clipboard-backup.sh"
alias dbstart="sudo systemctl start postgresql mysql mongod"
alias dbstop="sudo systemctl stop postgresql mysql mongod"
# Manage packages
alias sdi="sudo dpkg -i"
alias sapt="sudo apt install"
alias spg="sudo apt purge --auto-remove"
alias upd="sudo apt update"
alias upg="sudo apt upgrade -y"
# Config files
alias zshc="nvim ~/.zshrc"
alias gitc="nvim ~/.gitconfig"
alias bashc="nvim ~/.bashrc"
alias nvimc="nvim ~/.config/nvim"
alias wztc="nvim ~/.config/wezterm/wezterm.lua"

# ===== ZI INSTALLATION CHECK ===== #
if [[ ! -f "$HOME/.zi/bin/zi.zsh" ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zi/bin/zi.zsh"

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light marlonrichert/zsh-autocomplete

# ===== ZSH-AUTOCOMPLETE CONFIGURATIONS ===== #
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':autocomplete:*' min-input 1
bindkey '^I' expand-or-complete
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#566573'

# ===== ENVIRONMENT ===== #
unsetopt PROMPT_SP

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64";
# export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64";
# export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64";
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64";
export PATH=$JAVA_HOME/bin:$PATH

