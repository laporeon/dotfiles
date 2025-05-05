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

# Directories
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
alias dtf="code ~/Development/dotfiles"
alias commit="bash ~/Development/conventional-commits.sh"
alias zshr="source ~/.zshrc"
alias zcp="cp -r ~/.zshrc ~/Development/dotfiles/linux/zsh"
alias clsn="rm -rf node_modules/"
alias clsg="rm -rf .git/"
alias kpsxc="sed -n '1p' ~/Documents/setup.txt | tr -d '[:space:]' | xclip -selection clipboard"
alias ente="sed -n '2p' ~/Documents/setup.txt | tr -d '[:space:]' | xclip -selection clipboard"
alias obscam="sudo modprobe -r v4l2loopback"
alias ytd="yt-dlp -f \"bv*+ba/b\" --merge-output-format mp4 -o \"%(title)s.%(ext)s\""
alias apps="bash ~/Development/appsupdater.sh"
alias obsidian="rclone sync ~/Documents/Obsidian dropbox:Obsidian"
alias async="rclone copy -u ~/Documents/Async dropbox:Async"
# Manage packages
alias sdi="sudo dpkg -i"
alias sapt="sudo apt install"
alias spg="sudo apt purge --auto-remove"
alias upd="sudo apt update"
alias upgradable="apt list --upgradable"
alias upg="sudo apt upgrade -y"
# Config files
alias zshc="nvim ~/.zshrc"
alias gitc="nvim ~/.gitconfig"
alias bashc="nvim ~/.bashrc"
alias nvimc="nvim ~/.config/nvim"

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
