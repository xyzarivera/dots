local setup_deferred = _G.xyz.deferred_packadd({
  _G.xyz.gh("nvim-neotest/nvim-nio"),
  _G.xyz.gh("antoinemadec/FixCursorHold.nvim"),
  _G.xyz.gh("xyzarivera/neotest-vitest"),
  _G.xyz.gh("nvim-neotest/neotest"),
})

setup_deferred(function()
  require("neotest").setup({
    adapters = {
      require("neotest-vitest")({
        additional_treesitter_queries = [[
        ; Matches: describe(myFunction.name, () => {})
          ((call_expression
            function: (identifier) @func_name (#eq? @func_name "describe")
            arguments: (arguments
              (member_expression
                object: (identifier) @namespace.name
                property: (property_identifier) (#eq? "name")
              )
              (arrow_function)
            )
          )) @namespace.definition

          ; Matches: describe.only(myFunction.name, () => {})
          ((call_expression
            function: (member_expression
              object: (identifier) @func_name (#eq? @func_name "describe")
              property: (property_identifier) (#eq? "only")
            )
            arguments: (arguments
              (member_expression
                object: (identifier) @namespace.name
                property: (property_identifier) (#eq? "name")
              )
              (arrow_function)
            )
          )) @namespace.definition
        ]],
        vitestCommand = "npx vitest run --coverage=false",

        filter_dir = function(name)
          return name ~= "node_modules"
        end,
      }),
    },
  })

  _G.xyz.keybind_set(
    "n",
    "<leader>ta",
    "<cmd>lua require('neotest').run.run()<cr>",
    "Neotest Vitest: Run All Tests"
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>tf",
    "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
    { desc = "Neotest Vitest: Run File" }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>ts",
    "<cmd>Neotest summary<cr>",
    { desc = "Neotest: Open Summary" }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>to",
    "<cmd>Neotest output<cr>",
    { desc = "Neotest: Open Output" }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>tp",
    "<cmd>Neotest output-panel<cr>",
    { desc = "Neotest: Open Output Panel" }
  )
end)
