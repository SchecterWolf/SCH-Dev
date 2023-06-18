#!/bin/bash

print_usage() {
    cat << EOF >&2
Description:
This script sets up vim config files

Usage: $(basename "$0") [options]

options:
    -h      Show help

EOF
exit 1
}

VIM_CONF_DIR=$(dirname $0)

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
/usr/bin/cp $VIM_CONF_DIR/vimrc $HOME/.vimrc

# Install vundle
if [ ! -d $HOME/.vim/bundle/Vundle.vim ]; then
    /usr/bin/mkdir -p $HOME/vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

# VIM vundle to install plugins
/usr/bin/vim +PluginInstall +qall
