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
VIM_HOME="$HOME/.vim"

COLOR_GREEN='\033[0;32m'
COLOR_BLUE='\033[0;34m'
COLOR_NONE='\033[0m'

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
echo "Installing VIM source config"
/usr/bin/cp $VIM_CONF_DIR/vimrc $HOME/.vimrc

# Install vim-plug
if [ ! -d $VIM_HOME/autoload/plug.vim ]; then
    echo -e "Installing vim-plug plugin manager..."
    curl -fLo $VIM_HOME/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# vim-plug to install plugins
echo "Installing VIM ${COLOR_GREEN}plugins${COLOR_NONE}..."
/usr/bin/vim +PlugInstall +qall

# coc install extensions
echo -e "Installing VIM ${COLOR_GREEN}coc extensions${COLOR_NONE}..."
ARY_COC_EXT=(
    "coc-json"
    "coc-html"
    "coc-spell-checker"
    "coc-markdownlint"
    "coc-sh"
    "coc-java"
    "coc-docker"
    "coc-pyright"
    "coc-clangd"
)
for _ext in ${ARY_COC_EXT[@]}; do
    echo -e "\t${COLOR_BLUE}$_ext${COLOR_NONE}"
    vim -c "CocInstall -sync $_ext|q" &> /dev/null
done
echo "Finished!"

# coc settings
/usr/bin/cp $VIM_CONF_DIR/coc-settings.json $VIM_HOME
