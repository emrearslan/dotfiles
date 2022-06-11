#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils/setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n\n • Defaults\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./preferences/app_store.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./preferences/dock.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./preferences/finder.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./preferences/keyboard.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./preferences/menu_bar.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
}

main
