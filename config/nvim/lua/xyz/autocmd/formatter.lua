vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.cjs", "*.mjs", "*.jsx", "*.ts", "*.tsx", "*.vue", "*.svelte" },
  callback = function()
    if vim.fn.exists(":LspEslintFixAll") ~= 0 then
      vim.cmd("LspEslintFixAll")
    end
  end,
})

