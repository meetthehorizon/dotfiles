#!/usr/bin/env bash

# 1. Get the current active profile
CURRENT=$(powerprofilesctl get)

# 2. Extract profile names:
# - Remove the '*' indicator
# - Look for lines starting with a word followed by a colon
# - Strip the colon to get just the name
PROFILES=($(powerprofilesctl list | tr -d '*' | grep -E '^[[:space:]]*[a-z-]+:' | sed 's/://' | xargs))

# 3. Find current index
CURRENT_INDEX=-1
for i in "${!PROFILES[@]}"; do
   if [[ "${PROFILES[$i]}" == "${CURRENT}" ]]; then
       CURRENT_INDEX=$i
       break
   fi
done

# 4. Calculate next index (cycle back to 0)
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#PROFILES[@]} ))
NEXT_PROFILE="${PROFILES[$NEXT_INDEX]}"

# 5. Apply the next profile
powerprofilesctl set "$NEXT_PROFILE"

# 6. Notification with logic for icons
case "$NEXT_PROFILE" in
    "performance") ICON="power-profile-performance-symbolic" ;;
    "power-saver") ICON="power-profile-power-saver-symbolic" ;;
    *)             ICON="power-profile-balanced-symbolic" ;;
esac

notify-send -u low -t 1500 -i "$ICON" "Power Profile" "Switched to: <b>$NEXT_PROFILE</b>"
