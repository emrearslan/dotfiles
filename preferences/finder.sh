#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Finder\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # the home folder is "PfHm"
    
    execute "defaults write com.apple.finder NewWindowTarget -string PfHm" \
        "Set home folder to new winder show folder"

    execute "defaults write com.apple.finder NewWindowTargetPath -string 'file://${HOME}'" \
        "Add home folder to finder sidebar"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    killall "Finder" &> /dev/null
    killall "cfprefsd" &> /dev/null

}

main
