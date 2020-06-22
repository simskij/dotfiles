# Convenience
alias reload='source ~/.zshrc'
alias auth="ssh-add ~/.ssh/id_rsa"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias whatsmyip="curl ifconfig.co"
alias psgr='ps auxw | grep'
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Dev
alias mg="meta git"
alias g="git"
alias y="yarn"
alias pip="pip3"
alias gg="go get"
alias ll="ls -la"
# alias ls="colorls -1"
# Learn, you lazy fuck
alias vi="nvim"
alias vim="nvim"
alias nano="nvim"

# tmux
alias tmh="tmux splitw -h"
alias tmv="tmux splitw -v"

# go 
alias rgt="reflex -r '\.go$' -- sh -c 'clear && go test ./...'"

# path aliases
alias dotfiles="cd ~/code/simskij/dotfiles"
alias watchtower="cd ~/code/containrrr/watchtower"

# New and unsorted
# ---
#
alias k="kubectl"
alias ka="kubectl apply"
alias load-chaos="source ~/.venvs/chaostk/bin/activate"
