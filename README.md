# dots

handle with care

## configured

| tool | description |
|------|-------------|
| 🖥️ **ghostty** | gpu-accelerated terminal with custom shaders |
| 🦎 **alacritty** | backup terminal, tokyonight themed |
| ✏️ **neovim** | the editor. lsp, treesitter, snacks, the works |
| 🐚 **zsh** | syntax highlighting, autosuggestions, and completions |
| ⌨️ **skhd** | macos hotkeys for launching apps |
| 😴 **lazygit** | git tui config |
| 🪟 **tmux** | vim-style navigation, plugins, and session persistence |
| 🤖 **opencode** | LiteLLM providers, MCP servers, agents, and skills |
| 📝 **ideavim** | vim bindings for JetBrains IDEs; manual setup |
| 🌿 **git** | personal/work config templates and a commit-message hook; manual setup |

## vibes

- **theme:** tokyonight (night/moon/storm) 🌙
- **font:** jetbrains mono nerd font
- **philosophy:** minimal, fast, keyboard-driven

## setup

```bash
# run from the repository root on macos, with Homebrew installed
# install packages, apps, and VS Code extensions listed in Brewfile
brew bundle --file=Brewfile

# symlink terminal, editor, and shell configs
./setup.sh

# symlink opencode config, instructions, agents, and skills
mkdir -p ~/.config/opencode
./sync-ai.sh
```

## ai config

Export `LITELLM_API_URL`, `LITELLM_API_KEY`, and `KTL_MCP_URL` before launching OpenCode.
Keep credentials outside the repository, for example in `~/.zshenv.local`; the tracked shell files do not load that file automatically, so source it explicitly if used:

```zsh
source ~/.zshenv.local
```

