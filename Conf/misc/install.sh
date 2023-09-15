#!/bin/bash

print_usage() {
    cat << EOF >&2
Description:
This script sets up misc bin config files

Usage: $(basename "$0") [options]

options:
    -h      Show help

EOF
exit 1
}

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

# Install terminator config
if [ ! -d "$HOME/.config/terminator" ]; then
    echo "Installing terminator config"
    /usr/bin/mkdir -p "$HOME/.config/terminator"
    /usr/bin/ln "$(dirname $0)/terminator/config" "$HOME/.config/terminator/config"
fi

# Install git config
if [ ! -f "$HOME/.gitconfig" ]; then
    echo "Installing git config"
    /usr/bin/ln "$(dirname $0)/git/.gitconfig" "$HOME/.gitconfig"
fi

