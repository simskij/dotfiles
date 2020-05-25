#!/usr/bin/env bash

if ! [ -x "$(which brew)" ]; then
  /usr/bin/ruby -e \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

source ./scripts/brew.sh
source ./scripts/macos.sh
source ./scripts/zsh.sh
source ./scripts/vim.sh
source ./scripts/vscode.sh

install_brew

rcup -v -f -d $(pwd)/rcm

configure_macos_tray

install_vscode_extensions
install_vundle
install_zsh
install_minimal_improved