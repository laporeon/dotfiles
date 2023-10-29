PROMPT='🚀 %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)
%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[red]%}❯ )'

ZSH_THEME_GIT_PROMPT_PREFIX="on %{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%}) "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""