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
    brew_install "MonitorControl" "monitorcontrol" "--cask"
    brew_install "Raindrop.io" "raindropio" "--cask"
    brew_install "Postman" "postman" "--cask"

    brew_install "Zoom" "zoom" "--cask" "--work"
    brew_install "Slack" "slack" "--cask" "--work"

    brew_install "Whatsapp" "whatsapp" "--cask" "--personal"
    # brew_install "Discord" "discord" "--cask" "--personal"
    # brew_install "Telegram" "telegram" "--cask" "--personal"

}

main
