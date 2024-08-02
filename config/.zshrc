export ZSH=$HOME/.zsh
export GPG_TTY=$(tty)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
