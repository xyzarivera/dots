return {
 "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.o.background = "dark"
    vim.cmd("colorscheme tokyonight-night")
  end,
}
