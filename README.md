# neovim

An opinionated AI-first Nix Neovim config designed for use with GitHub Copilot and Claude Code. This should be easy to use, have a vim aesthetic, and be fast.
It should also be a reasonable replacement for a well-configured VS Code / Cursor setup.

## AI Setup (Required)

After installation, you must authenticate with both AI services:

### 1. Windsurf (Autocomplete)

Run this command in Neovim to set up Windsurf autocomplete:

```vim
:Codeium Auth
```

### 2. GitHub Copilot (Chat)

Run this command in Neovim to authenticate with Copilot Chat:

```vim
:Copilot auth
```

**Note**: This configuration uses Windsurf for autocomplete suggestions and GitHub Copilot for AI chat assistance. Both authentications are required for full functionality.

## Quick Try

Run the configuration without adding it to your setup:

```bash
nix run github:anshul/neovim#nvim
```

From a local checkout you can instead execute:

```bash
nix run .#nvim
```

## Installation

### With home-manager

Add this repository as an input to your `flake.nix` and import the provided module:

```nix
# in flake.nix
inputs.neovim.url = "github:anshul/neovim";

outputs = { self, nixpkgs, neovim, ... }:
{
  homeManagerModules = [ neovim.homeModules.default ];
}
```

```nix
{
  imports = [
    inputs.neovim.homeModules.default
  ];

  nvim.enable = true;
}
```

## Obsidian Integration

This configuration includes Obsidian.nvim for note-taking with the following features:

- **Auto-creates** `~/Documents/Obsidian` directory on first use
- **Wiki-style links** and note templates
- **Daily notes** with automatic date formatting
- **Quick navigation** between notes with fuzzy finding
- **Backlinks** and link management
- **Image attachments** support

The Obsidian vault will be automatically created at `~/Documents/Obsidian` when you first use any Obsidian command.

## Plugins

### Startup Plugins

- `lze`
- `lzextras`
- `nui-nvim`
- `better-escape-nvim`
- `catppuccin-nvim`
- `rose-pine`
- `nvim-lspconfig`
- `nvim-treesitter.withAllGrammars`
- `nvim-treesitter-textobjects`
- `nvim-treesitter-context`
- `nvim-highlight-colors`
- `nvim-lint`
- `nvim-web-devicons`
- `tabby-nvim`
- `rainbow-delimiters-nvim`
- `vim-sleuth`
- `vim-matchup`
- `incline-nvim`
- `slimline-nvim`

### Optional/Lazy Plugins

- `plenary-nvim`
- `blink-cmp`
- `blink-compat`
- `friendly-snippets`
- `lazydev-nvim`
- `lspsaga-nvim`
- `vim-illuminate`
- `promise-async`
- `nvim-ufo`
- `conform-nvim`
- `snacks-nvim`
- `nvim-notify`
- `noice-nvim`
- `inc-rename-nvim`
- `indent-blankline-nvim`
- `which-key-nvim`
- `gitsigns-nvim`
- `diffview-nvim`
- `neogit`
- `octo-nvim`
- `grapple-nvim`
- `oil-nvim`
- `comment-nvim`
- `nvim-ts-context-commentstring`
- `mini-indentscope`
- `mini-ai`
- `mini-animate`
- `mini-basics`
- `mini-files`
- `mini-icons`
- `mini-move`
- `mini-operators`
- `mini-surround`
- `treesj`
- `nvim-autopairs`
- `iron-nvim`
- `copilot-lua`
- `neogen`
- `claude.vim`
- `copilot-chat-nvim`
- `wtf-nvim`
- `nvim-dap`
- `nvim-dap-ui`
- `nvim-dap-python`
- `nvim-dap-virtual-text`
- `obsidian-nvim`
- `render-markdown-nvim`
- `ssr-nvim`
- `grug-far-nvim`
- `img-clip-nvim`
- `vim-repeat`
- `lspkind-nvim`
- `outline-nvim`
- `vim-tmux-navigator`
- `trouble-nvim`
- `todo-comments-nvim`
- `refactoring-nvim`
- `nvim-bqf`
- `marks-nvim`
- `markdown-preview-nvim`
- `cloak-nvim`
- `git-conflict-nvim`
- `nvim-ts-autotag`
- `flash-nvim`
- `tiny-inline-diagnostic-nvim`
- `zen-mode-nvim`
- `twilight-nvim`
- `smear-cursor-nvim`
- `possession-nvim`
- `websocket-nvim`
- `colorful-winsep-nvim`
- `reactive-nvim`
- `symbol-usage-nvim`
- `early-retirement-nvim`
- `timber-nvim`
- `maximize-nvim`

## Keyboard Shortcuts

### General

- `<Leader>wv` / `<Leader>ws` — vertical/horizontal split
- `<C-h>` `<C-j>` `<C-k>` `<C-l>` — window navigation
- `<Leader>uw` `<Leader>us` — toggle wrap and spell
- `[t` `]t` — previous/next tab
- `<C-Up>` `<C-Down>` `<C-Left>` `<C-Right>` — resize windows
- `<Leader>w=` — equalize window sizes
- `[b` `]b` or `<A-Left>` `<A-Right>` or `<Cmd-Left>` `<Cmd-Right>` — previous/next buffer
- `<C-t>` — new tab
- `<C-n>` — open notes
- `<C-o>` — file finder
- `<C-p>` — git finder
- `<C-b>` — buffer finder
- `<C-d>` or `<Cmd-d>` — close buffer
- `<C-x>` — diagnostics list
- `<C-g>` — toggle Copilot Chat
- `<C-s>` — save file
- `<Tab>` — accept AI suggestion (Copilot)
- `<Leader>qb` `<Leader>qB` `<Leader>qw` `<Leader>qt` `<Leader>qa` — close buffers/windows/tabs
- `<` / `>` in visual mode — keep selection while indenting
- `Q` — run macro in register `q`

### Snacks Pickers

- `<leader>ff` / `<leader>fg` / `<leader>fb` / `<leader>fp` / `<leader>fj` / `<leader>fm` — find files, git files, buffers, projects, jumps, marks
- `<leader>sg` / `<leader>sf` / `<leader>sb` / `<leader>st` — text search
- `<leader>tc` / `<leader>tr` / `<leader>tu` / `<leader>th` / `<leader>tH` / `<leader>ti` / `<leader>tk` / `<leader>ty` — misc pickers
- `<leader>ld` / `<leader>ls` — diagnostics and symbols
- `<leader>rr` — rename file
- `<leader>ns` — toggle scratch buffer
- `<leader>T` — toggle terminal

### LSP & Tools

- `gD` `gt` `gi` — LSP declaration/type/implementation
- `<leader>le` `<leader>la` `<leader>lp` `<leader>lf` `<leader>li` `[d` `]d` `<leader>ll` `<leader>lo` `<leader>lI` `<leader>lO` `gd` — diagnostics and
  navigation
- `<Leader>lr` — incremental rename
- `<Leader>lg` — generate docs
- `<Leader>lh` — show highlight group

### AI/Claude/Copilot

**Claude.vim**:

- `<leader>cc` — Claude chat interface
- `<leader>ca` — Claude ask (selection/prompt)
- `<leader>ci` — Claude implement (selection/prompt)
- `<leader>cr` — Claude review (selection/prompt)
- `<leader>cg` — Claude generate (selection/prompt)

**Copilot Chat**:

- `<leader>ce` — Copilot explain (selection/prompt)
- `<leader>cr` — Copilot review (selection/prompt)
- `<leader>cf` — Copilot fix (selection/prompt)
- `<leader>co` — Copilot optimize (selection/prompt)
- `<leader>cd` — Copilot docs (selection/prompt)
- `<leader>ct` — Copilot tests (selection/prompt)
- `<leader>cm` — Copilot commit message

**Other AI Tools**:

- `<leader>cd` `<leader>cs` — debug/search diagnostics with AI (wtf.nvim)

### Debugging (DAP)

- `<leader>db` `<leader>dc` `<leader>do` — toggle breakpoint, continue, toggle UI

### Session Management

- `<leader>pl` `<leader>ps` `<leader>pr` `<leader>pq` `<leader>pd` `<leader>pp` — Possession session commands

### File Explorer & Files

- `-` — open Oil file explorer
- `<leader>/` — open mini.files for current file
- Inside mini.files: `g.` toggle dotfiles, `<C-x>` split, `<C-v>` vsplit, `<C-t>` tab split

### Git

- `]h` `[h` — next/previous hunk
- `<leader>hp` `<leader>hP` `<leader>hs` `<leader>hu` `<leader>hr` — hunk actions
- `<leader>ga` `<leader>gr` — stage/reset buffer
- `<leader>gg` `<leader>gc` — Neogit
- `<leader>gd` — open Diffview
- `<leader>gl` — LazyGit
- `<leader>go` — open in browser

### Grapple Marks

- `<leader>mm` `<leader>md` `<leader>ml` — tag, remove, list grapple marks
- `[g` `]g` — cycle marks
- `<leader>m1`..`<leader>m4` — select tagged file

### Indentation & Folding

- `<leader>ii` — toggle indent guides
- `zR` `zM` `zK` — open/close folds via ufo.nvim
- `z1` `z2` `z3` `z4` `z5` — close folds at specific levels (1-5)
- `zz` — toggle fold under cursor

### Writing & Notes

- `<leader>nn` `<leader>nf` `<leader>nd` `<leader>nt` `<leader>nk` `<leader>nb` `<leader>nl` `<leader>nr` `<leader>no` — Obsidian note management
- `<leader>ir` `<leader>ih` — Iron REPL open/hide
- `<space>ix` `<space>if` `<space>il` `<space>i<CR>` `<space>i<space>` `<space>iq` `<space>ic` `<space>iR` — send code to REPL

### Miscellaneous

- `gs` — toggle Treesj
- `<leader>P` — paste clipboard image (img-clip)
- `go` — toggle outline
- `<leader>xx` `<leader>xX` `<leader>xl` `<leader>xL` `<leader>xs` `<leader>xq` `<leader>xt` `<leader>xT` — Trouble views
- `<leader>xm` `<leader>xM` — marks list
- `<leader>wm` — maximize window
- `gll` `gls` — insert log statements (timber)
- `<leader>zz` `<leader>zt` — Zen mode and Twilight
- `S` `r` `<leader><leader>` — Flash motions
- `<leader>sr` `<leader>sR` — search and replace (GrugFar/SSR)
