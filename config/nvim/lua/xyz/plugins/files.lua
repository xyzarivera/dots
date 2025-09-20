local keybind = require("xyz.utils.keybind")

return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true
      }
    },
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      keybind.set("n", "<leader>e", "<CMD>Oil<CR>", "File Explorer")
    end,
  },
}
