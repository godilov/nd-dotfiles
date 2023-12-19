#!/bin/bash

git clone git@github.com:godilov/nd-dotfiles.git dotfiles

cd dotfiles

rm -rf ext/nd/*

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
