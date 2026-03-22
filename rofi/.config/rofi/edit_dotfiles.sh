#!/bin/bash

# Define the menu options
options="Hyprland\nNeovim\nWaybar\nKitty\nRofi\nRofi Menu"

# Show the menu and capture the choice
choice=$(echo -e "$options" | rofi -dmenu -i -p "Edit Config:")

# Use a case statement to handle the selection
case "$choice" in
    "Hyprland")
        kitty -e nvim ~/.config/hypr/hyprland.conf
        ;;
    "Neovim")
        kitty -e nvim ~/.config/nvim/init.lua
        ;;
    "Waybar")
        kitty -e nvim ~/.config/waybar/config
        ;;
    "Kitty")
        kitty -e nvim ~/.config/kitty/kitty.conf
        ;;
    "Rofi")
	kitty -e nvim ~/.config/rofi/config.rasi
	;;
    "Rofi Menu")
        ~/.config/rofi/edit_dotfiles_Rofi.sh
	;;
    *)
        # Do nothing if escape is pressed or no match found
        exit 0
        ;;
esac

