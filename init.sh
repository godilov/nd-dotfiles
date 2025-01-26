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
        paru -S --needed $(cat $1 | grep -E --color=never $PATTERN)
    else
        sudo pacman -S --needed $(cat $1 | grep -E --color=never $PATTERN)
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
    cat pkg/init pkg/libs pkg/dev pkg/cli pkg/hypr pkg/apps pkg/games >pkg/all

    install-pkg pkg/all
}

function init-all-cfg {
    link-config-arr $DIR_CONFIG ~/.config alacritty.toml batsignal brave-flags.conf ripgreprc starship.toml
    link-config-arr $DIR_CONFIG ~/.config bat btop dunst glow hypr mpv nvim tofi waybar
    link-config-arr $DIR_CONFIG ~/.config retroarch MangoHud gamemode.ini
    link-config-arr $DIR_CONFIG ~ .profile .gitconfig

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
    "aur-pkg")
        install-pkg pkg/aur
        ;;
    "deps")
        ensure-deps
        ;;
    "amd")
        install-pkg pkg/hw_amd
        ;;
    "nvidia")
        install-pkg pkg/hw_nvidia
        ;;
    "reflector")
        sudo reflector --sort rate --threads 128 --fastest 128 --latest 1024 --protocol https --save /etc/pacman.d/mirrorlist
        ;;
    "services")
        sudo systemctl enable --now NetworkManager.service
        sudo systemctl enable --now NetworkManager-dispatcher.service
        sudo systemctl disable --now NetworkManager-wait-online.service
        sudo systemctl enable --now bluetooth.service
        sudo systemctl enable --now tlp.service
        sudo systemctl enable --now fstrim.timer
        sudo systemctl enable --now chronyd.service
        sudo systemctl enable --now docker.service
        sudo systemctl enable --now ollama.service
        sudo systemctl enable --now xboxdrv.service

        systemctl --user enable --now xdg-user-dirs-update.service
        systemctl --user enable --now mpd.service
        systemctl --user enable --now pipewire.service
        systemctl --user enable --now wireplumber.service
        ;;
    *)
        echo No args
        ;;
    esac
done
