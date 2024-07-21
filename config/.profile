export GTK_THEME=Adwaita:dark

export EDITOR=nvim
export VISUAL=nvim
export PAGER=bat
export MANPAGER='nvim +Man!'

export PATH=$PATH:/home/german/.cargo/bin
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland

export WINE_FULLSCREEN_FSR=1
export WINE_FULLSCREEN_FSR_STRENGTH=5
export AMD_VULKAN_ICD=RADV
export LIBVA_DRIVER_NAME=radeonsi
export VDPAU_DRIVER=radeonsi

eval $(ssh-agent)

Hyprland > /dev/null
