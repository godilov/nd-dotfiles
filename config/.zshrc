export ZSH=$HOME/.zsh

source $ZSH/oh-my-zsh.sh

function man {
    MANWIDTH=$((COLUMNS - 1)) /usr/bin/man "$@"
}

eval "$(starship init zsh)"
