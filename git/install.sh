#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/brew.sh" \
    && cd ..

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

download_delta_themes() {

    declare -r DELTA_THEMES="https://raw.githubusercontent.com/dandavison/delta/master/themes.gitconfig"
    declare -r DELTA_THEMES_FILE="git/themes.gitconfig" 

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute \
        "curl $DELTA_THEMES --output $DELTA_THEMES_FILE" \
        "Delta: Download themes"

}

configure_gpg() {

    #TODO: import gpg key
    print_success "GnuPG configuration..."

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    # https://www.jwillikers.com/backup-and-restore-a-gpg-key

    # execute \
    #     "gpg --import private/gpg_backup.gpg" \
    #     "Import GPG backup key"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # execute \
    #     "echo 'pinentry-program $(which pinentry-mac)' >> ~/.gnupg/gpg-agent.conf \
    #         && killall gpg-agent" \
    #     "Configure Pinentry for GPG"

}

init_gitconfig_file() {

    declare -r PRIVATE_GIT_FILE_PATH="$HOME/.dotfiles/private/private.gitconfig"

    if [ ! -f $PRIVATE_GIT_FILE_PATH ]; then
        create_gitconfig_local
    fi

}

create_gitconfig_local() {

    declare -r FILE_PATH="$HOME/.gitconfig.local"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ ! -e "$FILE_PATH" ] || [ -z "$FILE_PATH" ]; then

    
        local GIT_AUTHOR_NAME=""
        local GIT_AUTHOR_EMAIL=""

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        ask "What is your git author name? "
        GIT_AUTHOR_NAME="$(get_answer)"

        ask "What is your git author email? "
        GIT_AUTHOR_EMAIL="$(get_answer)"

        printf "%s\n" \
"[user]
    name = $GIT_AUTHOR_NAME
    email = $GIT_AUTHOR_EMAIL
    # signingkey =

[commit]
    # Sign commits using GPG.
    # https://help.github.com/articles/signing-commits-using-gpg/
    # gpgsign = true" \
        >> "$FILE_PATH"
    fi

    print_result $? "$FILE_PATH"

}

create_git_file_symlinks() {

    declare -a FILES_TO_SYMLINK=(

        "git/gitconfig"
        "git/gitignore"

    )

    local i=""
    local sourceFile=""
    local targetFile=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ ! -e "$targetFile" ]; then

            execute \
                "ln -fs $sourceFile $targetFile" \
                "$targetFile → $sourceFile"

        elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
            print_success "$targetFile → $sourceFile"
        else

            ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
            if answer_is_yes; then

                rm -rf "$targetFile"

                execute \
                    "ln -fs $sourceFile $targetFile" \
                    "$targetFile → $sourceFile"

            else
                print_error "$targetFile → $sourceFile"
            fi

        fi

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Git\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Git" "git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    printf "\n"

    brew_install "Delta" "git-delta"

    download_delta_themes

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    printf "\n"

    brew_install "GnuPG" "gnupg"
    brew_install "Pinentry" "pinentry-mac"

    configure_gpg

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    printf "\n"

    create_gitconfig_local
    create_git_file_symlinks

}

main
