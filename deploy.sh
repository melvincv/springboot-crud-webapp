#!/bin/bash
# Should all stopped containers be removed?
DO_PRUNE=0
CLEAR_ENV_FILE=1

# Check if run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script needs to be run as root" >&2
    exit 1
fi

# APT update
apt update

# Check for Docker
if [ ! -e "/usr/bin/dockerd" ]; then
    echo "Docker is not present. Installing..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
fi

# Remove stopped containers
if [ "$DO_PRUNE" -eq 1 ]; then
    docker container prune
fi

# Run the compose stack
docker compose pull
docker compose up -d

# Clear env file after use
if [ "$CLEAR_ENV_FILE" -eq 1 ]; then
    sleep 5
    rm -f .env
fi
