#!/bin/bash

sudo pacman -Syu --needed - < pkg/list_init

cd ext/paru
makepkg -si
cd ../..

sudo bash ext/refind-theme-regular/install.sh
