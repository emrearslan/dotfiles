#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh" \

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   System Tools\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "FZF" "fzf"
    brew_install "JQ" "jq"
    brew_install "Zoxide" "zoxide"
    brew_install "Bat" "bat"
    brew_install "Eza" "eza"
    brew_install "Vivid" "vivid"
    brew_install "Rip" "rm-improved"
    brew_install "Ripgrep" "ripgrep"
    brew_install "Fx.wtf" "fx"
    # brew_install "Navi" "navi" TODO: 
    

}

main
