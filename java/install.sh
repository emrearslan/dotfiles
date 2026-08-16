#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

declare -r SDKMAN_INIT_FILE="$HOME/.dotfiles/java/init.sh"
declare -r SDKMAN_DIRECTORY="$HOME/.sdkman"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

is_sdkman_installed() {
    [ -d "$SDKMAN_DIRECTORY" ]
}

install_sdkman() {

    printf "\n" | "$(brew --prefix bash)/bin/bash" -c "$(curl -s "https://get.sdkman.io")" &> /dev/null
    #  └─ simulate the ENTER keypress

    print_result $? "Sdkman (install)"

}

update_sdkman() {

    # SDKMAN's own scripts use Bash 4+ syntax (e.g. `${var^^}`), so
    # `sdk` commands need to run under a modern bash, not macOS's
    # stock /bin/bash 3.2.
    local -r BASH_BIN="$(brew --prefix bash)/bin/bash"

    execute \
        "\"$BASH_BIN\" -c '. $SDKMAN_INIT_FILE && sdk update'" \
        "Sdkman (upgrade)"

}

sdk_install() {

    declare -r SDK_NAME="$1"
    declare -r SDK="$2"
    declare -r IDENTIFIER="$3"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Sdkman` is installed.

    if ! is_sdkman_installed; then
        print_error "$SDK_NAME ('Sdkman' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specific version by Identifier.

    local -r BASH_BIN="$(brew --prefix bash)/bin/bash"

    execute \
        "\"$BASH_BIN\" -c '. $SDKMAN_INIT_FILE && sdk install $SDK $IDENTIFIER'" \
        "$SDK_NAME"

}

main() {

    print_in_purple "\n   Java\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # SDKMAN's installer and its own scripts require Bash 4+ (macOS's
    # stock /bin/bash is 3.2, frozen due to GPLv3) - needed for both
    # the install and the update/sdk_install paths below.

    brew_install "Bash" "bash"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! is_sdkman_installed; then
        install_sdkman
    else
        update_sdkman
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    sdk_install "Java 11 - Temurin" "java" "11.0.30-tem"
    sdk_install "Java 17 - Temurin" "java" "17.0.18-tem"
    sdk_install "Java 21 - Temurin" "java" "21.0.11-tem"
    sdk_install "Java 25 - Temurin" "java" "25.0.3-tem"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    sdk_install "Maven (install latest)" "maven"
    
}

main
