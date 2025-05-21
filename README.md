# neovim

An opinionated AI first nix neovim config.  This should be easy to use, have a vim aesthetic, and be fast.
It should also be a reasonable replacement for a well configured vs code / cursor.

## Usage

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

### Quick try with `nix run`

Run the configuration without adding it to your setup:

```bash
nix run github:anshul/neovim#nvim
```

From a local checkout you can instead execute:

```bash
nix run .#nvim
```

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
- `avante-nvim`
- `ChatGPT-nvim`
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
- `neopyter`
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
- `[b` `]b` — previous/next buffer
- `<C-t>` — new tab
- `<C-n>` — clear search highlight
- `<C-s>` — save file
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
- `<leader>le` `<leader>la` `<leader>lp` `<leader>lf` `<leader>li` `[d` `]d` `<leader>ll` `<leader>lo` `<leader>lI` `<leader>lO` `gd` — diagnostics and navigation
- `<Leader>lr` — incremental rename
- `<Leader>lg` — generate docs
- `<Leader>lh` — show highlight group

### AI/ChatGPT

- `<leader>cg` `<leader>ca` `<leader>ce` `<leader>cr` — ChatGPT actions
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
