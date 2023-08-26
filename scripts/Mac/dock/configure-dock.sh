source "$HOME/dotfiles/scripts/helpers/style.sh"
source "$HOME/dotfiles/scripts/Mac/dock/dock-functions.sh"

declare -a apps=(
    '/System/Applications/System Settings.app'
    '/Applications/iTerm.app'
    '/Applications/Fork.app'
    '/Applications/Visual Studio Code.app'
    '/Applications/Google Chrome.app'
    '/Applications/Surfshark.app'
    '/System/Applications/Mail.app'
    '/Applications/Microsoft Outlook.app'
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

read -p "Spacers (press ${bold}RETURN${normal}/${bold}ENTER${normal} to skip): " spacer
add_spacer_to_dock $spacer

read -p "Small spacers (press ${bold}RETURN${normal}/${bold}ENTER${normal} to skip): " small_spacer
add_small_spacer_to_dock $small_spacer

enable_autohide_for_dock
set_autohide_timing_for_dock 0.1
set_mineffect_for_dock "scale"

killall Dock
echo "${bold}Dock configured.${normal}"
