source ~/.local/share/blesh/ble.sh

# measure the time of previous command execution
ble-import contrib/prompt-elapsed
bleopt prompt_rps1='\n\g{fg=#394260}\g{fg=#769ff0,bg=#394260} \q{contrib/elapsed} \g{fg=#769ff0,bg=#394260}\g{fg=#394260,bg=#769ff0} \q{contrib/elapsed-cpu} \g{fg=#a3aed2,bg=#769ff0}\g{fg=#090c0c,bg=#a3aed2} \g{#a3aed2}▓▒░'

# fzf should be sourced after ble
# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
  # Note: If you would like to combine fzf-completion with bash_completion, you
  # need to load bash_completion earlier than fzf-completion.

  #source /path/to/bash_completion.sh

  if [[ ${BLE_VERSION-} ]]; then
    ble-import -d integration/fzf-completion
  fi
fi

# Key bindings
# ------------
if [[ ${BLE_VERSION-} ]]; then
  ble-import -d integration/fzf-key-bindings
fi
