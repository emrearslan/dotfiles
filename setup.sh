#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils/setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Ensure the OS is supported and
    # it's above the required version.

    verify_os \
        || exit 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ask_for_sudo

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_purple "\n • Dotfiles initialize started\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./preinstall_apps.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./install_apps.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./set_preferences.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./configure_zsh.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./restart.sh

}

main
