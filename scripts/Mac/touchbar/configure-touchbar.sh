source "$HOME/dotfiles/scripts/Mac/helpers/style.sh"

# Extended
defaults write com.apple.controlstrip FullCustomized -array \
    "com.apple.system.group.brightness" \
    "com.apple.system.group.keyboard-brightness" \
    "com.apple.system.airplay" \
    "com.apple.system.screencapture" \
    "com.apple.system.group.media" \
    "com.apple.system.group.volume" \
    "com.apple.system.screen-lock"

# Mini
defaults write com.apple.controlstrip MiniCustomized -array \
    "com.apple.system.brightness" \
    "com.apple.system.volume" \
    "com.apple.system.media-play-pause" \
    "com.apple.system.screen-lock"

killall ControlStrip
echo "${bold}Touchbar configured.${normal}"
