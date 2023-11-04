return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    main = "lualine",
    opts = {
      options = {
        theme = "synthwave84",
      },
      sections = {
        lualine_c = {
          {"filename", path = 3 }
        }
      }
    },
  }
}
