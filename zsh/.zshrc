# My aliases
source ~/.aliasrc

export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=1000000
export HISTSIZE=1000000

setopt extended_history
setopt share_history

autoload -U compinit && compinit -u
autoload -U colors && colors

zstyle ':completion:*' menu select
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Prompt
source ~/.zsh/gitstatus/gitstatus.plugin.zsh
function gitstatus_prompt_update() {
    emulate -L zsh
    typeset -g  GITSTATUS_PROMPT=''
    typeset -gi GITSTATUS_PROMPT_LEN=0

    gitstatus_query 'MY'                  || return 1  # error
    [[ $VCS_STATUS_RESULT == 'ok-sync' ]] || return 0  # not a git repo

    local p
    p+="%{$fg_bold[blue]%}("

    local where  # branch name, tag or commit
    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
        where=$VCS_STATUS_LOCAL_BRANCH
    elif [[ -n $VCS_STATUS_TAG ]]; then
        p+='%f#'
        where=$VCS_STATUS_TAG
    else
        p+='%f@'
        where=${VCS_STATUS_COMMIT[1,8]}
    fi

    (( $#where > 32 )) && where[13,-13]="…"  # truncate long branch names and tags
    p+="%{$fg[red]%}${where//\%/%%}"             # escape %

  # ⇣42 if behind the remote.
  (( VCS_STATUS_COMMITS_BEHIND )) && p+=" %{$fg[red]%}⇣${VCS_STATUS_COMMITS_BEHIND}"
  # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
  (( VCS_STATUS_COMMITS_AHEAD  )) && p+="%{$fg[red]%}⇡${VCS_STATUS_COMMITS_AHEAD}"

  p+="%{$fg_bold[blue]%})"

  if [[ $VCS_STATUS_NUM_CONFLICTED -gt 0 || $VCS_STATUS_NUM_STAGED -gt 0 || $VCS_STATUS_NUM_UNSTAGED -gt 0 || $VCS_STATUS_NUM_UNTRACKED -gt 0 ]]; then
      p+=" %{$fg[yellow]%}✗"
  fi

  GITSTATUS_PROMPT="${p}%f"
}

# Start gitstatusd instance with name "MY". The same name is passed to
# gitstatus_query in gitstatus_prompt_update. The flags with -1 as values
# enable staged, unstaged, conflicted and untracked counters.
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
autoload -Uz add-zsh-hook
add-zsh-hook precmd gitstatus_prompt_update
setopt no_prompt_bang prompt_percent prompt_subst


PROMPT='%{$fg_bold[yellow]%}╭%{$fg_bold[green]%}%n@%m:%{$fg[cyan]%}%2~ ${GITSTATUS_PROMPT}'

PROMPT+='
%{$fg_bold[yellow]%}╰%(?.%{$fg_bold[yellow]%}.%{$fg_bold[red]%})$%{$reset_color%} ' 

export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.local/scripts
export PATH=$PATH:/Users/chupson/Library/Python/3.11/bin
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# Ensure XDG_CONFIG_HOME is set (on macOS specifically, I think it should be set everywhere else already)
export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR="nvim"

# Make global settings
export CXXFLAGS="-std=c++17 -O2 -Wall"
export CXX=g++

# fzf
export FZF_TMUX_OPTS='-p'
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# fcd (for more see the file)
source $HOME/.local/scripts/fcd

# Keymappings
bindkey -s "^f" 'tmux-session-manager\n'

export GPG_TTY=$(tty)

# If on Linux, set ssh-agent socket to the one started by systemctl
if [[ $(uname -s) == "Linux" && $(uname -n) != "chupson-server" ]]; then
    SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket; export SSH_AUTH_SOCK;
fi

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 
