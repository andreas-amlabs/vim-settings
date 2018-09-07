#!/bin/bash                                                                                                                                                                                                                                    

create_dir() {
	echo "mkdir -p $1"
	mkdir -p $1
}

clone() {
	echo "git clone $1 $2"
	git clone $1 $2
}


set -- \
tpope https://github.com/tpope/vim-fugitive.git tpope vim-fugitive \
vim-airline https://github.com/vim-airline/vim-airline.git vim-airline vim-airline \
kchmck https://github.com/kchmck/vim-coffee-script.git kchmck vim-coffee-script \
kien https://github.com/kien/ctrlp.vim.git kien ctrlp.vim \
scrooloose https://github.com/scrooloose/nerdtree.git scrooloose nerdtree \
Mistobaan https://github.com/Mistobaan/pyclewn.git Mistobaan pyclewn \
vim-scipts https://github.com/vim-scripts/CCTree.git vim-scipts CCTree \
vim-scipts https://github.com/vim-scripts/cream-showinvisibles.git vim-scipts cream-showinvisibles \
Valloric https://github.com/Valloric/YouCompleteMe.git Valloric YouCompleteMe

while (( $# )) ; do
	dir=$1
	git_path=$2
	name=$3
	git_name=$4
	shift 4
	create_dir ./.vim/pack/$dir/start
	clone $git_path ./.vim/pack/$name/start/$git_name
done

# YouCompleteMe post install
pushd .                                                                                                                                                                                                                                        
cd .vim/pack/Valloric/start/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer
popd

