#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_chrome_extension () {

    preferences_dir_path="$HOME/Library/Application Support/Google/Chrome/External Extensions/"
    pref_file_path="$preferences_dir_path/$2.json"

    upd_url="https://clients2.google.com/service/update2/crx"
    mkdir -p "$preferences_dir_path"

    echo "{" > "$pref_file_path"
    echo "  \"external_update_url\": \"$upd_url\"" >> "$pref_file_path"
    echo "}" >> "$pref_file_path"

    print_success "Chrome Extension: $1"
}

install_chrome() {

    brew_install "Chrome" "google-chrome" "--cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the Chrome extensions
    install_chrome_extension "uBlock Origin" "cjpalhdlnbpafiamejdnhcphjbkeiagm"
    install_chrome_extension "1Password" "aeblfdkhhhdcdjpifhhbdiojplfjncoa"
    install_chrome_extension "Raindrop.io" "ldgfbffkinooeloadekpmfoklnobpien"
    install_chrome_extension "JSON Viewer" "gbmdgpbipfallnflgajpaliibnhdgobh"
    install_chrome_extension "ModHeader" "idgpnmonknjnojddfkpgkljpfnnfcklj"
    install_chrome_extension "Dark Reader" "eimadpbcbfnmbkopoojfekhnkhdbieeh"

    killall "Google Chrome" &> /dev/null

    printf "\n"

}

main() {

    print_in_purple "\n   Browsers\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_chrome

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Firefox" "firefox" "--cask"

}

main
