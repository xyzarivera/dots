local setup_deferred = _G.xyz.deferred_packadd({
  _G.xyz.gh("lewis6991/gitsigns.nvim"),
  _G.xyz.gh("sindrets/diffview.nvim"),
  _G.xyz.gh("ruifm/gitlinker.nvim"),
})

  setup_deferred(function()
  -- gitsigns
  require("gitsigns").setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      _G.xyz.keybind_set("n", "]h", gs.next_hunk, "Next Hunk")
      _G.xyz.keybind_set("n", "[h", gs.prev_hunk, "Prev Hunk")
      _G.xyz.keybind_set(
        { "n", "v" },
        "<leader>ghs",
        ":Gitsigns stage_hunk<CR>",
        "Stage Hunk"
      )
      _G.xyz.keybind_set(
        { "n", "v" },
        "<leader>ghr",
        ":Gitsigns reset_hunk<CR>",
        "Reset Hunk"
      )
      _G.xyz.keybind_set("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      _G.xyz.keybind_set("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      _G.xyz.keybind_set("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      _G.xyz.keybind_set(
        "n",
        "<leader>ghp",
        gs.preview_hunk_inline,
        "Preview Hunk Inline"
      )
      _G.xyz.keybind_set("n", "<leader>ghb", function()
        gs.blame_line({ full = true })
      end, "Blame Line")
      _G.xyz.keybind_set("n", "<leader>ghd", gs.diffthis, "Diff This")
      _G.xyz.keybind_set("n", "<leader>ghD", function()
        gs.diffthis("~")
      end, "Diff This ~")
      _G.xyz.keybind_set(
        { "o", "x" },
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        "GitSigns Select Hunk"
      )
    end,
  })

  -- diffview
  -- TODO: should keep?
  require("diffview")

  _G.xyz.keybind_set("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", "DiffView")
  _G.xyz.keybind_set("n", "<leader>gdc", "<cmd>DiffviewClose<CR>", "DiffView")


  -- gitlinker - generate shareable file permalinks with line ranges
  require("gitlinker")
end
)
