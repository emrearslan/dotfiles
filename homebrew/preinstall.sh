#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

get_homebrew_git_config_file_path() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if path="$(brew --repository 2> /dev/null)/.git/config"; then
        printf "%s" "$path"
        return 0
    else
        print_error "Homebrew (get config file path)"
        return 1
    fi

}

install_homebrew() {

    if ! cmd_exists "brew"; then
        ask_for_sudo
        printf "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &> /dev/null
        #  └─ simulate the ENTER keypress

    fi

    print_result $? "Homebrew"

}

opt_out_of_analytics() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `Homebrew` git config file.

    path="$(get_homebrew_git_config_file_path)" \
        || return 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Opt-out of Homebrew's analytics.
    # https://github.com/Homebrew/brew/blob/0c95c60511cc4d85d28f66b58d51d85f8186d941/share/doc/homebrew/Analytics.md#opting-out

    if [ "$(git config --file="$path" --get homebrew.analyticsdisabled)" != "true" ]; then
        git config --file="$path" --replace-all homebrew.analyticsdisabled true &> /dev/null
        print_result $? "Homebrew (opt-out of analytics)"
    fi

}

install_cask_upgrade() {

    brew_tap "buo/cask-upgrade"
    
}

opt_out_of_auto_update() {

    declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.bash.local"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If needed, add the necessary configs in the
    # local shell configuration file.

    if ! grep "HOMEBREW_NO_AUTO_UPDATE" < "$LOCAL_SHELL_CONFIG_FILE" &> /dev/null; then

        declare -r CONFIGS="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Configure Homebrew to not auto-update before running commands
# such as: \`brew install\`, \`brew upgrade\`, and \`brew tap\`.
#
# https://docs.brew.sh/Manpage#environment

export HOMEBREW_NO_AUTO_UPDATE=1
"
        execute \
            "printf '%s' '$CONFIGS' >> $LOCAL_SHELL_CONFIG_FILE" \
            "Homebrew (opt-out of auto-updating before running certain commands)"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Homebrew\n\n"

    install_homebrew
    opt_out_of_analytics

    install_cask_upgrade

    brew_update
    brew_upgrade
    brew_cask_upgrade

    # opt_out_of_auto_update # TODO
}

main
