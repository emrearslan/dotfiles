#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_cursor_plugin() {
    execute "cursor --install-extension $2" "Cursor IDE Plugin: $1"
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

    # rtk writes into ~/.cursor, which only gets created the first time
    # Cursor.app itself is launched - make sure it exists upfront.
    mkdir -p "$HOME/.cursor"

    execute \
            "rtk init -g --agent cursor" \
            "rtk AI: Install to Cursor"

    execute \
            "rtk init -g" \
            "rtk AI: Install to Claude"

    # NOTE: rtk has no "codex" agent (supported: claude, cursor, windsurf,
    # cline, kilocode, antigravity, kimi, pi, hermes, droid, vibe) - skip.
    
    # NOTE: antigravity is project-scoped only (no -g) - running it here
    # would dump .agents/ into this repo. Run "rtk init --agent antigravity"
    # inside each project instead.

    execute \
            "rtk telemetry disable" \
            "rtk AI: Disabled telemetry"

}

install_caveman() {

    # `npx` comes from Node, which may not be on PATH yet in this
    # process (nvm/node are installed by a separate, unordered script) -
    # pick it up manually if it's already been installed.
    local -r NVM_INIT_FILE="$HOME/.dotfiles/node/init.sh"
    [ -s "$NVM_INIT_FILE" ] && . "$NVM_INIT_FILE" && nvm use --silent default &> /dev/null

    execute \
            "npx skills add JuliusBrussee/caveman -a cursor" \
            "Caveman: Install to Cursor"

    execute \
            "npx skills add JuliusBrussee/caveman -a codex" \
            "Caveman: Install to Codex"

    execute \
            "claude plugin marketplace add JuliusBrussee/caveman && claude plugin install caveman@caveman" \
            "Caveman: Install to Claude"

}

main() {

    print_in_purple "\n   AI Tools & IDE\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "ChatGPT" "chatgpt" "--cask"
    brew_install "Antigravity" "antigravity" "--cask"
    brew_install "Antigravity IDE" "antigravity-ide" "--cask"

    install_cursor

    brew_install "Claude" "claude" "--cask"
    brew_install "Claude Code" "claude-code" "--cask"
    brew_install "Codex" "codex" "--cask"

    brew_install "CodexBar" "codexbar" "--cask"

    install_rtk
    install_caveman
}

main
