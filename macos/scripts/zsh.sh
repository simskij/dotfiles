install_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
}
install_minimal_improved() {
  if [[ ! -a ~/.oh-my-zsh/themes/minimal_improved.zsh-theme ]]; then
    echo Installing the Minimal Improved theme
    git clone git@github.com:gdsrosa/minimal_improved.git
    mv ./minimal_improved/minimal_improve.zsh-theme \
      ~/.oh-my-zsh/themes/minimal_improved.zsh-theme
    rm -rf minimal_improved
  else
    echo Minimal Improved theme already installed
  fi

}