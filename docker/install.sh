#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Docker\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Docker" "docker-desktop" "--cask" "--personal"
    brew_install "OrbStack" "orbstack" "--cask" "--personal"

    brew_install "Podman" "podman" "" "--work"
    brew_install "Podman Desktop" "podman-desktop" "--cask" "--work"

    brew_install "Dive" "dive"

}

main
