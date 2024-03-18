return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    main = "lualine",
    opts = {
      options = {
        theme = "tokyonight",
      },
      sections = {
        lualine_c = {
          {"filename", path = 3 }
        }
      }
    },
  }
}
