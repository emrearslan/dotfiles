#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Keyboard\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute "defaults write -g ApplePressAndHoldEnabled -bool false" \
        "Disable press-and-hold in favor of key repeat"

    execute "defaults write -g InitialKeyRepeat -int 15" \
        "Set the delay until repeat to max short"

    execute "defaults write -g KeyRepeat -int 2" \
        "Set the key repeat rate to max fast"

    execute "defaults write -g com.apple.keyboard.fnState -boolean true" \
        "Use F1, F2, etc. keys as standard function keys"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

}

main
