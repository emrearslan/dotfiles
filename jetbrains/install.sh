#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   JetBrains\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Intellij IDEA" "intellij-idea" "--cask" "--work"
    brew_install "Goland" "goland" "--cask" "--work"
    brew_install "Webstorm" "webstorm" "--cask" "--work"
    brew_install "DataGrip" "datagrip" "--cask" "--work"

    brew_install "Intellij IDEA CE" "intellij-idea-ce" "--cask" "--personal"
    
}

main
