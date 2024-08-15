export ZSH=$HOME/.zsh
export GPG_TTY=$(tty)

source $ZSH/oh-my-zsh.sh

function man {
    MANWIDTH=$((COLUMNS - 1)) /usr/bin/man "$@"
}

eval "$(starship init zsh)"
