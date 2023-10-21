#!/usr/bin/env zsh

# files to symlink
files=(
  config/alacritty
  config/skhd
  tmux.conf
  ideavimrc
  config/lazygit
)

# symlink-ing
for f in $files; do
  dest="$HOME/.$f"

  #fails if file exists
  #check prev file is symlinked
  # -L checks file is a symlink
  if [[ -L "$dest" ]]; then
    # we unlink instead of rm -rf to avoid unwanted deletion of actual source
    # unlink is deleteion of symlink file
    unlink "$dest"

    # -f checks if provided path is a file
    # -d is a directory 
  elif [[ -f "$dest" || -d "$dest" ]]; then
    echo "Failed to symlink $dest; Non symlinked file/dir exists"
    continue
  fi

  # ln = link
  # -s = symbolic
  ln -s "$PWD/$f" "$dest"
done
