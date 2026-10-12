#!/usr/bin/env zsh

echo "( • ̀ω•́ )✧ symlinking ai config files"
# files to symlink
symFiles=(
  config/opencode/opencode.jsonc
)

for symF in $symFiles; do
  dest="$HOME/.$symF"

  # Check if file is a symlink (-L)
  if [[ -L "$dest" ]]; then
    # we unlink instead of rm -rf to avoid unwanted deletion of actual source
    # unlink is "deletion" equivalent of symlink file
    unlink "$dest"

    # -f checks if file
    # -d if directory
  elif [[ -f "$dest" || -d "$dest" ]]; then
    echo "( ˶°ㅁ°) !! Failed to symlink $dest; Non symlinked file/dir exists"
    continue
  fi

  # create a symbolic (-s) link (ln)
  ln -s "$PWD/$symF" "$dest"
done

# echo "( • ̀ω•́ )✧ symlinking ai config files"

echo "(づ ᴗ _ᴗ)づ DONE"
