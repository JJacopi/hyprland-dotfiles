#!/bin/bash

# 1. Function to map modmask bitmasks to readable names
get_mods() {
    local mask=$1
    local mods=""
    ((mask & 1))  && mods+="Shift+"
    ((mask & 4))  && mods+="Ctrl+"
    ((mask & 8))  && mods+="Alt+"
    ((mask & 64)) && mods+="Super+"
    echo "${mods%+}"
}

# 2. Function to translate internal key names to symbols
get_key_label() {
    case "$1" in
        "slash") echo "/" ;;
        "backslash") echo "\\" ;;
        "period") echo "." ;;
        "comma") echo "," ;;
        "minus") echo "-" ;;
        "equal") echo "=" ;;
        *) echo "$1" ;;
    esac
}

# 3. Fetch, format, and pipe directly to Rofi
# Piping directly into rofi prevents the "hex box" character issues
hyprctl binds -j | jq -r '.[] | "\(.modmask)|\(.key)|\(.dispatcher)|\(.arg)"' | while read -r line; do
    IFS="|" read -r mask key disp arg
    
    modname=$(get_mods "$mask")
    key_label=$(get_key_label "$key")
    
    # 4. Icon Logic (Modify these based on your apps)
    icon="input-keyboard" # Default icon
    if [[ "$disp" == "exec" ]]; then
        icon="system-run"
        [[ "$arg" == *"kitty"* ]] && icon="terminal"
        [[ "$arg" == *"firefox"* ]] && icon="firefox"
        [[ "$arg" == *"rofi"* ]] && icon="view-list"
        [[ "$arg" == *"nautilus"* ]] && icon="folder"
    fi
    [[ "$disp" == "killactive" ]] && icon="window-close"
    [[ "$disp" == "togglefloating" ]] && icon="view-restore"

    # 5. The Critical Formatting Line
    # \0icon\x1f is the magic string Rofi needs to show icons
    echo -en "${modname} + ${key_label}    ${disp} ${arg}\0icon\x1f${icon}\n"

done | rofi -dmenu -i -p "Keybinds" \
    -show-icons -icon-theme "Papirus" \
    -theme-str '
        window { 
            width: 60%; 
            border: 2px; 
            border-color: #ffffff33; 
            border-radius: 12px;
            background-color: #1e1e2eCC; 
        } 
        listview { 
            lines: 12; 
            scrollbar: false;
        } 
        element { 
            padding: 8px; 
        } 
        element-icon { 
            size: 2.5ch; 
            margin: 0 12px 0 0; 
        }
    '



