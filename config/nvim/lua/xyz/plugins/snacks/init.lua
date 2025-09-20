return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    specs = {
      require("xyz.plugins.snacks.picker"),
      require("xyz.plugins.snacks.lazygit"),
      require("xyz.plugins.snacks.indent"),
    },
  },
}
