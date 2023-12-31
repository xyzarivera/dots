-- SETTINGS

-- CORE
vim.g.mapleader = " "
vim.api.nvim_create_augroup("xyz", {})
vim.opt.exrc = false 

-- SEARCH/AUTOCOMPLETE
vim.opt.completeopt = "menu,preview,longest"
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- SPACES/WRAPPING
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.shiftround = true

-- INTERFACE
vim.opt.laststatus = 3
vim.opt.listchars:append({
  lead = "·",
  trail = "·",
  nbsp = "·",
})
vim.opt.list = true
vim.opt.fillchars = "eob: "
vim.opt.matchpairs = "(:),{:},[:],<:>"
vim.opt.matchtime = 2
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.vb = false
vim.opt.colorcolumn = "80"
vim.opt.termguicolors = true

-- PERFORMANCE
vim.g.matchparen_timeout = 10
vim.opt.scrollback = 100000
vim.opt.synmaxcol = 300
vim.opt.updatetime = 50
vim.opt.lazyredraw = true

-- CLIPBOARD
vim.opt.clipboard = "unnamedplus"

-- FILES
vim.opt.hidden = true
vim.opt.autochdir = false
vim.opt.confirm = true
vim.opt.autowrite = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo/"
vim.opt.undofile = true
vim.opt.undolevels = 500
vim.opt.undoreload = 10000
vim.opt.swapfile = false
vim.opt.updatecount = 50

-- MISC
vim.opt.commentstring = "// %s"
vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- KEYBINDS

vim.keymap.set(
  "",
  "<leader>ve",
  ":edit $MYVIMRC<cr>",
  { desc = "Edit Neonvim Config" }
)
vim.keymap.set(
  "",
  "<leader>vs",
  ":source $MYVIMRC<cr>",
  { desc = "Reload Neonvim Config" }
)
vim.keymap.set(
  "n",
  "<leader>w",
  ":w!<cr>",
  { desc = "Quick Save" }
)
vim.keymap.set("", "<C-j>", "<C-W>j", { desc = "Switch to Bottom Window" })
vim.keymap.set("", "<C-k>", "<C-W>k", { desc = "Switch to Top Window" })
vim.keymap.set("", "<C-h>", "<C-W>h", { desc = "Switch to Left Window" })
vim.keymap.set("", "<C-l>", "<C-W>l", { desc = "Switch to Right Window" })

vim.keymap.set(
  "n",
  "<leader><Tab>",
  ":bnext<cr>",
  { desc = "Switch to Next Buffer" }
)
vim.keymap.set(
  "n",
  "<leader><S-Tab>",
  ":bprevious<cr>",
  { desc = "Switch to Previous Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>q",
  ":close<CR>",
  { desc = "Close Current Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>Q",
  ":bdelete<CR>",
  { desc = "Delete Current Buffer" }
)
vim.keymap.set(
  "n",
  "<leader><leader>q",
  ":bdelete!<CR>",
  { desc = "Force Close Current Buffer" }
)
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Inverse Indention" })

vim.keymap.set("n", "<leader>/", ":nohl<CR>", { desc = "Dehighlight Results" })

vim.keymap.set(
  "c",
  "W",
  "w",
  { desc = "Alternative `save` because I always fat finger :W" }
)

vim.keymap.set("n", "[[", "<C-o>", { desc = "Goto Previous Cursor Position" })
vim.keymap.set("n", "]]", "<C-i>", { desc = "Goto Next Cursor Position" })

vim.keymap.set(
  "n",
  "<C-d>",
  "<C-d>zz",
  { desc = "Scroll down and center cursor" }
)
vim.keymap.set(
  "n",
  "<C-u>",
  "<C-u>zz",
  { desc = "Scroll up and center cursor" }
)

vim.keymap.set(
  "n",
  "n",
  "nzzzv",
  { desc = "Move to next search result and center cursor" }
)
vim.keymap.set(
  "n",
  "N",
  "Nzzzv",
  { desc = "Move to next search result and center cursor" }
)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines down" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable macro recording" })

-- Plugins

if not package.loaded.lazy then
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    spec = {
      { import = "xyz.plugins" },
    },
    install = {
      missing = true,
      colorscheme = { "tokyonight" },
    },
  })
end
