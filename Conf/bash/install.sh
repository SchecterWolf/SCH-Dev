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

BASH_CONF_DIR=$(dirname $0)

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

# Install conf files to default system location
echo "Installing bash source configs"
set -x
/usr/bin/cp $BASH_CONF_DIR/bashrc $HOME/.bashrc
/usr/bin/cp $BASH_CONF_DIR/bashrc_aliases $HOME/.bashrc_aliases
{ set +x; } 2>/dev/null

echo "Make sure to source after install!"

