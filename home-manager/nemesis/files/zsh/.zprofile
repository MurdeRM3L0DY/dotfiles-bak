if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

if [ -e "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi

# if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#   exec startx
# fi

if [[ -z $WAYLAND_DISPLAY && -z $DISPLAY ]]; then
  cd ~

  export _JAVA_AWT_WM_NONREPARENTING=1
  # export XCURSOR_SIZE=24

  exec Hyprland
fi
