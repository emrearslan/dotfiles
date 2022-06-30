#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh"

declare -r DOCK_APPS='Launchpad
Notes
Music
Podcasts
Appstore
System Preferences
1Password
Safari
Google Chrome
Firefox
zoom.us
Slack
iTerm'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

custom_dockapps() {

    # delete dock apps
    defaults delete com.apple.dock "persistent-apps"

    # delete dock folders
    defaults delete com.apple.dock "persistent-others"

    printf "%s\n" "${DOCK_APPS}" | \
    while IFS="$(printf '\t')" read app; do

        if test -e "/Applications/${app}.app"; then
            add_dock "${app}"
        elif test -e "/System/Applications/${app}.app"; then
            add_dock "${app}" "System"
        fi

    done

    print_success "Customize Dock Apps"

}

add_dock() {

    defaults write com.apple.dock "persistent-apps" -array-add \
    "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${2}/Applications/${1}.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

}

main() {

    print_in_purple "\n   Dock\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute "defaults write com.apple.dock orientation -string bottom" \
        "Put the Dock on the bottom of the screen"

    execute "defaults write com.apple.dock autohide -bool true" \
        "Automatically hide/show the Dock"

    execute "defaults write com.apple.dock autohide-delay -float 0" \
        "Disable the hide Dock delay"

    execute "defaults write com.apple.dock tilesize -int 48" \
        "Set icon size"

    execute "defaults write com.apple.dock magnification -bool true" \
        "Enabled magnification"

    execute "defaults write com.apple.dock largesize -float 72" \
        "Set magnification size"

    execute "defaults write com.apple.dock show-recents -bool false" \
        "Do not show recent applications in Dock"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    custom_dockapps

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    killall "Dock" &> /dev/null

}

main
