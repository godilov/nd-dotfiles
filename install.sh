#!/bin/bash

sudo pacman -Syu --needed - < pkg/list
sudo pacman -Syu --needed - < pkg/list_vamd

paru -Syu --needed - < pkg/list_aur

rm -r ~/.config/awesome
rm -r ~/.config/nvim

cp -r config/awesome ~/.config/awesome
cp -r config/nvim ~/.config/nvim
