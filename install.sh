#!/bin/bash

if [ "$1" == "vim" ]; then
	VIMRC=~/.vimrc
	VIMDIR=~/.vim
	VIMPLUG=~/.vim/autoload/plug.vim
	COCSETTINGS=~/.vim/coc-settings.json
elif [ "$1" == "nvim" ]; then
	VIMRC=~/.config/nvim/init.vim
	VIMDIR=~/.local/share/nvim
	VIMPLUG=~/.local/share/nvim/site/autoload/plug.vim
	COCSETTINGS=~/.config/nvim/coc-settings.json
else
	echo "Usage: $0 [vim|nvim]"
	exit 1
fi

if ! command -v $1 &> /dev/null; then
	echo "Error: $1 not installed"
	echo "Install vim with sudo apt install vim"
	echo "Install neovim with sudo apt install neovim"
	exit 1
fi

if ! command -v node &> /dev/null; then
	echo "Error: NodeJS is not installed"
	echo "Install with curl -sL install-node.now.sh/lts | bash"
	exit 1
fi

echo "Removing old $1 files"
rm -rf $VIMRC $VIMDIR

echo "Downloading config"
curl -sLo $VIMRC --create-dirs https://raw.githubusercontent.com/truelossless/vimrc/master/init.vim
curl -sLo $COCSETTINGS --create-dirs https://raw.githubusercontent.com/truelossless/vimrc/master/coc-settings.json

echo "Downloading plugin manager"
curl -sLo $VIMPLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Downloading plugins"
$1 -E -s -u $VIMRC +PlugInstall +qall
