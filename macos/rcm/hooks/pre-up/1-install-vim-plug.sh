#!/usr/bin/env bash

if [ ! -e $HOME/.config/nvim/autoload/plug.vim ]; then
  curl -fLo "$HOME/.config/nvim/autoload/plug.vim" \
      --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
