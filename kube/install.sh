#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Kube\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Kubectl" "kubectl"
    brew_install "Kubectx" "kubectx"
    brew_install "K9s" "k9s"
    brew_install "Lens" "lens" "--cask"
    
}

main
