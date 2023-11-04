local XYZ_LSP_CONFIG = {
  cssls = {},
  tailwindcss = {},
  eslint = {
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = "xyz",
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  },
  tsserver = {
    on_attach = function()
      vim.keymap.set("", "<leader>co", ":OrganizeImports<CR>")
    end,
    commands = {
      OrganizeImports = {
        function()
          vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
          })
        end,
        description = "Organize Imports",
      },
    },
  },
  jsonls = { filetypes = { "json", "jsonc" } },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          -- Prevents getting Undefined global `vim`
          globals = { "vim" },
        },
        workspace = {
          -- Help lua_ls be aware of neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "tailwindcss",
          "tsserver",
          "cssls",
          "emmet_language_server",
          "eslint",
          "lua_ls",
          "stylua",
          "pyrite",
          "black",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      { "zbirenbaum/copilot-cmp" },
    },
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })

      require("copilot_cmp").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
      { "zbirenbaum/copilot.lua" },
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-space>"] = cmp.mapping.complete(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          -- ["<Up>"] = cmp.mapping.select_prev_item(),
          -- ["<Down>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm(),
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-c>"] = cmp.mapping.close(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "copilot" },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    cmd = {
      "LspInfo",
      "LspInstall",
      "LspUninstall",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local get_mason_servers = require("mason-lspconfig").get_installed_servers

      for _, server_name in ipairs(get_mason_servers()) do
        local xyz_lsp_config = XYZ_LSP_CONFIG[server_name] or

        lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
          capabilities = lsp_capabilities,
        }, xyz_lsp_config))
      end

      local function setup_keybindings(args)
        vim.keymap.set(
          "n",
          "<leader>lsp",
          ":silent :LspRestart<CR>",
          { desc = "LSP: Restart" }
        )
        vim.keymap.set(
          "n",
          "<leader>ck",
          vim.lsp.buf.hover,
          { buffer = args.buf, desc = "LSP: Hover" }
        )
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          { desc = "LSP: Code Actions" }
        )
        vim.keymap.set(
          "n",
          "<leader>cr",
          vim.lsp.buf.rename,
          { desc = "LSP: Rename" }
        )
        vim.keymap.set(
          "n",
          "<leader>cd",
          vim.lsp.buf.definition,
          { desc = "LSP: Go to Definition" }
        )
        vim.keymap.set(
          "n",
          "<leader>cu",
          vim.lsp.buf.references,
          { desc = "LSP: Find Usages" }
        )
        vim.keymap.set(
          "n",
          "<leader>ch",
          vim.lsp.buf.signature_help,
          { desc = "LSP: Show Signature Help" }
        )
        vim.keymap.set(
          "n",
          "<leader>ce",
          vim.diagnostic.open_float,
          { desc = "LSP: View Error" }
        )
        vim.keymap.set(
          "n",
          "<leader>c[",
          vim.diagnostic.goto_prev,
          { desc = "LSP: Goto Previous Diagnostic Error" }
        )
        vim.keymap.set(
          "n",
          "<leader>c]",
          vim.diagnostic.goto_next,
          { desc = "LSP: Goto Next Diagnostic Error" }
        )
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = "xyz",
        callback = function(args)
          setup_keybindings(args)
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim", -- formatter
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>=",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format Buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        ["*"] = { "codespell", "trim_whitespace" },
      },
    },
    init = function()
      vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  }
}
