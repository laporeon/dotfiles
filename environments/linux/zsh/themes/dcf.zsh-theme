setopt prompt_subst

GREEN="%{$fg_bold[green]%}"
YELLOW="%{$fg_bold[yellow]%}"
CYAN="%{$fg_bold[cyan]%}"
RED="%{$fg_bold[red]%}"
RESET="%{$reset_color%}"

PROMPT="${GREEN}⬢  ${YELLOW}%c \$(git_prompt_info)${GREEN}❯ ${RESET}"

ZSH_THEME_GIT_PROMPT_PREFIX="${CYAN}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY=" ${RED}[?]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
