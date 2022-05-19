#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils/setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_rosetta() {

    if is_apple_silicon; then

        print_in_purple "   Rosetta\n\n"

        execute \
            "/usr/sbin/softwareupdate --install-rosetta --agree-to-license" \
            "Install Rosetta and agree to the terms of the license"
        
        printf "\n"
        
    fi

}

main() {

    print_in_purple "\n • Pre-Installs\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_rosetta

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # find the pre installers and run them iteratively

    find . -name preinstall.sh | while read preinstallFile ; do sh -c $preinstallFile ; done

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

}

main
