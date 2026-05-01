#!/bin/bash

WALLPAPER_DIR="$HOME/dotfiles/wallpapers"
INTERVAL=120  # seconds between wallpaper changes

# Transition settings
TRANSITION_TYPE="fade"      # fade | wave | wipe | grow | outer | random
TRANSITION_DURATION="1.5"   # seconds
TRANSITION_FPS="60"
TRANSITION_BEZIER=".43,1.19,1,.4"

# Start awww daemon and wait for it to be ready
awww-daemon &
awww wait

# Track the last wallpaper to avoid repeating
LAST=""

while true; do
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) \
        | grep -v "$LAST" \
        | shuf -n 1)

    # Fallback: if all wallpapers are the same as last, just pick any
    if [[ -z "$WALLPAPER" ]]; then
        WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | shuf -n 1)
    fi

    awww img "$WALLPAPER" \
        --transition-type     "$TRANSITION_TYPE" \
        --transition-duration "$TRANSITION_DURATION" \
        --transition-fps      "$TRANSITION_FPS" \
        --transition-bezier   "$TRANSITION_BEZIER"

    LAST="$WALLPAPER"
    sleep "$INTERVAL"
done
