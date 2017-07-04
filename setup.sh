#!/usr/bin/env bash
set -euo pipefail

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  ln -s -f $HOME/dotfiles/$f  $HOME/$f
done

chsh -s $(which zsh)
