return {
  {
    "nvim-treesitter/nvim-treesitter", -- syntaxhighlight/parser
    dependencies = {
      { "windwp/nvim-ts-autotag"},
    },
    build = ":TSUpdate",
    config = function ()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all", 
        -- ignore_install = { "po" }, -- ignore file types to syntaxhighlight eg. ignore ".po" files
        indent = { enable = true },
        highlight = { enable = true },
        autotag = { enable = true },
        additional_vim_regex_highlighting = false,
      })
    end
  }
}
