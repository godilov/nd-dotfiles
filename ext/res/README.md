# nd-dotfiles-res

Fast and reliable Lua library.  
Designed to be used as source code without any additional tools or package managers.

## Requirements

- Linux
- LuaJIT

The library depends on [nd-dotfiles-lib](https://github.com/GermanOdilov/nd-dotfiles-lib), which requires Linux and LuaJIT.

## Usage

To include the library, simply place its source code somewhere in your working tree and then call `init()` function from [init](src/init.lua) module.  
The function takes 2 arguments:
- `root`: path (relative or absolute) to your working directory. Default: `'.'`
- `is_debug`: flag whether the library in debug mode for error assertion. Used only for assertion. Default: `false`
- `is_dep`: flag whether the library is used as dependency. In this case nd dependencies are not initialized. Default: `false`

Since the library depends on [nd-dotfiles-lib](https://github.com/GermanOdilov/nd-dotfiles-lib) and can be reused as source code, `init()` must add path to the library in `package.path` for ability to call `require()`.  

After `init()` you can easily call `require 'nd.res.core.(module)'` for core module or `require 'nd.res.(module)'` for stateful module.

## Philosophy

The library was created to fulfill store 2 core components of [Awesome WM](https://github.com/GermanOdilov/nd-dotfiles-awesome) and [Nvim](https://github.com/GermanOdilov/nd-dotfiles-nvim) config and extra:
- Color schemes
- Key schemes
- Caching

For reliability and convenience purposes, almost whole library is written in Functional paradigm without any state mutation and other dirty (~~OOP~~) things.  
Only specific stateful-by-definition things like IO, cache, etc. is allowed to be non-functional.

## Structure

The library is separated in 2 main components by simple criteria:

- `nd.res.core`: core modules written purely in functional paradigm. Disallowed to call `nd.res` modules
- `nd.res`: modules which uses some external state (like IO) or creates it. Allowed to call `nd.res.core` modules

The main goal here is to maximize `nd.res.core` and minimize `nd.res`.

