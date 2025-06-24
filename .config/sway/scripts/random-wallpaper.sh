#!/bin/bash

IMAGE_FOLDER="$HOME/.config/sway/backgrounds"
random_image=$(find "$IMAGE_FOLDER" -type f | shuf -n 1)

# Kill existing swaybg processes
pkill swaybg

# Set wallpaper
swaybg -i "$random_image" -m fill &
EOF

chmod +x ~/.config/sway/scripts/random-wallpaper.sh
