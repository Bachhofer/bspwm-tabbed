# bspwm-tabbed
This script adds tabbed windows to any window manager. It is basically a fork of [this gist](https://gist.github.com/jpentland/468a42c172eb607bb950f5d00606312c) but with improved functionality.

# Usage
`tabc <command>`
Possible commands are
- `add <window-id> <tabbed-id>`
adds a window to the tabbed window. If `<tabbed-id>` is omitted or not a tabbed window, it has the same affect as `create` 
- `create <window-id>`
creates a new tabbed window and adds the given window to it
- `remove <window-id>`
removes a given window from its tabbed window
- `remove-child <tabbed-id>`
removes the currently focused window from the given tabbed window
- `list <tabbed-id>`
returns a list of all windows inside a give tabbed window

# Installation
Just move `tabc` to any folder in your $PATH like `/usr/local/bin`

It is useful to add shortcuts for this script.
To do this for bspwm you can add something like this to your `sxhkd.conf`
```
# Add focused window to a tabbed instance in given direction
super + t; {h,j,k,l}
    tabc add $(bspc query -N -n focused) $(bspc query -N -n {west,south,north,east})

# Remove one tab from tabbed
super + t; r
    tabc remove-child $(bspc query -N -n focused)
```

## Autocompletion
You can add autocompletion for bash and zsh by running the following commands
``` 
cp tabc.bash /usr/share/bash-completion/completions/tabc        #adds autocompletion for bash
cp tabc.zsh /usr/share/zsh/site-functions/_tabc                 #adds autocompletion for zsh
```
#### Note:
Bash only completes the subcommads.
The zsh completion is in addition to that able to complete window ids.


# Dependencies
- tabbed
- xprop
- xdotool
- xwininfo
