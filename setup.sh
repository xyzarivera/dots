#!/usr/bin/env zsh

# files to symlink
files=(
  config/alacritty
  config/skhd
  config/lazygit
  config/nvim
  tmux.conf
  # zshenv
  # zshrc
  # ideavimrc
  # git-hooks
)

cpFiles=(
  # gitconfig
  # gitconfig-work
)

if [[ ! -d "$HOME/.config" ]]; then
  echo "$HOME/.config does not exist. Creating now."
  mkdir -p "$HOME/.config"
fi

for f in $files; do
  dest="$HOME/.$f"

  # Check if file is a symlink (-L) 
  if [[ -L "$dest" ]]; then
    # we unlink instead of rm -rf to avoid unwanted deletion of actual source
    # unlink is "deletion" equivalent of symlink file
    unlink "$dest"

    # -f checks if file
    # -d if directory 
  elif [[ -f "$dest" || -d "$dest" ]]; then
    echo "Failed to symlink $dest; Non symlinked file/dir exists"
    continue
  fi

  # create a symbolic (-s) link (ln)
  ln -s "$PWD/$f" "$dest"
done
