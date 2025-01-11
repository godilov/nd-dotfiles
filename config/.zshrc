export ZSH=$HOME/.zsh
export GPG_TTY=$(tty)

source $ZSH/oh-my-zsh.sh

function man {
    MANWIDTH=$((COLUMNS - 1)) /usr/bin/man "$@"
}

function fetch() {
    macchina -t Lithium
}

eval "$(starship init zsh)"
