# unlimited history
export HISTFILESIZE=
export HISTSIZE=
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

alias ls='ls_extended -Alsh'

PS1='[\u@\h \W]\$ '

alias cat=bat
