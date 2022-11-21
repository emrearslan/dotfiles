#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh"

declare -r NVM_INIT_FILE="$HOME/.dotfiles/node/init.sh"
declare -r NVM_DIRECTORY="$HOME/.nvm"
declare -r NVM_GIT_REPO_URL="https://github.com/nvm-sh/nvm.git"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

is_nvm_installed() {
    [ -d "$NVM_DIRECTORY" ]
}

install_nvm() {

    execute \
        "git clone --quiet $NVM_GIT_REPO_URL $NVM_DIRECTORY" \
        "Nvm (install)"
    
}

update_nvm() {

    execute \
        "cd $NVM_DIRECTORY \
            && git fetch --quiet origin \
            && git checkout --quiet \$(git describe --abbrev=0 --tags) \
            && . $NVM_DIRECTORY/nvm.sh" \
        "Nvm (upgrade)"

}

# TODO: remove unnecessery versions
remove_all_nodes() {

    declare -r VERSION="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Nvm` is installed.

    if ! is_nvm_installed; then
        print_error "Node v$VERSION ('Nvm' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # find ~/.nvm/versions/node -mindepth 1 -maxdepth 1 -name 'v6*' -exec rm -fr {} \;

}

install_latest_stable_node() {

    # Install the latest stable version of Node

    execute \
        ". $NVM_INIT_FILE \
            && nvm install node" \
        "Node (install latest Node)"
    
}

install_node() {

    declare -r VERSION="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Nvm` is installed.

    if ! is_nvm_installed; then
        print_error "Node v$VERSION ('Nvm' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specific version.

    execute \
        ". $NVM_INIT_FILE \
            && nvm install $VERSION" \
        "Node (install v$VERSION)"

}

use_node() {

    declare -r VERSION="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Nvm` is installed.

    if ! is_nvm_installed; then
        print_error "Node v$VERSION ('Nvm' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Use the specific version.

    execute \
        ". $NVM_INIT_FILE \
            && nvm use $VERSION" \
        "Node (use v$VERSION)"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Node\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! is_nvm_installed; then
        install_nvm
    else
        update_nvm
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # TODO: use node does not work precisely with installing lts
    # install_latest_stable_node

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_node "16.16.0"
    use_node "16.16.0"
    
}

main
