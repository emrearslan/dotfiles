#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Safari\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Note !! 
    # If you want defaults write to work right for Safari, you need to give Full Disk Access to Terminal/iTerm2

    execute "defaults write com.apple.Safari HomePage -string 'about:blank'" \
        "Set home page to 'about:blank'"

    execute "defaults write com.apple.Safari SuppressSearchSuggestions -bool true && \
            defaults write com.apple.Safari UniversalSearchEnabled -bool false" \
        "Don’t send search queries to Apple"

    execute "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
            defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
            defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true" \
        "Enable the 'Develop' menu and the 'Web Inspector'"

    execute "defaults write com.apple.Safari IncludeInternalDebugMenu -bool true" \
        "Enable 'Debug' menu"

    execute "defaults write -g WebKitDeveloperExtras -bool true" \
        "Add a context menu item for showing the 'Web Inspector' in web views"

    # execute "defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true" \
    #     "Show the full URL in the address bar"

    execute "defaults write com.apple.Safari AutoOpenSafeDownloads -bool false" \
        "Disable opening 'safe' files automatically"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    killall "Safari" &> /dev/null

}

main