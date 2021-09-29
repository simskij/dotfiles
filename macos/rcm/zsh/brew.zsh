if [ ! -f ~/.brew.zsh ]; then
  brew shellenv > ~/.brew.zsh
fi

source ~/.brew.zsh