#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils/setup.sh" \
    && . "utils/brew.sh" \
    && cd ..

declare -r DOTFILES_ROOT="$HOME/.dotfiles"
declare -r ZSHRC_FILE="$HOME/.zshrc"

declare -r ALIASES_FILE="$DOTFILES_ROOT/link/.aliases"
declare -r EXPORTS_FILE="$DOTFILES_ROOT/link/.exports"
declare -r INITS_FILE="$DOTFILES_ROOT/link/.inits"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_link_directory() {

    if [ ! -d "link" ]; then
        mkdir link
    fi

}

create_zsh_files() {

    create_file $INITS_FILE
    create_file $ALIASES_FILE
    create_file $EXPORTS_FILE

}

create_file() {

    if [ ! -f $1 ]; then
        touch $1
    else
        # reset file
        echo > $1
    fi

}

configure_aliases() {

    # find the aliases and run them iteratively
    find . -name alias.sh | while read aliasFile ; do source_file ${aliasFile:1} ${ALIASES_FILE} ; done

    print_success "Aliases configured"

}

configure_exports() {

    # find the exports and run them iteratively
    find . -name export.sh | while read exportFile ; do source_file ${exportFile:1} ${EXPORTS_FILE} ; done

    print_success "Exports created"

}

configure_inits() {

    # find the inits and run them iteratively
    find . -name init.sh | while read initFile ; do source_file ${initFile:1} ${INITS_FILE}  ; done

    print_success "Inits created"

}

source_file() {
    echo "source $DOTFILES_ROOT$1" >> $2
}

configure_zshrc_file() {

    if [ ! -f $ZSHRC_FILE ]; then
        touch $ZSHRC_FILE
    else 
        # reset file
        echo > $ZSHRC_FILE
    fi

    # zsh file linked to .zshrc

    echo "source $ALIASES_FILE" >> $ZSHRC_FILE
    echo "source $EXPORTS_FILE" >> $ZSHRC_FILE
    echo "source $INITS_FILE" >> $ZSHRC_FILE

    printf "\n"
    print_success "Zshrc file configured"

}

refresh_zsh() {

    ask_for_confirmation "Do you want to refresh zsh?"
    printf "\n"

    if answer_is_yes; then
        exec zsh
    fi
    
}

main() {

    print_in_purple "\n\n • Zsh configures\n\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    create_link_directory
    create_zsh_files

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    configure_aliases
    configure_exports
    configure_inits

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    configure_zshrc_file

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    refresh_zsh

}

main
