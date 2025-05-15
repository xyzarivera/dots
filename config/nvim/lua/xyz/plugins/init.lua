-- Install Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  print("lazy just installed, please restart neovim")
  return
end

lazy.setup({
  spec = {
    { "folke/lazy.nvim", version = "*" },
    require("xyz.plugins.colorscheme"),
    require("xyz.plugins.git"),
    require("xyz.plugins.whichkey"),
    require("xyz.plugins.files"),
    require("xyz.plugins.notes"),
    require("xyz.plugins.telescope"),
    require("xyz.plugins.ime"),
    require("xyz.plugins.lualine"),
    require("xyz.plugins.treesitter"),
    require("xyz.plugins.utilities"),
    require("xyz.plugins.trouble"),
    require("xyz.plugins.mason"),
    require("xyz.plugins.cmp"),
    require("xyz.plugins.lsp"),
    require("xyz.plugins.format"),
    require("xyz.plugins.hardtime"),
  },
  install = {
    missing = true,
  },
})
