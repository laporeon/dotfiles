PROMPT='%{$fg_bold[green]%}⬢  %{$fg_bold[yellow]%}%c $(git_prompt_info)%{$reset_color%}'
PROMPT+='%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[red]%}❯ )'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=" "
