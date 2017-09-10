#!/usr/bin/env bash
set -euo pipefail

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  ln -s -f $HOME/dotfiles/$f  $HOME/$f
done

if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  if [ ! -d $HOME/.pyenv ]; then
    git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
    git clone https://github.com/yyuu/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
  fi
  if [ ! -d $HOME/.zplug ]; then
    git clone https://github.com/zplug/zplug $HOME/.zplug
  fi
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

chsh -s $(which zsh)
