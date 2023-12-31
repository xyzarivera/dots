return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
     "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>0",
        ":LazyGit<CR>",
        mode = "n",
        desc = "Open LazyGit",
      },
    },
    init = function()
      vim.g.lazygit_floating_window_winblend = 0
    end
  }
}
