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

function install-env {
    rm -rf ~/.config/environment.d

    ln -sf $DIR/config/environment.d ~/.config/environment.d
}

function install-nvim {
    if [[ -d ext/nd/nvim ]]
    then
        rm -rf ~/.config/nvim

        ln -sf $DIR/ext/nd/nvim ~/.config/nvim
    else
        install-ext-nd
    fi
}

function install-alacritty {
    rm -rf ~/.config/alacritty

    ln -sf $DIR/config/alacritty ~/.config/alacritty
}

function install-hypr {
    rm -rf ~/.config/hypr
    rm -rf ~/.config/waybar

    install-pkg pkg/wm_hyprland

    ln -sf $DIR/config/hypr ~/.config/hypr
    ln -sf $DIR/config/waybar ~/.config/waybar
}

function install-awesome {
    if [[ -d ext/nd/nvim ]]
    then
        rm -rf ~/.config/awesome

        install-pkg pkg/wm_awesome

        ln -sf $DIR/ext/nd/awesome ~/.config/awesome
    else
        install-ext-nd
    fi
}

if [[ "$*" == *"--all"* ]]
then
    cat pkg/dev pkg/shell pkg/fonts pkg/apps > pkg/all

    install-ext-nd

    install-pkg pkg/all
    install-env
    install-nvim
    install-alacritty
    install-hypr
    install-awesome
fi

if [[ "$*" == *"--ext"* ]]
then
    install-ext
fi

if [[ "$*" == *"--ext-nd"* ]]
then
    install-ext-nd
fi

if [[ "$*" == *"--dev"* ]]
then
    install-pkg pkg/dev
fi

if [[ "$*" == *"--shell"* ]]
then
    install-pkg pkg/shell
fi

if [[ "$*" == *"--fonts"* ]]
then
    install-pkg pkg/fonts
fi

if [[ "$*" == *"--apps"* ]]
then
    install-pkg pkg/apps
fi

if [[ "$*" == *"--amd"* ]]
then
    install-pkg pkg/v_amd
fi

if [[ "$*" == *"--nvidia"* ]]
then
    install-pkg pkg/v_nvidia
fi

if [[ "$*" == *"--env"* ]]
then
    install-env
fi

if [[ "$*" == *"--nvim"* ]]
then
    install-nvim
fi

if [[ "$*" == *"--alacritty"* ]]
then
    install-alacritty
fi

if [[ "$*" == *"--hypr"* ]]
then
    install-hypr
fi

if [[ "$*" == *"--awesome"* ]]
then
    install-awesome
fi
