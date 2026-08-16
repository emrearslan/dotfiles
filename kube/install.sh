#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Kube\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! is_work_machine; then
        print_warning "Skipping Kube (personal machine)"
        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Kubectl" "kubectl"
    brew_install "Kubectx" "kubectx"
    brew_install "K9s" "k9s"
    brew_install "Lens" "lens" "--cask"
    
}

main
