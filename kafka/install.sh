#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/setup.sh" \
    && . "../utils/download.sh" \
    && cd ..

declare -r KAFKA_FILE="kafka/kafka"
declare -r KAFKA_TARBALL_URL=https://dlcdn.apache.org/kafka/3.1.0/kafka_2.13-3.1.0.tgz

declare -r KAFKA_DOCKER_FILE="docker-compose.yml"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_kafka() {

    local tmpFile=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    tmpFile="$(mktemp /tmp/XXXXX)"

    download "$KAFKA_TARBALL_URL" "$tmpFile"
    print_result $? "Download kafka archive"
    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    mkdir -p "$KAFKA_FILE"
    print_result $? "Create kafka binary files"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Extract archive in the `kafka` directory.

    extract "$tmpFile" "$KAFKA_FILE"
    print_result $? "Extract archive"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    rm -rf "$tmpFile"
    print_result $? "Remove archive"

}

install_kafka_docker() {

    #TODO: docker-compose.yml
    print_success "Docker compose installing...."

}

main() {

    print_in_purple "\n   Kafka\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ ! -d $KAFKA_FILE ]; then
        install_kafka
    else
        print_success "Kafka already installed"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ ! -f $KAFKA_DOCKER_FILE ]; then
        install_kafka_docker
    else
        print_success "Kafka docker compose already installed"
    fi

}

main
