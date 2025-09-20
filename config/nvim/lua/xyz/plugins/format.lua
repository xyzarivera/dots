local keybind = require("xyz.utils.keybind")

return {
  {
    "stevearc/conform.nvim",
    -- event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        ["*"] = { "trim_whitespace" },
        -- disable formatter to let autocmd eslint run instead
        javascript = {},
        javascriptreact = {},
        typescript = {},
        typescriptreact = {},
        vue = {},
        svelte = {},
        css = { "stylelint" },
        json = { "fixjson" },
      },
    },
    init = function()
      vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

      keybind.set("", "<leader>=", function()
        require("conform").format(
          { async = true, lsp_fallback = true },
          function()
            vim.cmd("w!")
          end
        )
      end, "Code: Format Buffer")
    end,
  },
}
