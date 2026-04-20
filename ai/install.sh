#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_cursor_plugin() {
    execute "code --install-extension $2" "Cursor IDE Plugin: $1"
}

install_cursor() {

    brew_install "Cursor" "cursor" "--cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_cursor_plugin "GitHub Theme" "github.github-vscode-theme"
    install_cursor_plugin "IntelliJ IDEA Keybindings" "k--kato.intellij-idea-keybindings"

}

install_rtk() {

    brew_install "rtk AI" "rtk"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute \
            "rtk init -g --agent cursor" \
            "rtk AI: Install to Cursor"

    execute \
            "rtk init -g" \
            "rtk AI: Install to Claude"

    execute \
            "rtk init --agent antigravity" \
            "rtk AI: Install to Antigravity"

    execute \
            "rtk telemetry disable" \
            "rtk AI: Disabled telemetry"

}

install_caveman() {

    execute \
            "npx skills add JuliusBrussee/caveman -a cursor" \
            "Caveman: Install to Cursor"

    execute \
            "claude plugin marketplace add JuliusBrussee/caveman && claude plugin install caveman@caveman" \
            "Caveman: Install to Claude"

}

main() {

    print_in_purple "\n   AI Tools & IDE\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "ChatGPT" "chatgpt" "--cask"
    brew_install "Antigravity" "antigravity" "--cask"

    install_cursor

    brew_install "Claude" "claude" "--cask"
    brew_install "Claude Code" "claude-code" "--cask"

    install_rtk
    install_caveman
}

main
