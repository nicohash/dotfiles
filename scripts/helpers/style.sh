normal=$(tput sgr0)
bold=$(tput bold)

function bold {
        input="${1}"

        echo "${bold}$input${normal}"
}
