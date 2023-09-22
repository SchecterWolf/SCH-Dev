#!/bin/bash
########################################################################################
## Script Name	: install.sh
## Author      	: Schecter Wolf
## Email       	: schecterwolfe@gmail.com
## License 		: Copyright (C) 2023  Schecter Wolf
##
## 				  This program is free software: you can redistribute it and/or modify
## 				  it under the terms of the GNU General Public License as published by
## 				  the Free Software Foundation, either version 3 of the License, or
## 				  (at your option) any later version.
##
## 				  This program is distributed in the hope that it will be useful,
## 				  but WITHOUT ANY WARRANTY; without even the implied warranty of
## 				  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## 				  GNU General Public License for more details.
##
## 				  You should have received a copy of the GNU General Public License
## 				  along with this program.  If not, see <http://www.gnu.org/licenses/>.
## Description	: Installs vim, vim plugins, and plugin support files
########################################################################################

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
cp -p $VIM_CONF_DIR/vimrc $HOME/.vimrc

# Install vim-plug
if [ ! -d $VIM_HOME/autoload/plug.vim ]; then
    echo -e "Installing vim-plug plugin manager..."
    curl -fLo $VIM_HOME/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# vim-plug to install plugins
echo -e "Installing VIM ${COLOR_GREEN}plugins${COLOR_NONE}..."
vim +PlugInstall +qall

# coc install extensions
echo -e "Installing VIM ${COLOR_GREEN}coc extensions${COLOR_NONE}..."
ARY_COC_EXT=(
    "coc-clangd"
    "coc-docker"
    "coc-html"
    "coc-java"
    "coc-json"
    "coc-markdownlint"
    "coc-pyright"
    "coc-sh"
    "coc-snippets"
    "coc-spell-checker"
)
for _ext in ${ARY_COC_EXT[@]}; do
    echo -e "\t${COLOR_BLUE}$_ext${COLOR_NONE}"
    vim -c "CocInstall -sync $_ext|q" &> /dev/null
done
echo "Finished!"

# TODO Can't seem to get this to work unless I manually open a cpp file with vim and
#      issue the CocCommand
# Installing coc-clangd clang path
#echo -e "Installing ${COLOR_GREEN}clangd${COLOR_NONE}..."
#vim -c ":sleep 5|CocCommand clangd.install" file.cpp &> /dev/null
#echo "Finished!"

# coc settings
cp $VIM_CONF_DIR/coc-settings.json $VIM_HOME

# Install my custom ultisnips
cp -r $VIM_CONF_DIR/ultisnips $HOME/.config/coc

