#!/bin/bash

if [ "$1" == "vim" ]; then
	VIMRC=~/.vimrc
	VIMDIR=~/.vim
	VIMPLUG=~/.vim/autoload/plug.vim
elif [ "$1" == "nvim" ]; then
	VIMRC=~/.config/nvim/init.vim
	VIMDIR=~/.local/share/nvim
	VIMPLUG=~/.local/share/nvim/site/autoload/plug.vim
else
	echo "Usage: $0 [vim|nvim]"
	exit 1
fi

if ! command -v $1 &> /dev/null; then
	echo "$1 not installed"
	echo "Install vim with sudo apt install vim"
	echo "Install neovim with sudo apt install neovim"
	exit 1
fi

if ! command -v node &> /dev/null; then
	echo "NodeJS is required"
	echo "Install with curl -sL install-node.now.sh/lts | bash"
	exit 1
fi

echo "Removing old vim files"
rm -rf $VIMRC $VIMDIR

echo "Downloading config"
curl -sLo $VIMRC --create-dirs https://raw.githubusercontent.com/truelossless/vimrc/master/init.vim
curl -sLo $VIMRC --create-dirs https://raw.githubusercontent.com/truelossless/vimrc/master/coc-settings.json

echo "Downloading plugin manager"
curl -sLo $VIMPLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Downloading plugins"
$1 -E -s -u $VIMRC +PlugInstall +qall
echo "All set !"
