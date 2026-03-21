-- https://github.com/neovim/neovim/issues/16339
_G.xyz.new_autocmd(
  "BufRead",
  "*",
  function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match("commit") and ft:match("rebase"))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], "nx", false)
        end
      end,
    })
  end,
  "Restore last cursor position"
)

_G.xyz.new_autocmd(
  "BufWritePre",
  { "*.js", "*.cjs", "*.mjs", "*.jsx", "*.ts", "*.tsx", "*.vue", "*.svelte" },
  function()
    if vim.fn.exists(":LspEslintFixAll") ~= 0 then
      vim.cmd("LspEslintFixAll")
    end
  end,
  "Eslint format on save"
)

_G.xyz.new_autocmd(
  "WinResized",
  "*",
  function()
    local scrolloff_percentage = 0.2
    vim.opt.scrolloff = math.floor(vim.o.lines * scrolloff_percentage)
  end,
  "Smart scroll offset"
)

_G.xyz.new_autocmd(
  "TermOpen",
  { "term://*" },
  function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.wrap = true
    vim.wo.spell = false
    vim.cmd("startinsert")
  end,
  "Setup Terminal in buffer"
)
