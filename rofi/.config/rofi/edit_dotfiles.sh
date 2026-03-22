#!/bin/bash

# Define the menu options
options="Hyprland\nNeovim\nWaybar\nKitty\nZsh"

# Show the menu and capture the choice
choice=$(echo -e "$options" | rofi -dmenu -i -p "Edit Config:")

# Use a case statement to handle the selection
case "$choice" in
    Hyprland)
        kitty -e nvim ~/.config/hypr/hyprland.conf
        ;;
    Neovim)
        kitty -e nvim ~/.config/nvim/init.lua
        ;;
    Waybar)
        kitty -e nvim ~/.config/waybar/config
        ;;
    Kitty)
        kitty -e nvim ~/.config/kitty/kitty.conf
        ;;
    Zsh)
        kitty -e nvim ~/.zshrc
        ;;
    *)
        # Do nothing if escape is pressed or no match found
        exit 0
        ;;
esac

