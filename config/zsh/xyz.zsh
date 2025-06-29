scripts_dir="${0:A:h}"

scripts=(
  plugins.zsh
  completions.zsh # Should be after plugins if there are completion plugins
  directories.zsh
  history.zsh
  keybinds.zsh
  misc.zsh
  spectrum.zsh
  theme.zsh
)

for s in $scripts; do
  source "$scripts_dir/$s"
done

unset scripts_dir
unset scripts
