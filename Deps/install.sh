#!/bin/bash

print_usage() {
    cat << EOF >&2
Description:
This script sets up dev config files

Usage: $(basename "$0") [options]

options:
    -h      Show help

EOF
exit 1
}

SUDO='/usr/bin/sudo'

POSITIONAL_PARAMS=""
while (( "$#" )); do
	case "$1" in
		--help|-*|--*=) # unsupported flags
			print_usage
			;;
		*) # preserve positional arguments
            POSITIONAL_PARAMS="$POSITIONAL_PARAMS $1"
            shift
            ;;
	esac
done
eval set -- "$POSITIONAL_PARAMS"

# Install dev env bins
ARY_APT_BINS=(
    "ansible"
    "build-essential"
    "cppcheck"
    "docker"
    "git"
    "git-gui"
    "gitk"
    "gdb"
    "htop"
    "nmap"
    "screen"
    "terminator"
    "valgrind"
    "vim"
    "wireshark"
    "openjdk-17-jdk-headless"
)
ARY_SNAP_BINS=(
    "drawio"
    "postman"
)

# PPA repos (assumed trusted)
sudo add-apt-repository ppa:jonathonf/vim

# apt installs
$SUDO apt update
$SUDO apt install "${ARY_APT_BINS[@]}"
$SUDO apt autoclean
$SUDO apt autoremove

# snap installs
$SUDO snap install "${ARY_SNAP_BINS[@]}"

# Install nodejs
if [ "$(command -v node)" == "" ]; then
    echo "Attempting to install the most recent nodejs..."

    sudo apt-get install -y ca-certificates curl gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

    NODE_MAJOR=20
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

    sudo apt-get update
    sudo apt-get install nodejs -y
fi

