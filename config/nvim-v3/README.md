# Neovim

## Applying changes

Applying changes from the current file.
This implies that said file is loaded to the `index.lua`

```
:source %
```

## Neovim Plugins

1. Create a new file `./config/nvim/lua/xyz/plugins/<pluginName>.lua`
2. Add import the plugin in `./config/nvim/lua/xyz/plugins/init.lua`
3. Run `./setup.sh` to load the new plugin to Neovim
