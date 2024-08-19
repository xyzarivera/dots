local keybind = require("xyz.utils.keybind")

return {
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true, auto_close = true, auto_preview = false },
    keys = {},
    init = function()
      keybind.set(
        "n",
        "<leader>xx",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        "Document Diagnostics (Trouble)"
      )
      keybind.set(
        "n",
        "<leader>xX",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        "Workspace Diagnostics (Trouble)"
      )
      keybind.set(
        "n",
        "<leader>xL",
        "<cmd>TroubleToggle loclist<cr>",
        "Location List (Trouble)"
      )
      keybind.set(
        "n",
        "<leader>xQ",
        "<cmd>TroubleToggle quickfix<cr>",
        "Quickfix List (Trouble)"
      )
      keybind.set("n", "[q", function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end, "Previous trouble/quickfix item")
      keybind.set("n", "]q", function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end, "Next trouble/quickfix item")
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {
      signs = false,
    },
    init = function()
      keybind.set( "n", "]t", function() require("todo-comments").jump_next() end, "Next todo comment" )
      keybind.set( "n", "[t", function() require("todo-comments").jump_prev() end, "Previous todo comment" )
      keybind.set( "n", "<leader>xt", "<cmd>TodoTrouble<cr>", "Todo (Trouble)" )
      keybind.set( "n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme (Trouble)" )
      keybind.set( "n", "<leader>st", "<cmd>TodoTelescope<cr>", "Todo" )
      keybind.set( "n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme" )
    end

  },
}
