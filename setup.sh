#!/usr/bin/env bash
set -euo pipefail

os_type() {
  echo `uname -s`
}

symlink() {
  for f in .??*
  do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    if [ "$(os_type)" = "Linux" ]; then
      [[ "$f" == ".tmux.conf" ]] && continue
    fi
    ln -s -f $HOME/dotfiles/$f  $HOME/$f
  done
}

pyenv_download() {
  if [ ! -d $HOME/.pyenv ]; then
    git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
    git clone https://github.com/yyuu/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
  fi
}

zplug_download() {
  if [ ! -d $HOME/.zplug ]; then
    git clone https://github.com/zplug/zplug $HOME/.zplug
  fi
}

vimplug_download() {
  if [ ! -d $HOME/.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

if [ "$(os_type)" = "Darwin" ]; then
  symlink
  pyenv_download
  zplug_download
  vimplug_download
elif [ "$(os_type)" = "Linux" ]; then
  symlink
  pyenv_download
  zplug_download
  vimplug_download
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
