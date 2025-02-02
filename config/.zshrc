export ZSH=$HOME/.zsh
export GPG_TTY=$(tty)

source $ZSH/oh-my-zsh.sh

open() {
    xdg-open $@
}

man() {
    MANWIDTH=$((COLUMNS - 1)) /usr/bin/man "$@"
}

fetch() {
    macchina -t Lithium
}

eval "$(starship init zsh)"
