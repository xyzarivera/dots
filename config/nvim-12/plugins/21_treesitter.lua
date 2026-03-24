vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if
      name == "nvim-treesitter" and (kind == "install" or kind == "update")
    then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

local setup_deferred = _G.xyz.deferred_packadd({
  _G.xyz.gh("nvim-treesitter/nvim-treesitter"),
  _G.xyz.gh("windwp/nvim-ts-autotag"),
})

setup_deferred(function()
-- treesitter  - CST generators
  local ts = require("nvim-treesitter")
  ts.setup()

  local ignored_parsers = {}
  local parsers = {}

  if #ignored_parsers > 0 then
    for _, v in ipairs(ts.get_available()) do
      if not vim.tbl_contains(ignored_parsers, v) then
        table.insert(parsers, v)
      end
    end
  else
    parsers = ts.get_available()
  end

  ts.install(parsers)

  local excluded_fts = { "dockerfile" }

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      if vim.tbl_contains(excluded_fts, args.match) then
        return
      end

      local started = pcall(vim.treesitter.start)

      if started then
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
        vim.wo.foldenable = false

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

-- nvim-ts-autotag
  require("nvim-ts-autotag").setup()
end)
