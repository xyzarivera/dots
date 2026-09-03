#!/usr/bin/env zsh

echo "( • ̀ω•́ )✧ symlinking config files"
# files to symlink
symFiles=(
  config/alacritty
  config/ghostty
  config/zsh
  config/skhd
  config/lazygit
  config/nvim
  config/nvim-12
  tmux.conf
  zshenv
  zshrc
  # ideavimrc
  # git-hooks
)


if [[ ! -d "$HOME/.config" ]]; then
  echo "( • ̀ω•́ )✧ $HOME/.config does not exist. Creating now."
  mkdir -p "$HOME/.config"
fi

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


echo "( • ̀ω•́ )✧ copying normal files"
# files to copy once only
cpFiles=(
  gitconfig
  gitconfig-work-template
)

for cpF in $cpFiles; do
  dest="$HOME/.$cpF"

  if [[ ! -f "$dest" && ! -d "$dest" ]]; then
    echo "(｡- .•) $dest does not exist. Copying now."
    cp "$PWD/$cpF" "$dest"
  fi
done

echo "( • ̀ω•́ )✧ symlinking ai config files"

sharedAiConfig=(
  skills
)

aiConfigPaths=(
  kiro
  claude
)

for configPath in $aiConfigPaths; do
  for config in $sharedAiConfig; do
    dest="$HOME/.$configPath/$config"

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
    ln -s "$PWD/ai/$config" "$dest"
  done
done

echo "(づ ᴗ _ᴗ)づ DONE"
