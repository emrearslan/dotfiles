#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh"

declare -r SDKMAN_INIT_FILE="$HOME/.dotfiles/java/init.sh"
declare -r SDKMAN_DIRECTORY="$HOME/.sdkman"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

is_sdkman_installed() {
    [ -d "$SDKMAN_DIRECTORY" ]
}

install_sdkman() {
    
    printf "\n" | /bin/bash -c "$(curl -s "https://get.sdkman.io")" &> /dev/null
    #  └─ simulate the ENTER keypress

    print_result $? "Sdkman (install)"
    
}

update_sdkman() {

    execute \
        ". $SDKMAN_INIT_FILE \
            && sdk update" \
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

    execute \
        ". $SDKMAN_INIT_FILE \
            && sdk install $SDK $IDENTIFIER" \
        "$SDK_NAME"

}

main() {

    print_in_purple "\n   Java\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! is_sdkman_installed; then
        install_sdkman
    else
        update_sdkman
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    sdk_install "Java 8 - Zulu" "java" "8.0.442-zulu"
    sdk_install "Java 11 - Zulu" "java" "11.0.26-zulu"
    sdk_install "Java 17 - Temurin" "java" "17.0.12-tem"
    sdk_install "Java 21 - Temurin" "java" "21.0.3-tem"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    sdk_install "Maven (install latest)" "maven"
    
}

main
