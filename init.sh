#!/bin/bash

DIR=$(pwd)
DIR_DEPS=$DIR/deps
DIR_CONFIG=$DIR/config

ENSURED=false

function rm-link {
    [[ -L "$1" ]] && rm -v $1
}

function install-pkg {
    PATTERN="^[a-zA-Z0-9_-]+$"

    if command -v paru 2>&1 >/dev/null; then
        paru -S $(cat pkg/all | grep -E --color=never $PATTERN)
        paru -S $(cat pkg/all-aur | grep -E --color=never $PATTERN)
    elif [[ $(id -u) == 0 ]]; then
        pacman -S $(cat pkg/all | grep -E --color=never $PATTERN)
    else
        sudo pacman -S $(cat pkg/all | grep -E --color=never $PATTERN)
    fi
}

function ensure-git {
    [[ -d $1 ]] || git clone $2 $1

    echo Update $1

    cd $1

    git pull

    cd - >/dev/null
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

    for config in "$@"; do
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
    cat pkg/init pkg/libs pkg/dev pkg/cli pkg/apps >pkg/all
    cat pkg/libs-aur pkg/dev-aur pkg/cli-aur pkg/apps-aur >pkg/all-aur

    install-pkg pkg/all
    install-pkg pkg/all-aur
}

function init-all-cfg {
    link-config-arr $DIR_CONFIG ~/.config alacritty.toml brave-flags.conf ripgreprc starship.toml
    link-config-arr $DIR_CONFIG ~/.config bat btop glow nvim
    link-config-arr $DIR_CONFIG ~ .profile .gitconfig

    if command -v gsettings 2>&1 >/dev/null; then
        gsettings set org.gnome.mutter experimental-features '["scale-monitor-framebuffer", "variable-refresh-rate"]'
        gsettings set org.gnome.desktop.peripherals.keyboard delay 150
        gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 10
        gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Original-Classic'
    fi

    link-tmux
    link-zsh
}

for arg in "$@"; do
    case $arg in
    "all")
        init-all-pkg
        init-all-cfg
        ;;
    "all-pkg")
        init-all-pkg
        ;;
    "all-cfg")
        init-all-cfg
        ;;
    "deps")
        ensure-deps
        ;;
    "libs")
        install-pkg pkg/libs
        ;;
    "dev")
        install-pkg pkg/dev
        ;;
    "cli")
        install-pkg pkg/cli
        ;;
    "apps")
        install-pkg pkg/apps
        ;;
    "amd")
        install-pkg pkg/hw_amd
        ;;
    "nvidia")
        install-pkg pkg/hw_nvidia
        ;;
    "games")
        install-pkg pkg/games

        link-config-arr $DIR_CONFIG ~/.config retroarch MangoHud gamemode
        ;;
    "reflector")
        ARGS="--sort rate --threads 128 --fastest 128 --latest 1024 --protocol https --save /etc/pacman.d/mirrorlist"

        if [[ $(id -u) == 0 ]]; then
            reflector $ARGS
        else
            sudo reflector $ARGS
        fi
        ;;
    *)
        echo No args
        ;;
    esac
done
