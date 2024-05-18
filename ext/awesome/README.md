# nd-dotfiles-awesome

Fast and reliable Awesome WM config.  
Designed to be used as source code without any additional tools or package managers.

## Requirements

- Linux
- LuaJIT

The config depends on [nd-dotfiles-lib](https://github.com/GermanOdilov/nd-dotfiles-lib) and [nd-dotfiles-res](https://github.com/GermanOdilov/nd-dotfiles-res), which requires Linux and LuaJIT.

## Usage

Simply copy the whole config to `~/.config/awesome`.

## Philosophy

The config contains only Awesome-specific things and settings to keep it clean and small:
- Appearance definition (taglist, tasklist, etc)
- Color scheme initialization
- Key scheme initialization

All other functionality and resources are defined in nd dependencies.

