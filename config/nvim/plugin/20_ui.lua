vim.pack.add({
  {
    src = _G.xyz.gh("folke/tokyonight.nvim"),
    name = "tokyonight",
  },
  _G.xyz.gh("folke/which-key.nvim"),
  _G.xyz.gh("stevearc/oil.nvim"),
  _G.xyz.gh("nvim-lualine/lualine.nvim"),
})

-- colorscheme
require("tokyonight")
vim.cmd("colorscheme tokyonight-storm")

-- whichkey
local wk = require("which-key")
vim.opt.timeout = true
vim.opt.timeoutlen = 300

wk.setup({
  plugins = { spelling = true },
})

wk.add({
  {
    mode = { "n", "v" },
    { "<leader><tab>", group = "tab" },
    { "<leader>c", group = "code" },
    { "<leader>f", group = "files" },
    { "<leader>g", group = "git" },
    { "<leader>gh", group = "hunks" },
    { "<leader>l", group = "lsp" },
    { "<leader>s", group = "search" },
    { "<leader>v", group = "nvim" },
    { "<leader>x", group = "quickfix/loclist" },
    { "[", group = "prev" },
    { "]", group = "next" },
    { "g", group = "goto" },
  },
})

-- file explorer: oil
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

_G.xyz.keybind_set("n", "<leader>e", "<CMD>Oil<CR>", "File Explorer")

-- lualine
require("lualine").setup({
  options = {
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_b = { "diagnostics" },
    lualine_c = {
      { "filename", path = 3 },
    },
    -- FIX: lsp and filetype not showing
    lualine_x = {
      "branch",
      {
        function()
          local buf_ft = vim.bo[0].filetype
          local clients = vim.lsp.get_client()

          if next(clients) == nil then
            return buf_ft
          end

          local active_lsp = {}
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              table.insert(active_lsp, client.name)
            end
          end

          if #active_lsp == 0 then
            return buf_ft
          end

          return buf_ft .. ": " .. table.concat(active_lsp, ", ")
        end,
        icon = "",
      },
    },
  },
})

-- deferred

local setup_deferred = _G.xyz.deferred_packadd({
  {
    src = _G.xyz.gh("catgoose/nvim-colorizer.lua"),
    -- FIXME: latest main has issues with git submodules
    version = "85a5e83cd4daa258cf95c3204e277991d6fbe747",
  },
})

setup_deferred(function()
  -- colorizer
  require("colorizer").setup({
    -- Don't auto enable by filetype
    filetypes = {},
    options = {
      parsers = {
        css = true,
        css_fn = true,
        names = {
          enabled = false,
        },
        hex = {
          enabled = true,
          rgb = true,
          rrggbb = true,
        },
        tailwind = {
          enabled = true,
          lsp = true,
        },
      },
      display = {
        mode = "virtualtext",
        virtualtext = {
          position = "after",
        },
      },
    },
  })
end)
