#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Docker\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # brew_install "Docker" "docker" "--cask"
    # brew_install "OrbStack" "orbstack" "--cask"
    brew_install "Podman" "podman-desktop"
    # brew_install "Dive" "dive"

}

main
