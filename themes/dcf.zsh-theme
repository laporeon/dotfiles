function node_prompt_version {
    if which node &> /dev/null; then
        echo "via %{$fg_bold[green]%}$(node -v)%{$reset_color%}"
    fi
}

PROMPT='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info) $(node_prompt_version)
%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[red]%}❯ )'

ZSH_THEME_GIT_PROMPT_PREFIX="on %{$fg_bold[blue]%}git:(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}[!]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
