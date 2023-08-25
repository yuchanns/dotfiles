# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d ~/.bashrc.d ] && [ "$(ls -A ~/.bashrc.d)" ]; then
  for file in ~/.bashrc.d/*; do
    . "$file"
  done
fi

