_G.xyz.keybind_set("", "<leader>ve", ":edit $MYVIMRC<CR>", "Edit Neovim Config")
_G.xyz.keybind_set(
  "",
  "<leader>vs",
  ":source $MYVIMRC<CR>",
  "Reload Neovim Config"
)
-- _G.xyz.keybind_set("n", "q", "<NOP>", "Disable macro recording")

_G.xyz.keybind_set(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  "Better Down",
  { expr = true }
)
_G.xyz.keybind_set(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  "Better Down",
  { expr = true }
)
_G.xyz.keybind_set(
  { "n", "x" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  "Better Up",
  { expr = true }
)
_G.xyz.keybind_set(
  { "n", "x" },
  "<Up>",
  "v:count == 0 ? 'gk' : 'k'",
  "Better Up",
  { expr = true }
)

_G.xyz.keybind_set(
  "n",
  "<C-w><S-j>",
  "<cmd>resize +2<cr>",
  "Increase window height"
)
_G.xyz.keybind_set(
  "n",
  "<C-w><S-k>",
  "<cmd>resize -2<cr>",
  "Decrease window height"
)
_G.xyz.keybind_set(
  "n",
  "<C-w><S-h>",
  "<cmd>vertical resize -2<cr>",
  "Decrease window width"
)
_G.xyz.keybind_set(
  "n",
  "<C-w><S-l>",
  "<cmd>vertical resize +2<cr>",
  "Increase window width"
)

_G.xyz.keybind_set("n", "<C-d>", "<C-d>zz", "Scroll down and center cursor")
_G.xyz.keybind_set("n", "<C-u>", "<C-u>zz", "Scroll up and center cursor")

_G.xyz.keybind_set(
  "n",
  "n",
  "nzzzv",
  "Move to next search result and center cursor"
)
_G.xyz.keybind_set(
  "n",
  "N",
  "Nzzzv",
  "Move to previous search result and center cursor"
)

_G.xyz.keybind_set("n", "<A-j>", "<cmd>m .+1<cr>==", "Move current line down")
_G.xyz.keybind_set("n", "<A-k>", "<cmd>m .-2<cr>==", "Move current line up")
_G.xyz.keybind_set(
  "i",
  "<A-j>",
  "<esc><cmd>m .+1<cr>==gi",
  "Move current line down"
)
_G.xyz.keybind_set(
  "i",
  "<A-k>",
  "<esc><cmd>m .-2<cr>==gi",
  "Move current line up"
)
_G.xyz.keybind_set("v", "<A-j>", ":m '>+1<cr>gv=gv", "Move current line down")
_G.xyz.keybind_set("v", "<A-k>", ":m '<-2<cr>gv=gv", "Move current line up")

_G.xyz.keybind_set("n", "[b", "<cmd>bprevious<cr>", "Prev buffer")
_G.xyz.keybind_set("n", "]b", "<cmd>bnext<cr>", "Next buffer")

_G.xyz.keybind_set(
  { "i", "n" },
  "<esc>",
  "<cmd>noh<cr><esc>",
  "Escape and clear hlsearch"
)

_G.xyz.keybind_set("v", "<", "<gv", "Indent Left")
_G.xyz.keybind_set("v", ">", ">gv", "Indent Right")

_G.xyz.keybind_set("n", "<leader>xl", "<cmd>lopen<cr>", "Location List")
_G.xyz.keybind_set("n", "<leader>xq", "<cmd>copen<cr>", "Quickfix List")

_G.xyz.keybind_set("n", "<leader><tab>l", "<cmd>tablast<cr>", "Last Tab")
_G.xyz.keybind_set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", "First Tab")
_G.xyz.keybind_set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", "New Tab")
_G.xyz.keybind_set("n", "<leader><tab>]", "<cmd>tabnext<cr>", "Next Tab")
_G.xyz.keybind_set("n", "<leader><tab>d", "<cmd>tabclose<cr>", "Close Tab")
_G.xyz.keybind_set(
  "n",
  "<leader><tab>[",
  "<cmd>tabprevious<cr>",
  "Previous Tab"
)

-- terminal
_G.xyz.keybind_set("n", "<C-Space>", ":term<CR>", "Open terminal")
_G.xyz.keybind_set(
  "t",
  "<C-\\><C-\\>",
  "<C-\\><C-n>",
  "Alternative Terminal Exit"
)
