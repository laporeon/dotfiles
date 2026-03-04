setopt prompt_subst

CYAN="%{$fg_bold[cyan]%}"
YELLOW="%{$fg_bold[yellow]%}"
WHITE="%{$fg_bold[white]%}"
RED="%{$fg_bold[red]%}"
RESET="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="${CYAN}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY=" ${RED}[?]"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT="${WHITE}λ ${YELLOW}%c \$(git_prompt_info)${WHITE}› ${RESET}"
