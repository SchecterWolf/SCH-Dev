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
)
ARY_SNAP_BINS=(
    "drawio"
    "postman"
)

# apt installs
$SUDO apt update
$SUDO apt install "${ARY_APT_BINS[@]}"
$SUDO apt autoclean
$SUDO apt autoremove

# snap installs
$SUDO snap install "${ARY_SNAP_BINS[@]}"

