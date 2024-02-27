#!/bin/sh

set -eu

DOTFILES_DIR=$(cd $(dirname $0); pwd)
cd $DOTFILES_DIR

for f in .??*; do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".gitconfig" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == ".DS_Stor" ]] && continue
  [[ "$f" == "Icon?" ]] && continue
 	[[ "$f" =~ .swp$ ]] && continue

  ln -s ${DOTFILES_DIR}/$f ~
done
