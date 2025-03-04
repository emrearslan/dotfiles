#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   General\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Cancel all scheduled wake requests
    #
    # pmset -g log | grep "Wake Requests"  --> show macos wake request logs
    # pmset -g sched  --> show scheduled wake requests
    # sudo pmset schedule cancelall  --> cancel all scheduled wake requests
    #
    # source: https://x.com/sezeriltekin/status/1526886645324300288
    
    execute "sudo pmset schedule cancelall" \
        "Set home folder to new winder show folder"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

}

main
