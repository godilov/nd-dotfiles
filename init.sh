#!/bin/bash

DIR=$(pwd)

DIR_DEPS=$DIR/deps
DIR_EXT=$DIR/ext

DIR_BOOT=$DIR/root/boot
DIR_GLOBAL=$DIR/root/global
DIR_LOCAL=$DIR/root/local
DIR_CONFIG=$DIR_LOCAL/config

function mv-safe {
    if [[ -e $1/$2 ]]; then
        mv $1/$2 $1/_$2.bak
    fi
}

function install-pkg {
    paru -S --needed $(cat $1 | grep -E --color=never "^[a-zA-Z0-9_-]+$")
}

function clone {
    [[ -d $1 ]] || git clone $2 $1
}

function clone-deps {
    clone $DIR_DEPS/paru https://aur.archlinux.org/paru.git
    clone $DIR_DEPS/refind git@github.com:bobafetthotmail/refind-theme-regular.git
    clone $DIR_DEPS/tpm git@github.com:tmux-plugins/tpm.git
}

function link-config {
    src=$1
    srcf=$2
    dest=$3
    destf=$4

    mv-safe $dest $destf

    ln -sf $src/$srcf $dest/$destf
}

function link-config-arr {
    src=$1
    dest=$2

    shift 2

    for config in "$@"
    do
        mv-safe $dest $config

        ln -sf $src/$config $dest/$config
    done
}

function link-tmux {
    clone-deps

    link-config-arr $DIR_LOCAL ~ .tmux.conf

    mkdir -p ~/.tmux/plugins/

    link-config-arr $DIR_DEPS ~/.tmux/plugins tpm
}

function link-zsh {
    link-config-arr $DIR_LOCAL ~ .zshrc

    link-config $DIR_LOCAL .profile ~ .zprofile
}

function init-all-pkg {
    cat pkg/dev pkg/libs pkg/cli pkg/apps pkg/apps32 > pkg/all

    install-pkg pkg/all
}

function init-all-cfg {
    link-config-arr $DIR_CONFIG ~/.config alacritty.toml bat btop brave-flags.conf mpv retroarch starship.toml
    link-config-arr $DIR_LOCAL ~ .profile .gitconfig

    link-tmux
    link-zsh
}

mkdir -p ~/.config

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
            clone-deps;;
        "dev")
            install-pkg pkg/dev;;
        "cli")
            install-pkg pkg/cli;;
        "libs")
            install-pkg pkg/libs;;
        "apps")
            install-pkg pkg/apps;;
        "apps32")
            install-pkg pkg/apps32;;
        "amd")
            install-pkg pkg/v_amd;;
        "nvidia")
            install-pkg pkg/v_nvidia;;
        "env")
            link-config-arr $DIR_LOCAL ~ .profile;;
        "git")
            link-config-arr $DIR_LOCAL ~ .gitconfig;;
        "tmux")
            link-tmux;;
        "zsh")
           link-zsh;;
        "gnome")
            install-pkg pkg/wm_gnome;;
        "nvim")
            link-config-arr $DIR_EXT ~/.config nvim;;
        "awesome")
            link-config-arr $DIR_EXT ~/.config awesome

            install-pkg pkg/wm_shared pkg/wm_awesome
            ;;
        "hypr")
            link-config-arr $DIR_CONFIG ~/.config hypr waybar

            install-pkg pkg/wm_shared pkg/wm_hyprland
            ;;
        "alacritty")
            link-config-arr $DIR_CONFIG ~/.config alacritty.toml;;
        "bat")
            link-config-arr $DIR_CONFIG ~/.config bat;;
        "btop")
            link-config-arr $DIR_CONFIG ~/.config btop;;
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
