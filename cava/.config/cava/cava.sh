#!/bin/bash

# Not my own work. Credit to original author

#----- Optimized bars animation without much CPU usage increase --------
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"

# Calculate the length of the bar outside the loop
bar_length=${#bar}

# Create dictionary to replace char with bar
for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

# Create cava config
config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
# Older systems show significant CPU use with default framerate
# Setting maximum framerate to 30
# You can increase the value if you wish
framerate = 60
bars = 10

[input]
method = pulse
source = alsa_output.usb-Focusrite_Scarlett_Solo_USB_Y78F9PM5836DB0-00.pro-output-0.monitor

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

[smoothing]
integral = 77
monstercat = 1
waves = 0
gravity = 100
ignore = 0

[eq]
1 = 1
2 = 1
3 = 1
4 = 1
5 = 1

EOF

# Kill cava if it's already running
pkill -f "cava -p $config_file"

# Read stdout from cava and perform substitution in a single sed command
cava -p "$config_file" | sed -u "$dict"
