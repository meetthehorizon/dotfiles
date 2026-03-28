#!/bin/bash

CACHE_WALL="$HOME/.cache/wallpaper"

# 1. Tell Variety to go to the next wallpaper
variety -n

# 2. Short sleep to ensure Variety has finished the file swap

# 3. Get the path, stripping out the "Already running" message
# We use tail -n 1 to grab only the last line (the path)
WALL=$(variety --current | tail -n 1)

# 4. Validate and Link
if [ -f "$WALL" ]; then
    # Update your cache symlink
    ln -sf "$WALL" "$CACHE_WALL"
    
    echo "Linked $WALL to $CACHE_WALL"
else
    echo "Error: Could not find wallpaper file at $WALL"
    exit 1
fi
