#!/bin/bash

print_usage() {
    cat << EOF >&2
Description:
This script sets up bash config files

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

# Run install on each conf dir
CUR_DIR=$(dirname $0)
mapfile -t ARY_CONFS < <(/usr/bin/find $CUR_DIR -maxdepth 1 -type d)
for _confs in ${ARY_CONFS[@]}; do
    if [ "$_confs" != "$CUR_DIR" ]; then
        $_confs/install.sh
    fi
done
