#!/bin/bash

DIR=$(pwd)

function install {
    paru -S --needed $(cat $1 | grep -E --color=never "^[a-zA-Z0-9_-]+$")
}

if [[ "$*" == *"--clone"* || "$*" == *"-c"* ]]
then
    git clone git@github.com:godilov/nd-dotfiles.git dotfiles

    cd dotfiles
fi

if [[ "$*" == *"--ext"* ]]
then
    rm -rf ext/paru
    rm -rf ext/refind

    git clone git@github.com:Morganamilo/paru.git ext/paru
    git clone git@github.com:bobafetthotmail/refind-theme-regular.git ext/refind
fi

if [[ "$*" == *"--ext-nd"* ]]
then
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
fi

if [[ "$*" == *"--all"* ]]
then
    cat pkg/dev pkg/shell pkg/fonts pkg/apps > pkg/all

    install pkg/all
fi

if [[ "$*" == *"--dev"* ]]
then
    install pkg/dev
fi

if [[ "$*" == *"--shell"* ]]
then
    install pkg/shell
fi

if [[ "$*" == *"--fonts"* ]]
then
    install pkg/fonts
fi

if [[ "$*" == *"--apps"* ]]
then
    install pkg/apps
fi

if [[ "$*" == *"--amd"* ]]
then
    install pkg/v_amd
fi

if [[ "$*" == *"--nvidia"* ]]
then
    install pkg/v_nvidia
fi

if [[ "$*" == *"--env"* ]]
then
    rm -rf ~/.config/environment.d

    ln -sf $DIR/config/environment.d ~/.config/environment.d
fi

if [[ "$*" == *"--nvim"* ]]
then
    rm -rf ~/.config/nvim

    ln -sf $DIR/ext/nd/nvim ~/.config/nvim
fi

if [[ "$*" == *"--alacritty"* ]]
then
    rm -rf ~/.config/alacritty

    ln -sf $DIR/config/alacritty ~/.config/alacritty
fi

if [[ "$*" == *"--hypr"* ]]
then
    rm -rf ~/.config/hypr
    rm -rf ~/.config/waybar

    install pkg/wm_hyprland

    ln -sf $DIR/config/hypr ~/.config/hypr
    ln -sf $DIR/config/waybar ~/.config/waybar
fi

if [[ "$*" == *"--awesome"* ]]
then
    rm -rf ~/.config/awesome

    install pkg/wm_awesome

    ln -sf $DIR/ext/nd/awesome ~/.config/awesome
fi
