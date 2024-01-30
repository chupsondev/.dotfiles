# vim:ft=zsh

PROMPT='%{$fg_bold[yellow]%}╭%{$fg_bold[green]%}%n:%{$fg[cyan]%}%2~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}'

PROMPT+='
%{$fg_bold[yellow]%}╰%(?.%{$fg_bold[yellow]%}.%{$fg_bold[red]%})$%{$reset_color%} ' 


ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
