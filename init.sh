#!/bin/bash

DIR=$(pwd)

function install-pkg {
    paru -S --needed $(cat $1 | grep -E --color=never "^[a-zA-Z0-9_-]+$")
}

function install-ext {
    rm -rf ext/paru
    rm -rf ext/refind

    git clone git@github.com:Morganamilo/paru.git ext/paru
    git clone git@github.com:bobafetthotmail/refind-theme-regular.git ext/refind
}

function install-ext-nd {
    rm -rf ext/nd

    git clone git@github.com:godilov/nd-dotfiles-lib.git ext/nd/lib
    git clone git@github.com:godilov/nd-dotfiles-res.git ext/nd/res
    git clone git@github.com:godilov/nd-dotfiles-nvim.git ext/nd/nvim
    git clone git@github.com:godilov/nd-dotfiles-awesome.git ext/nd/awesome

    rm -rf ext/nd/res/ext/nd/*
    rm -rf ext/nd/nvim/ext/nd/*
    rm -rf ext/nd/awesome/ext/nd/*

    mkdir -p ext/nd/res/ext/nd
    mkdir -p ext/nd/nvim/ext/nd
    mkdir -p ext/nd/awesome/ext/nd

    ln -s ../../../lib ext/nd/res/ext/nd/lib
    ln -s ../../../lib ext/nd/nvim/ext/nd/lib
    ln -s ../../../lib ext/nd/awesome/ext/nd/lib

    ln -s ../../../res ext/nd/nvim/ext/nd/res
    ln -s ../../../res ext/nd/awesome/ext/nd/res
}

function install-config {
    for config in "$@"
    do
        rm -rf ~/.config/$config

        ln -sf $DIR/config/$config ~/.config/$config
    done
}

function install-config-home {
    for config in "$@"
    do
        rm -rf ~/$config

        ln -sf $DIR/config/$config ~/$config
    done
}

function install-nvim {
    [[ -d ext/nd/nvim ]] || install-ext-nd

    rm -rf ~/.config/nvim

    ln -sf $DIR/ext/nd/nvim ~/.config/nvim
}

function install-hypr {
    rm -rf ~/.config/hypr
    rm -rf ~/.config/waybar

    install-pkg pkg/wm_hyprland

    ln -sf $DIR/config/hypr ~/.config/hypr
    ln -sf $DIR/config/waybar ~/.config/waybar
}

function install-awesome {
    [[ -d ext/nd/awesome ]] || install-ext-nd

    rm -rf ~/.config/awesome

    install-pkg pkg/wm_awesome

    ln -sf $DIR/ext/nd/awesome ~/.config/awesome
}

for arg in "$@"
do
    case $arg in
        "all")
            cat pkg/dev pkg/cli pkg/fonts pkg/apps > pkg/all

            install-ext
            install-ext-nd

            install-pkg pkg/all
            install-nvim
            install-hypr
            install-awesome
            
            install-config alacritty bat btop mpv starship.toml environment.d retroarch
            install-config-home .gitconfig
            ;;
        "all-pkg")
            cat pkg/dev pkg/cli pkg/fonts pkg/apps > pkg/all

            install-pkg pkg/all
            ;;
        "ext")
            install-ext;;
        "ext-nd")
            install-ext-nd;;
        "dev")
            install-pkg pkg/dev;;
        "cli")
            install-pkg pkg/cli;;
        "fonts")
            install-pkg pkg/fonts;;
        "apps")
            install-pkg pkg/apps;;
        "amd")
            install-pkg pkg/v_amd;;
        "nvidia")
            install-pkg pkg/v_nvidia;;
        "git")
            install-config-home .gitconfig;;
        "nvim")
            install-nvim;;
        "hypr")
            install-hypr;;
        "awesome")
            install-awesome;;
        "alacritty")
            install-config alacritty;;
        "bat")
            install-config bat;;
        "btop")
            install-config btop;;
        "mpv")
            install-config mpv;;
        "starship")
            install-config starship.toml;;
        "env")
            install-config environment.d;;
        "retroarch")
            install-config retroarch;;
        *)
            echo No args;;
    esac
done
