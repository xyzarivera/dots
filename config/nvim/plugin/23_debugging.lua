local open_diagnostic_virtual_line = function()
  vim.diagnostic.config({
    virtual_lines = { current_line = true },
    virtual_text = false,
  })
  _G.xyz.new_autocmd("CursorMoved", "*", function()
    vim.diagnostic.config(_G.xyz.diagnostic_base_options)
  end, "Reset diagnostic config", true)
end

local diagnostic_goto = function(next, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = next and 1 or -1, severity = severity })
    vim.schedule(function()
      open_diagnostic_virtual_line()
    end)
  end
end

_G.xyz.keybind_set(
  "n",
  "<leader>cd",
  open_diagnostic_virtual_line,
  "View Line Diagnostics"
)
_G.xyz.keybind_set("n", "]d", diagnostic_goto(true), "Next Diagnostic")
_G.xyz.keybind_set("n", "[d", diagnostic_goto(false), "Prev Diagnostic")
_G.xyz.keybind_set("n", "]e", diagnostic_goto(true, "ERROR"), "Next Error")
_G.xyz.keybind_set("n", "[e", diagnostic_goto(false, "ERROR"), "Prev Error")
_G.xyz.keybind_set("n", "]w", diagnostic_goto(true, "WARN"), "Next Warning")
_G.xyz.keybind_set("n", "[w", diagnostic_goto(false, "WARN"), "Prev Warning")
local setup_deferred = _G.xyz.deferred_packadd({
  _G.xyz.gh("folke/trouble.nvim"),
  _G.xyz.gh("folke/todo-comments.nvim"),
})

setup_deferred(function()
  -- trouble
  require("trouble").setup({
    focus = true,
    auto_close = true,
    auto_preview = false,
  })

  _G.xyz.keybind_set(
    "n",
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    "Diagnostics (Trouble)"
  )
  _G.xyz.keybind_set(
    "n",
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    "Buffer Diagnostics (Trouble)"
  )
  _G.xyz.keybind_set(
    "n",
    "<leader>xL",
    "<cmd>TroubleToggle loclist<cr>",
    "Location List (Trouble)"
  )
  _G.xyz.keybind_set(
    "n",
    "<leader>xQ",
    "<cmd>Trouble qflist<cr>",
    "Quickfix List (Trouble)"
  )
  -- TODO: fix missing required fields
  _G.xyz.keybind_set("n", "[q", function()
    if require("trouble").is_open() then
      require("trouble").prev({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cprev)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, "Previous trouble/quickfix item")
  _G.xyz.keybind_set("n", "]q", function()
    if require("trouble").is_open() then
      require("trouble").next({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cnext)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, "Next trouble/quickfix item")

  -- todo-comments
  require("todo-comments").setup({
    signs = false,
  })

  _G.xyz.keybind_set("n", "]t", function()
    require("todo-comments").jump_next()
  end, "Next todo comment")
  _G.xyz.keybind_set("n", "[t", function()
    require("todo-comments").jump_prev()
  end, "Previous todo comment")
  _G.xyz.keybind_set(
    "n",
    "<leader>xt",
    "<cmd>TodoTrouble<cr>",
    "Todo (Trouble)"
  )
  _G.xyz.keybind_set(
    "n",
    "<leader>xT",
    "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
    "Todo/Fix/Fixme (Trouble)"
  )
  -- TODO: replacement?
  -- _G.xyz.keybind_set( "n", "<leader>st", "<cmd>TodoTelescope<cr>", "Todo" )
  -- _G.xyz.keybind_set( "n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme" )
end)
