#==============
# Configure Dock
#==============
source "$HOME/dotfiles/scripts/Mac/helpers/style.sh"
source "./dock-functions.sh"

echo "${bold}Configuring Dock${normal}"

declare -a apps=(
    '/Applications/iTerm.app'
    '/System/Applications/System Settings.app'
    '/Applications/Google Chrome.app'
    '/System/Applications/Mail.app'
    '/Applications/Calendars.app'
    '/Applications/TickTick.app'
    '/Applications/GoodNotes.app'
    '/Applications/Spotify.app'
    '/Applications/WhatsApp.app'
);

declare -a folders=(
    ~/Downloads
);

clear_dock
disable_recent_apps_from_dock

for app in "${apps[@]}"; do
    add_app_to_dock "$app"
done

for folder in "${folders[@]}"; do
    add_folder_to_dock $folder
done

read -p "Spacers (press ${bold}ENTER${normal} to skip): " spacer
add_spacer_to_dock $spacer

read -p "Small spacers (press ${bold}ENTER${normal} to skip): " small_spacer
add_small_spacer_to_dock $small_spacer

enable_autohide_for_dock
set_autohide_timing_for_dock 0.2
set_mineffect_for_dock "scale"

killall Dock

echo "${bold}Done.${normal}"
