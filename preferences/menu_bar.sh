#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Menu Bar\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute "defaults write com.apple.controlcenter 'NSStatusItem Visible Sound' -bool true" \
        "Enabled the show sound in menu bar"

    execute "defaults write com.apple.controlcenter 'NSStatusItem Visible Battery' -bool true" \
        "Enabled the show battery in menu bar"

    execute "defaults write com.apple.Siri StatusMenuVisible -bool false" \
        "Disable the show siri in menu bar"

    # TODO: not work
    execute "defaults write com.apple.Spotlight MenuItemHidden -bool false" \
        "Disable the show spotlight in menu bar"

    execute "defaults write com.apple.controlcenter 'NSStatusItem Visible Bluetooth' -bool false" \
        "Disable the show bluetooth in menu bar"

    execute "defaults write com.apple.controlcenter 'NSStatusItem Visible WiFi' -bool false" \
        "Disable the show wifi in menu bar"

    execute "defaults write com.apple.controlcenter 'NSStatusItem Visible AirDrop' -bool false" \
        "Disable the show airdrop in menu bar"

    execute "defaults write com.apple.menuextra.clock Show24Hour -bool true" \
        "Use a 24-hour clock in menu bar"

    execute "defaults write com.apple.menuextra.clock ShowDate -bool true" \
        "Show date always in menu bar"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    killall "SystemUIServer" &> /dev/null

}

main
