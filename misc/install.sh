#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Miscellaneous\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "1Password" "1password" "--cask"
    brew_install "Clipy" "clipy" "--cask"
    brew_install "Keeping You Awake" "keepingyouawake" "--cask"
    brew_install "Hidden Bar" "hiddenbar" "--cask"
    brew_install "Raindrop.io" "raindropio" "--cask"

    # brew_install "Discord" "discord" "--cask"
    # brew_install "Whatsapp" "whatsapp" "--cask"
    # brew_install "Telegram" "telegram" "--cask"
    # brew_install "VLC" "vlc" "--cask"

    brew_install "Zoom" "zoom" "--cask"
    brew_install "Slack" "slack" "--cask"
    brew_install "Postman" "postman" "--cask"

}

main
