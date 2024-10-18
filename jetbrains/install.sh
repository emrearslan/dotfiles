#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   JetBrains\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Intellij IDEA" "intellij-idea" "--cask"
    brew_install "Goland" "goland" "--cask"
    brew_install "Webstorm" "webstorm" "--cask"
    brew_install "DataGrip" "datagrip" "--cask"
    
}

main
