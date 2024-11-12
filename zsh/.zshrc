# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:/usr/sbin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ===== THEME ===== #
ZSH_THEME="dcf"

LS_COLORS=$LS_COLORS:'ow=01;34:' ; export LS_COLORS

# ===== PLUGINS ===== #
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ===== ALIASES ===== #

# Changing Directories
alias ..="cd .."
alias ....="cd ../.."
alias dev="cd ~/Development"
alias projects="cd ~/Development/Projects"
alias studies="cd ~/Development/Studies"
alias downloads="cd ~/Downloads"
alias docs="cd ~/Documents"
alias temp="cd /tmp"
alias opt="cd /opt"
# Personal scripts
alias commit="bash ~/Development/conventional-commits.sh"
alias explorer="explorer.exe ."
alias refresh="source ~/.zshrc"
alias cleanup="rm -rf node_modules/"
alias findnodem="find . -name "node_modules" -type d -prune -print | xargs du -chs"
alias removenodem="find . -name "node_modules" -prune -exec rm -rf '{}' +"
alias secret="cat ~/Documents/secret.txt | tr -d '[:space:]' | xclip -selection clipboard"
alias sin="sudo dpkg -i"
# Update packages
alias supdate="sudo apt update"
alias upgradable="apt list --upgradable"
alias supgrade="sudo apt upgrade -y"
# Config files
alias zshc="nvim ~/.zshrc"
alias gitc="nvim ~/.gitconfig"
alias bashc="nvim ~/.bashrc"
alias nvimc="code ~/.config/nvim"

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Check if ZI is installed
if [[ ! -f "$HOME/.zi/bin/zi.zsh" ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

# ZI essential
source "$HOME/.zi/bin/zi.zsh"

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Hide % on start
unsetopt PROMPT_SP

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64";
# export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64";
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64";
# export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64";

export PATH=$JAVA_HOME/bin:$PATH
