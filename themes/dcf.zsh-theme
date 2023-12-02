PROMPT='%{$fg_bold[green]%}⬢  %{$fg_bold[yellow]%}%c $(git_prompt_info)%{$reset_color%}'
PROMPT+='%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[red]%}❯ )'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}[!]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
