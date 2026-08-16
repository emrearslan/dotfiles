#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# `brew`'s installer doesn't update PATH for the current process/script,
# so right after a fresh install (or in any script run before the shell
# has been restarted) `brew` isn't found yet. Pick it up manually from
# its known install locations.

ensure_brew_in_path() {

    if cmd_exists "brew"; then
        return 0
    fi

    if [ -x "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

}

ensure_brew_in_path

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {

    declare -r ARGUMENTS="$3"
    declare -r FORMULA="$2"
    declare -r FORMULA_READABLE_NAME="$1"
    declare -r PROFILE="$4"
    declare -r TAP_VALUE="$5"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Skip formulas restricted to a machine profile
    # (--work / --personal) that doesn't match this machine.

    if [ "$PROFILE" == "--work" ] && ! is_work_machine; then
        print_warning "$FORMULA_READABLE_NAME (skipped, work only)"
        return 0
    fi

    if [ "$PROFILE" == "--personal" ] && ! is_personal_machine; then
        print_warning "$FORMULA_READABLE_NAME (skipped, personal only)"
        return 0
    fi

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

    # TODO: --force is temporary, remove after this full setup.sh run -
    # it's here so casks that are already installed manually (not via
    # brew) don't error out and stop the run.
    execute \
        "brew install $FORMULA $ARGUMENTS --force" \
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
