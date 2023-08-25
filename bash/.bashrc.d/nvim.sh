nvim_and_clear() {
    nvim "$@" && clear
}

alias vim=nvim_and_clear
