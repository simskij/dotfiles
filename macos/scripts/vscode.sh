install_vscode_extensions() {
  cat assets/vscode-extensions | xargs -L1 code --install-extension
}