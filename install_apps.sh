#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils/setup.sh" \
    && cd ..

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n\n • Installs\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # find the installers and run them iteratively

    for installer in $(find . -name install.sh); do $installer done

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

}

main
