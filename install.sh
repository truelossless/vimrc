#!/bin/bash

if [ "$1" == "vim" ] && [ "$1" != "nvim" ]; then
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

if ! command -v node &> /dev/null; then
	echo "NodeJS is required"
	echo "Install with curl -sL install-node.now.sh/lts | bash"
	exit 1;
fi

echo "Removing old vim files"
rm -rf $VIMRC $VIMDIR

echo "Downloading config"
curl -sLo $VIMRC --create-dirs https://raw.githubusercontent.com/truelossless/vimrc/master/init.vim

echo "Downloading plugin manager"
curl -sLo $VIMPLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Downloading plugins"
$1 -c "PlugInstall" -c "qa"
echo "Downloading langage extensions"
$1 -c "CocInstall -sync coc-json coc-tsserver coc-html coc-rust-analyzer coc-clangd" -c "qa"
echo "All set !"