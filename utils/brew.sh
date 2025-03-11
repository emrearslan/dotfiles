#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {

    declare -r ARGUMENTS="$3"
    declare -r FORMULA="$2"
    declare -r FORMULA_READABLE_NAME="$1"
    declare -r TAP_VALUE="$4"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Homebrew` is installed.

    if ! cmd_exists "brew"; then
        print_error "$FORMULA_READABLE_NAME ('Homebrew' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If `brew tap` needs to be executed,
    # check if it executed correctly.

    if [ -n "$TAP_VALUE" ]; then
        if ! brew_tap "$TAP_VALUE"; then
            print_error "$FORMULA_READABLE_NAME ('brew tap $TAP_VALUE' failed)"
            return 1
        fi
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Upgrade the `Formula` if is installed.

    # shellcheck disable=SC2086
    if brew list "$FORMULA" &> /dev/null; then
        if is_argument_cask "$ARGUMENTS"; then
            brew_cask_upgrade "$FORMULA"
            return 0
        fi

        print_success "$FORMULA_READABLE_NAME"
        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified formula.

    execute \
        "brew install $FORMULA $ARGUMENTS" \
        "$FORMULA_READABLE_NAME"

}

brew_prefix() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if path="$(brew --prefix 2> /dev/null)"; then
        printf "%s" "$path"
        return 0
    else
        print_error "Homebrew (get prefix)"
        return 1
    fi

}

brew_tap() {

    execute \
        "brew tap "$1" &> /dev/null" \
        "Homebrew (Tap: $1)"
    
}

brew_update() {

    execute \
        "brew update" \
        "Homebrew (update)"

}

brew_upgrade() {

    execute \
        "brew upgrade" \
        "Homebrew (upgrade)"

}

is_argument_cask() {
    [ "$1" = "--cask" ]
}

brew_cask_upgrade() {

    declare -r FORMULA="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ -n "$FORMULA" ]; then
        # Upgrade the specified homebrew cask.
        execute \
            "brew cu -a -y $FORMULA" \
            "$FORMULA_READABLE_NAME (upgrade)"
    else
        # Upgrade all the homebrew casks.
        execute \
            "brew cu -a -y" \
            "Homebrew (casks upgrade)"
    fi

}
