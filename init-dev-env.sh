#!/bin/bash

print_usage() {
    cat << EOF >&2
Description:
This script sets up Schecter's prefered dev environment on new machines

Usage: $(basename "$0") [options]

options:
    -c      Install config files only
    -d      Install deps only
    -h      Show help

EOF
exit 1
}

INST_CONF="Conf"
INST_DEPS="Deps"
ARY_INSTALL_DIRS=(
    $INST_DEPS
    $INST_CONF
)

POSITIONAL_PARAMS=""
while (( "$#" )); do
	case "$1" in
        -c)
            ARY_INSTALL_DIRS=($INST_CONF)
            shift
            ;;
        -d)
            ARY_INSTALL_DIRS=($INST_DEPS)
            shift
            ;;
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

# Call install foreach install dir
for _install in ${ARY_INSTALL_DIRS[@]}; do
    $_install/install.sh
done
