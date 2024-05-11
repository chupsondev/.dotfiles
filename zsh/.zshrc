# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="chupson"

plugins=(git zsh-autosuggestions sudo web-search vscode)

source $ZSH/oh-my-zsh.sh

# https://github.com/nvbn/thefuck
eval $(thefuck --alias)

# My aliases
source ~/.aliasrc

export PATH=$PATH:/home/chupson/.spicetify
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.local/scripts
export PATH=$PATH:/Users/chupson/Library/Python/3.11/bin
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# Ensure XDG_CONFIG_HOME is set (on macOS specifically, I think it should be set everywhere else already)
export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR="nvim -u $HOME/.config/nvim/init.lua" 

export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=1000000


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

setopt extended_history
setopt share_history

# Keymappings
bindkey -s "^f" 'tmux-session-manager\n'


COWPATH="$HOME/.cowsay/cowfiles"
# Cow-spoken fortunes every time you open a terminal
function cowsayfortune {
    NUMOFCOWS=`cowsay -l | tail -n +2 | wc -w`
    WHICHCOW=$((RANDOM%$NUMOFCOWS+1))
    THISCOW=`cowsay -l | tail -n +2 | sed -e 's/\ /\'$'\n/g' | sed $WHICHCOW'q;d'`

    #echo "Selected cow: ${THISCOW}, from ${WHICHCOW}"
    fortune | cowsay -f $THISCOW -W 100
}

function randompokemon {
    pokemon-colorscripts -r --no-title
}

randompokemon
# cowsayfortune

export GPG_TTY=$(tty)

# pnpm
export PNPM_HOME="/Users/chupson/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

