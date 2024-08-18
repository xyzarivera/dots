vim.g.mapleader = " "

-- Eagerly disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("xyz.opts")
require("xyz.keybinds")
require("xyz.autocmd")
require("xyz.terminal")
require("xyz.plugins")
require("xyz.commands")
