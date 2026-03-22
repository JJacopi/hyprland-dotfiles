#!/bin/bash

# Define the menu options
options="Rofi Menu\n"

# Show the menu and capture the choice
choice=$(echo -e "$options" | rofi -dmenu -i -p "Rofi Script:")

# Use a case statement to handle the selection
case "$choice" in
    "Rofi Menu")
        kitty -e nvim ~/.config/rofi/edit_dotfiles.sh
        ;;
    
	*)
        # Do nothing if escape is pressed or no match found
        exit 0
        ;;
esac

