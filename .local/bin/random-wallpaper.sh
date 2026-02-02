#!/bin/bash
# Random wallpaper selector using swww

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | shuf -n 1)

if [ -n "$WALLPAPER" ]; then
    swww img "$WALLPAPER" --transition-type any --transition-duration 2
fi
