ad() {
    if [[ "$#" -ne 1 ]]
    then
        echo "USAGE: ad <alias>"
        return 0
    elif [[ -n "$(alias $1 2>/dev/null)" ]]
    then
        echo "Alias already exists!"
        return 0
    fi

    echo -e "alias $1=\"cd $(pwd)\"" >> ~/.zsh/aliases.zsh
    source ~/.zshrc
    echo "Alias was added successfully."
}

# What's running on a port
function wop() {
    cmd="lsof -i -P -n | grep LISTEN | grep :$1"
    echo -e "\e[2mlsof -i -P -n | grep LISTEN | grep :$1\e[0m"
    lsof -i -P -n | grep LISTEN | grep :$1
    local exitcode=$?
    if [ $exitcode -ne 0 ]; then
        echo "Nothing listening on port $1";
    fi
    return $exitcode;
}


function preexec() {
  timer=$(($(gdate +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(gdate +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    export RPROMPT="%F{cyan}${elapsed}ms %{$reset_color%}"
    unset timer
  fi
}
