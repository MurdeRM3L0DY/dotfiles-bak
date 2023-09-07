#!/bin/sh

# start() {
#   if ! pgrep -f $1 ;
#   then
#     $@&
#   fi 
# }

start() {
  pgrep -u $USER -fx '$@' > /dev/null || ($@)
}

# music
# start mpd
# start mpDris2 # add playerctl support to mpd

# compositor
start picom -b --experimental-backends

# auth
start /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# load X colors
# start xrdb $HOME/.Xresources

start blueman-applet &

start nm-applet &

start udiskie &
