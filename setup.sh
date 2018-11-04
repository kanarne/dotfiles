#!/usr/bin/env bash
set -euo pipefail

os_type() {
  echo `uname -s`
}

symlink() {
  for f in $( ls . ); do
    [[ "$f" == "setup.sh" ]] && continue
    if [ "$(os_type)" = "Linux" ]; then
      [[ "$f" == "tmux.conf" ]] && continue
    fi
    ln -s -f $HOME/dotfiles/$f  $HOME/.$f
  done
}

if [ "$(os_type)" = "Darwin" ]; then
  symlink
elif [ "$(os_type)" = "Linux" ]; then
  symlink
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
