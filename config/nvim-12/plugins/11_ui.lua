vim.pack.add({
  {
    src = _G.xyz.gh("folke/tokyonight.nvim"),
    name = "tokyonight",
  }
})

-- colorscheme
require("tokyonight")
vim.cmd("colorscheme tokyonight-storm")

