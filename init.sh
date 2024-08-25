#!/bin/bash

DIR=$(pwd)
DIR_DEPS=$DIR/deps
DIR_CONFIG=$DIR/config

ENSURED=false

function install-pkg {
    paru -S --needed $(cat $1 | grep -E --color=never "^[a-zA-Z0-9_-]+$")
}

function rm-link {
    [[ -L "$1" ]] && rm -v $1
}

function ensure-git {
    [[ -d $1 ]] || git clone $2 $1
    
    echo Update $1

    cd $1

    git pull

    cd -
}

function ensure-dir {
    [[ -d $1 ]] || mkdir -p $dest
}

function ensure-deps {
    if [ "$ENSURED" = true ]; then
        return
    fi

    ensure-git $DIR_DEPS/paru https://aur.archlinux.org/paru.git
    ensure-git $DIR_DEPS/refind https://github.com/bobafetthotmail/refind-theme-regular.git
    ensure-git $DIR_DEPS/tpm https://github.com/tmux-plugins/tpm.git
    ensure-git $DIR_DEPS/omz https://github.com/ohmyzsh/ohmyzsh.git

    ENSURED=true
}

function link-config {
    src=$1
    srcf=$2
    dest=$3
    destf=$4

    ensure-dir $dest

    rm-link $dest/$destf

    ln -sf $src/$srcf $dest/$destf
}

function link-config-arr {
    src=$1
    dest=$2

    shift 2

    for config in "$@"
    do
        ensure-dir $dest

        rm-link $dest/$config

        ln -sf $src/$config $dest/$config
    done
}

function link-tmux {
    ensure-deps

    link-config-arr $DIR_CONFIG ~ .tmux.conf

    ensure-dir ~/.tmux/plugins/

    link-config-arr $DIR_DEPS ~/.tmux/plugins tpm
}

function link-zsh {
    ensure-deps

    link-config-arr $DIR_CONFIG ~ .zshrc

    link-config $DIR_DEPS omz ~ .zsh
    link-config $DIR_CONFIG .profile ~ .zprofile
}

function init-all-pkg {
    cat pkg/libs pkg/dev pkg/cli pkg/apps > pkg/all

    install-pkg pkg/all
}

function init-all-cfg {
    link-config-arr $DIR_CONFIG ~/.config alacritty.toml bat btop glow brave-flags.conf mpv nvim starship.toml xplr
    link-config-arr $DIR_CONFIG ~ .profile .gitconfig

    link-tmux
    link-zsh
}

for arg in "$@"
do
    case $arg in
        "all")
            init-all-pkg
            init-all-cfg
            ;;
        "all-pkg")
            init-all-pkg;;
        "all-cfg")
            init-all-cfg;;
        "deps")
            ensure-deps;;
        "libs")
            install-pkg pkg/libs;;
        "dev")
            install-pkg pkg/dev;;
        "cli")
            install-pkg pkg/cli;;
        "apps")
            install-pkg pkg/apps;;
        "amd")
            install-pkg pkg/v_amd;;
        "nvidia")
            install-pkg pkg/v_nvidia;;
        "games")
            install-pkg pkg/games

            link-config-arr $DIR_CONFIG ~/.config retroarch MangoHud gamemode
            ;;
        "env")
            link-config-arr $DIR_CONFIG ~ .profile;;
        "git")
            link-config-arr $DIR_CONFIG ~ .gitconfig;;
        "tmux")
            link-tmux;;
        "zsh")
           link-zsh;;
        "gnome")
            install-pkg pkg/wm_gnome;;
        "hypr")
            link-config-arr $DIR_CONFIG ~/.config hypr waybar

            install-pkg pkg/wm_hyprland
            ;;
        "nvim")
            link-config-arr $DIR_CONFIG ~/.config nvim;;
        "alacritty")
            link-config-arr $DIR_CONFIG ~/.config alacritty.toml;;
        "bat")
            link-config-arr $DIR_CONFIG ~/.config bat;;
        "btop")
            link-config-arr $DIR_CONFIG ~/.config btop;;
        "glow")
            link-config-arr $DIR_CONFIG ~/.config glow;;
        "brave")
            link-config-arr $DIR_CONFIG ~/.config brave-flags.conf;;
        "mpv")
            link-config-arr $DIR_CONFIG ~/.config mpv;;
        "retroarch")
            link-config-arr $DIR_CONFIG ~/.config retroarch;;
        "starship")
            link-config-arr $DIR_CONFIG ~/.config starship.toml;;
        "xplr")
            link-config-arr $DIR_CONFIG ~/.config xplr;;
        *)
            echo No args;;
    esac
done
