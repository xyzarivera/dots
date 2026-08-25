-- TODO: Custom prompts for skills - https://github.com/avante-corp/avante.nvim#custom-prompts
-- TODO: Add MCPs
-- TODO: Check ACP for kiro-cli

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "avante.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    end
  end,
})

local setup_deferred = _G.xyz.deferred_packadd({
  {
    src = _G.xyz.gh("yetone/avante.nvim"),
    version = "main",
  },

  _G.xyz.gh("MunifTanjim/nui.nvim"),
  _G.xyz.gh("noisesfromspace/touchup.nvim"),
})

setup_deferred(function()
---@diagnostic disable-next-line: missing-fields
  require("avante").setup({
    mode = 'legacy', -- https://github.com/avante-corp/avante.nvim#how-to-disable-agentic-mode
    provider = "litellm",
    providers = {
      litellm = {
        __inherited_from = "openai",
        endpoint = "LITELLM_API_URL",
        model = "claude-low-carbon-apac-sonnet",
        api_key_name = "LITELLM_API_KEY",
      },
    },
    behaviour = {
      enable_fastapply = false, -- https://github.com/avante-corp/avante.nvim#fast-apply
      auto_suggestions = false,
      auto_add_current_file = false,
    },
    windows = {
      sidebar_header = {
        align = "left",
        include_model = true,
        rounded = false,
      },
    },
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
  })

  -- ==================================================================== render-markdown
  require("touchup").setup({
    file_types = { "markdown", "Avante" },
  })
end)

