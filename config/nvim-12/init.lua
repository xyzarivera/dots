-- create local namespace to not pollute global
local xyz = {}

-- define custom functions
-- autocmd group
local autocmd_group = vim.api.nvim_create_augroup("xyz", {clear = true})
xyz.new_autocmd = function(event, pattern, callback, desc, once)
  vim.api.nvim_create_autocmd(event, {
    group = autocmd_group,
    pattern = pattern,
    callback = callback,
    desc = desc,
    once = once or false,
  })
end

-- keybind set
xyz.keybind_set = function(mode, keybind, cmd, desc, opts)
  vim.keymap.set(
    mode,
    keybind,
    cmd,
    vim.tbl_deep_extend("force", {
        desc = desc,
        noremap = true,
        silent = true,
      },
      opts or {}
    )
  )
end

-- deferred vim.pack.add
xyz.deferred_packadd = function(specs,opts)
  local deffered_spec_names = {}

  vim.pack.add(
    specs,
  vim.tbl_deep_extend("force", {
      load = function(plug_data)
        table.insert(deffered_spec_names, plug_data.spec.name)
      end,
    }, opts or {})
  )

  return function(setup)
    vim.schedule(function()
      for _, deffered_spec_name in ipairs(deffered_spec_names) do
        vim.cmd.packadd(deffered_spec_name)
      end

      setup()
    end)
  end
end

-- prepend github link prefix
xyz.gh = function(package)
  return "https://github.com/" .. package
end

-- add local namespace to global namespace
_G.xyz = xyz
