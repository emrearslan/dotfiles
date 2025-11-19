#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   AI Tools & IDE\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "ChatGPT" "chatgpt" "--cask"
    brew_install "Cursor" "cursor" "--cask"
    brew_install "Antigravity" "antigravity" "--cask"
    
}

main
