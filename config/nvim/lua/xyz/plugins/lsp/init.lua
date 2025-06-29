local keybind = require("xyz.utils.keybind")
local lsp = require("xyz.utils.lsp")

-- TODO: Move this to separate server files
local XYZ_LSP_CONFIG = {
  cssls = {},
  tailwindcss = {
    filetypes = { "vue", "html", "css", "scss", "tsx", "svelte" },
  },
  eslint = {},
  jsonls = { filetypes = { "json", "jsonc" } },
  stylelint_lsp = {
    settings = {
      stylelintplus = {
        autoFixOnFormat = true,
      },
    },
  },
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
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
      },
    },
  },
  ts_ls = {
    before_init = function(_, config)
      table.insert(config.init_options.plugins, {
        name = "@vue/typescript-plugin",
        languages = { "vue" },
        location = vim.fn.expand(
          "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
        ),
      })
    end,
    init_options = {
      plugins = {},
    },
    filetypes = {
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "vue",
    },
    commands = {
      OrganizeImports = {
        function()
          Client:exec_cmd({
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
          })
        end,
        description = "Organize Imports",
      },
    },
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },
    },
  },
  svelte = {},
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "nvim-telescope/telescope.nvim" },
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
      local server_names = {}
      for server_name, _ in pairs(XYZ_LSP_CONFIG) do
        table.insert(server_names, server_name)
      end

      require("mason-lspconfig").setup({
        ensure_installed = server_names,
        automatic_installation = true,
      })

      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local get_mason_servers = require("mason-lspconfig").get_installed_servers

      vim.diagnostic.config({ virtual_text = true })

      for _, server_name in ipairs(get_mason_servers()) do
        local xyz_lsp_config = XYZ_LSP_CONFIG[server_name] or {}

        vim.lsp.config(
          server_name,
          vim.tbl_deep_extend("force", {
            capabilities = lsp_capabilities,
          }, xyz_lsp_config)
        )
      end

      local function setup_keybindings(args)
        keybind.set("n", "<leader>cli", "<cmd>LspInfo<CR>", "LSP: Info")
        keybind.set("n", "<leader>clr", "<cmd>LspRestart<CR>", "LSP: Restart")

        keybind.set(
          "n",
          "gD",
          vim.lsp.buf.declaration,
          "LSP: Goto declaration",
          { buffer = args.buf }
        )
        keybind.set("n", "gI", function()
          require("telescope.builtin").lsp_implementations({ reuse_win = true })
        end, "LSP: Goto Implementation")
        keybind.set("n", "gy", function()
          require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end, "LSP: Goto Type Definition")

        keybind.set(
          "n",
          "K",
          vim.lsp.buf.hover,
          "LSP: Hover",
          { buffer = args.buf }
        )

        if lsp.supports("textDocument/definition", args.buf) then
          keybind.set("n", "gd", function()
            require("telescope.builtin").lsp_definitions({ reuse_win = true })
          end, "LSP: Goto definition", { buffer = args.buf })
        end

        if lsp.supports("textDocument/References", args.buf) then
          keybind.set(
            "n",
            "gr",
            "<cmd>Telescope lsp_references<CR>",
            "LSP: Find Usages",
            { buffer = args.buf }
          )
        end

        if lsp.supports("textDocument/signatureHelp", args.buf) then
          keybind.set(
            "n",
            "gK",
            vim.lsp.buf.signature_help,
            "LSP: Signature Help",
            { buffer = args.buf }
          )
          keybind.set(
            "i",
            "<C-k>",
            vim.lsp.buf.signature_help,
            "LSP: Signature Help",
            { buffer = args.buf }
          )
        end

        if lsp.supports("textDocument/codeAction", args.buf) then
          keybind.set(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            "LSP: Code Actions",
            { buffer = args.buf }
          )

          keybind.set("n", "<leader>cA", function()
            vim.lsp.buf.code_action({
              context = { only = { "source" }, diagnostics = {} },
            })
          end, "LSP: Source Action", { buffer = args.buf })
        end

        if lsp.supports("textDocument/rename", args.buf) then
          keybind.set(
            "n",
            "<leader>cr",
            vim.lsp.buf.rename,
            "LSP: Rename",
            { buffer = args.buf }
          )
        end

        if lsp.supports("textDocument/codeLens", args.buf) then
          keybind.set(
            { "n", "v" },
            "<leader>cc",
            vim.lsp.codelens.run,
            "LSP: Run CodeLens",
            { buffer = args.buf }
          )
          keybind.set(
            { "n", "v" },
            "<leader>cC",
            vim.lsp.codelens.refresh,
            "LSP: Refresh and Display CodeLens",
            { buffer = args.buf }
          )
        end
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          if
            lsp.supports("textDocument/inlayHint", args.buf)
            and vim.api.nvim_buf_is_valid(args.buf)
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end

          setup_keybindings(args)
        end,
      })
    end,
  },
}
