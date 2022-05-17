#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugin() {
    execute "code --install-extension $2" "Visual Studio Code Plugin: $1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Visual Studio Code\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Visual Studio Code" "visual-studio-code" "--cask"

    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the VSCode plugins
    install_plugin "GitHub Theme" "github.github-vscode-theme"
    install_plugin "GitHub Copilot" "github.copilot"
    install_plugin "IntelliJ IDEA Keybindings" "k--kato.intellij-idea-keybindings"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    osascript -e 'quit app "Visual Studio Code"'

}

main
