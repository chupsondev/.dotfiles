# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="chupson"

plugins=(git zsh-autosuggestions sudo web-search vscode)

source $ZSH/oh-my-zsh.sh

# My aliases
source ~/.aliasrc

export PATH=$PATH:/home/chupson/.spicetify
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.local/scripts
export PATH=$PATH:/Users/chupson/Library/Python/3.11/bin
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# Ensure XDG_CONFIG_HOME is set (on macOS specifically, I think it should be set everywhere else already)
export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR="nvim"

export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=1000000
export HISTSIZE=1000000

setopt extended_history
setopt share_history

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
