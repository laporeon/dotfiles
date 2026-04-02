export ZSH="$HOME/.oh-my-zsh"

# ===== APPEARANCE AND PLUGINS ===== #
ZSH_THEME="lambda"
PROMPT_EOL_MARK=""
export LS_COLORS="$LS_COLORS:ow=02;34"
plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

# ===== HISTORY ===== #
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt AUTO_MENU SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_FIND_NO_DUPS CORRECT HIST_VERIFY AUTO_CD

# ===== CUSTOM COMMANDS ===== #
source $HOME/Development/dotfiles/helpers/commands.sh
# ===== ALIASES  ===== #
alias dev="cd ~/Development"
alias pjs="cd ~/Development/Projects"
alias dtf="code ~/Development/dotfiles"
alias commit="bash ~/Development/dotfiles/helpers/conventional-commits.sh"
alias zshr="source ~/.zshrc && echo '✔ zshrc reloaded'"
alias clsn="rm -rf node_modules/"
alias clsg="rm -rf .git/"
alias kpsxc="sed -n '1p' ~/Documents/setup.txt | tr -d '[:space:]' | xclip -selection clipboard"
alias ente="sed -n '2p' ~/Documents/setup.txt | tr -d '[:space:]' | xclip -selection clipboard"
alias ytd="yt-dlp -f \"bv*+ba/b\" --merge-output-format mp4 -o \"%(title)s.%(ext)s\""
alias dbup="sudo systemctl start postgresql mysql mongod"
alias dbdn="sudo systemctl stop postgresql mysql mongod"
alias dki="sudo dpkg -i"
alias ins="sudo apt install -y"
alias prg="sudo apt purge --auto-remove"
alias upd="sudo apt update"
alias upg="sudo apt upgrade -y"
alias zshc="nvim ~/.zshrc"

# ===== ZI INSTALLATION CHECK ===== #
if [[ ! -f "$HOME/.zi/bin/zi.zsh" ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zi/bin/zi.zsh"

zi light-mode for \
    zdharma/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions
autoload -Uz compinit && compinit -C

# ===== ENVIRONMENT ===== #
# export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64";
# export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64";
# export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64";
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
export MAVEN_HOME="/opt/maven"

export PATH="$HOME/bin:/usr/local/bin:$JAVA_HOME/bin:$MAVEN_HOME/bin:/usr/sbin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
