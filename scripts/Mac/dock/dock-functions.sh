source "$HOME/dotfiles/scripts/Mac/helpers/style.sh"

# adds an application to macOS Dock
# usage: add_app_to_dock "Application Name"
# example add_app_to_dock "/System/Applications/Music.app"
function add_app_to_dock {
    app="${1}"

    if open -Ra "${app}"; then
        echo "${bold}$app${normal} added to the Dock."

        defaults write com.apple.dock persistent-apps -array-add "<dict>
                <key>tile-data</key>
                <dict>
                    <key>file-data</key>
                    <dict>
                        <key>_CFURLString</key>
                        <string>${app}</string>
                        <key>_CFURLStringType</key>
                        <integer>0</integer>
                    </dict>
                </dict>
            </dict>"
    else
        echo "ERROR: Application ${bold}$1${normal} not found."
    fi
}

# adds a folder to macOS Dock
# usage: add_folder_to_dock "Folder Path" -a n -d n -v n
# example: add_folder_to_dock "~/Downloads" -a 2 -d 0 -v 1
# key:
# -a or --arrangement
#   1 -> Name
#   2 -> Date Added
#   3 -> Date Modified
#   4 -> Date Created
#   5 -> Kind
# -d or --displayAs
#   0 -> Stack
#   1 -> Folder
# -v or --showAs
#   0 -> Automatic
#   1 -> Fan
#   2 -> Grid
#   3 -> List
function add_folder_to_dock {
    folder="${1}"
    arrangement="1"
    displayAs="0"
    showAs="0"

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -a|--arrangement)
                if [[ $2 =~ ^[1-5]$ ]]; then
                    arrangement="${2}"
                fi
                ;;
            -d|--displayAs)
                if [[ $2 =~ ^[0-1]$ ]]; then
                    displayAs="${2}"
                fi
                ;;
            -v|--showAs)
                if [[ $2 =~ ^[0-3]$ ]]; then
                    showAs="${2}"
                fi
                ;;
        esac
        shift
    done

    if [ -d "$folder" ]; then
        echo "${bold}$folder${normal} added to the Dock."

        defaults write com.apple.dock persistent-others -array-add "<dict>
                <key>tile-data</key>
                <dict>
                    <key>arrangement</key>
                    <integer>${arrangement}</integer>
                    <key>displayas</key>
                    <integer>${displayAs}</integer>
                    <key>file-data</key>
                    <dict>
                        <key>_CFURLString</key>
                        <string>file://${folder}</string>
                        <key>_CFURLStringType</key>
                        <integer>15</integer>
                    </dict>
                    <key>file-type</key>
                    <integer>2</integer>
                    <key>showas</key>
                    <integer>${showAs}</integer>
                </dict>
                <key>tile-type</key>
                <string>directory-tile</string>
            </dict>"
    else
        echo "ERROR: Folder ${bold}$folder${normal} not found."
    fi
}

# adds a spacer to macOS Dock
# usage: add_spacer_to_dock <number of spacers>
# example: add_spacer_to_dock 3
function add_spacer_to_dock {
    amount=${1:-0}
    
    if [[ $amount =~ ^[0-9]+$ ]]; then
        echo "Spacers added to the Dock: ${bold}$amount${normal}"
        
        while [[ amount -gt 0 ]]; do
            defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
            ((amount--))
        done
    else
        echo "ERROR: Input ${bold}$amount${normal} is not valid."
    fi
}

# adds a small spacer to macOS Dock
# usage: add_small_spacer_to_dock <number of small spacers>
# example: add_small_spacer_to_dock 3
function add_small_spacer_to_dock {
    amount=${1:-0}
    
    if [[ $amount =~ ^[0-9]+$ ]]; then
        echo "Small spacers added to the Dock: ${bold}$amount${normal}"
        
        while [[ amount -gt 0 ]]; do
            defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
            ((amount--))
        done
    else
        echo "ERROR: Input ${bold}$amount${normal} is not valid."
    fi
}

function disable_autohide_for_dock {
    defaults write com.apple.dock autohide -bool false
}

function enable_autohide_for_dock {
    defaults write com.apple.dock autohide -bool true
}

# sets autohide delay for macOS Dock
# usage: set_autohide_delay_for_dock <delay in seconds as float>
# example: set_autohide_delay_for_dock 0.2
function set_autohide_delay_for_dock {
    delay=$1
    
    defaults write com.apple.dock autohide-delay -float $delay
    echo "Autohide-delay: ${bold}$delay${normal}"
}

# sets autohide time modifier for macOS Dock
# usage: set_autohide_time_modifier_for_dock <time modifier in seconds as float>
# example: set_autohide_time_modifier_for_dock 0.2
function set_autohide_time_modifier_for_dock {
    time_modifier=$1
    
    defaults write com.apple.dock autohide-time-modifier -float $time_modifier
    echo "Autohide-time-modifier: ${bold}$time_modifier${normal}"
}

# sets autohide delay and time modifier for macOS Dock
# usage: set_autohide_timing_for_dock <delay in seconds as float>
# example: set_autohide_timing_for_dock 0.2
function set_autohide_timing_for_dock {
    timing=$1

    set_autohide_delay_for_dock $timing
    set_autohide_time_modifier_for_dock $timing
}

# sets minimize effect for macOS Dock
# usage: set_mineffect_for_dock "Effect" 
# example: set_mineffect_for_dock "scale" 
function set_mineffect_for_dock {
    effect=$1
    
    defaults write com.apple.dock mineffect -string $effect
    echo "Minimize effect: ${bold}$effect${normal}"
}

function disable_recent_apps_from_dock {
    defaults write com.apple.dock show-recents -bool false
}

function enable_recent_apps_from_dock {
    defaults write com.apple.dock show-recents -bool true
}

function clear_apps_from_dock {
    defaults delete com.apple.dock persistent-apps
}

function clear_others_from_dock {
    defaults delete com.apple.dock persistent-others
}

function clear_dock {
    clear_apps_from_dock
    clear_others_from_dock
}

function reset_dock {
    defaults delete com.apple.dock
    killall Dock
}
