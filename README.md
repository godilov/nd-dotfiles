# nd-dotfiles
Arch Linux dotfiles for reproducable setup

## Requirements

- Arch Linux
- LuaJIT

The dotfiles uses rich [Awesome WM](https://github.com/GermanOdilov/nd-dotfiles-awesome) and [Nvim](https://github.com/GermanOdilov/nd-dotfiles-nvim) configs, which both depends on [nd-dotfiles-lib](https://github.com/GermanOdilov/nd-dotfiles-lib) and [nd-dotfiles-res](https://github.com/GermanOdilov/nd-dotfiles-res). They are not compatible with Windows systems and standard Lua currently.  

The dotfiles should properly work on other Linux distributions, but was tested only on Arch.

## Usage

Repository contains 2 core executables:
- init.sh - designed to be used during last stages of Arch Linux installation. It installs core [packages](pkg/list_init), paru as AUR package manager and refind theme.
- install.sh - designed to be used after full Arch Linux installation. It installs other packages from `pkg/` directory and copies configs to `~/.config` directory.

