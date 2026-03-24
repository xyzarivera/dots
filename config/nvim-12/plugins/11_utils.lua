local setup_deferred = _G.xyz.deferred_packadd({
  _G.xyz.gh("nvim-mini/mini.surround"),
  _G.xyz.gh("nvim-mini/mini.comment"),
  _G.xyz.gh("nvim-mini/mini.pairs"),
  _G.xyz.gh("bsuth/emacs-bindings.nvim"),
  _G.xyz.gh("keaising/im-select.nvim"),
})

setup_deferred(function ()
-- mini
  require("mini.surround").setup()
  require("mini.comment").setup()
  require("mini.pairs").setup()

-- emacs bindings
  require("emacs-bindings").setup()

-- ime
  require("im-select").setup({
    default_im_select = "com.apple.inputmethod.Kotoeri.RomajiTyping.Roman",
  })
end)
