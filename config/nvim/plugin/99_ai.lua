-- TODO: Custom prompts for skills - https://github.com/avante-corp/avante.nvim#custom-prompts
-- TODO: Add MCPs
-- TODO: Check ACP for kiro-cli

local setup_deferred = _G.xyz.deferred_packadd({
  _G.xyz.gh("sudo-tee/opencode.nvim"),
  _G.xyz.gh("noisesfromspace/touchup.nvim"),
})

setup_deferred(function()
  require("opencode").setup({
    preferred_picker = "snacks.nvim",
    preferred_completion = "blink",
  })

  -- ==================================================================== render-markdown
  require("touchup").setup({
    file_types = { "markdown", "opencode_output" },
  })
end)
