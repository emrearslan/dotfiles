#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_iTerm2() {

    brew_install "iTerm2" "iterm2" "--cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute "defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true" \
        "iTerm2 Preferences: Enable load preferences from a custom folder"

    execute "defaults write com.googlecode.iterm2 PrefsCustomFolder -string '$HOME/.dotfiles/terminal/iterm2'" \
        "iTerm2 Preferences: Set preferences folder"

    execute "defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2" \
        "iTerm2 Preferences: Set automatically save changes for preferences folder"

    # TODO: add app managemenet permission for smooth upgrade to app with homebrew cask 
    # execute "todo.. com.googlecode.iterm2" \
    #    "iTerm2 Preferences: Allow app management permission"

    printf "\n"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Terminal\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_iTerm2

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    brew_install "JetBrains Mono Nerd Font" "font-jetbrains-mono-nerd-font"
    brew_install "Starship" "starship"

}

main
