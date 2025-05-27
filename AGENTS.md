# Contributors Guide

## Instructions

- This repository is a Neovim configuration built with **Nix** and **Lua**.
- Always update `AGENTS.md` after major structural changes (creating / deleting files, repurposing directories, files).
- Always update `README.md` when keyboard shortcuts change, and verify all information is accurate.
- Always run `just fix` after making changes to ensure code formatting and linting standards are met.
- The `nix develop` shell provides `just`, `alejandra`, `markdownlint`, `prettier`, `ruff`, `stylua`, `shellcheck` for linting / formatting, and `busted` with
  `luajit` for testing.

## Coding Conventions

- Use **2‑space indentation** for every language.
- Keep code comments concise and relevant.
- Enter the dev environment with `nix develop` before running any tooling.
- Don't say co-authored by claude in commit messages

## Project Overview (ordered by day‑to‑day importance)

### `./`

- `flake.nix` – repository flake: declares Nix inputs, exports packages/devShells/overlays, and wires NixOS + Home Manager modules.
- `categories.nix` – plugin & dependency catalogue used by nixCats: env vars, runtime deps, startup & optional plugin sets.
- `packages.nix` – defines the `nvim` package (settings, categories, extra overrides) that nixCats builds.
- `justfile` – handy Just tasks (run, update, lint, fix, test, etc.).
- `CLAUDE.md` – project instructions and coding conventions for AI assistants.
- Other root helpers – `.gitignore`, `.editorconfig`, `LICENSE`, etc., handle repo housekeeping.

### `./lua/nvim`

- `init.lua` – root loader: pulls in options, themes, LSP, completions, treesitter, plugins, UI, bars, git, AI, literate, misc, debug; registers `lze` LSP
  handlers.
- `options.lua` – baseline UX settings (clipboard, termguicolors, search behaviour, splits, soft‑tabs, folds, listchars, font…).
- `autocmds.lua` – quality‑of‑life autocommands (trim `cro`; quick‑close transient buffers; auto‑size splits; disable _mini‑indentscope_ in helper buffers;
  force opaque floating windows).
- `treesitter.lua` – lazy‑loads `nvim‑treesitter`, textobjects, context, autotag; provides richer motions (`af/if`, `[f` `]f`), `<C‑Space>` incremental
  selection, context window, HTML/TSX autotag.

### `./lua/nvim/keymaps`

- `init.lua` – loads the four keymap modules.
- `keymaps.lua` – core navigation & utility maps (window jumps/resizes, tab & buffer cycling, Snacks finders, Avante toggle, quick save/close…).
- `keymaps-plugins.lua` – plugin‑centric shortcuts: LSP (jumps, actions, rename, diagnostics), DAP, ChatGPT, Possession.
- `keymaps-snacks.lua` – Snacks picker shortcuts (files, grep, git, misc, LSP).
- `whichkey.lua` – lazy‑loads _which‑key_ (`<Leader>?`) and defines group labels.

### `./lua/nvim/lsps`

- `init.lua` – wires LSP stack.
- `lsp.lua` – extends `lspconfig` with cmp capabilities, buffer‑local `:Format`, **inc‑rename** integration, iterates over `servers.lua`.
- `servers.lua` – declarative configs for \~25 language servers (Lua, Python, Nix, Go, TS, Rust, etc.).
- `diagnostic-signs.lua` – disables virtual text; custom gutter icons.
- `formatters.lua` – **conform.nvim** auto‑format on save; per‑ft formatter map; `<Leader>lF` manual format.
- `linters.lua` – **lint.nvim** on save; per‑ft linters.
- `lspsaga.lua` – enhanced UI (finder, outline float, beacon, lightbulb, _vim‑illuminate_).
- `symbol-usage.lua` – inline usage / impl counts; toggles `<Leader>lu` / `<Leader>lU`.

### `./lua/nvim/completions`

- `blink-cmp.lua` – primary completion engine (keymaps, sources, signature pop‑ups).
- `copilot.lua` – Copilot inline suggestions (model `gpt‑4o‑copilot`).
- `neogen.lua` – docstring generator (NumpyDoc / TSDoc).
- `init.lua` – simply requires the above three.

### `./lua/nvim/ai`

- `init.lua` – loads AI helpers.
- `avante.lua` – **avante.nvim** with Copilot backend (`o4-mini`), planning & hints on, autosuggest off.
- `wtf.lua` – **wtf.nvim** diagnostic explain / fix (`<Leader>cd/‌cs`).
- `chatgpt.lua` – **ChatGPT.nvim** wrapper (model `gpt‑4.1‑mini`).

### `./lua/nvim/bars`

- `init.lua` – enables `slimline`, `tabby`, `incline`.
- `lualine.lua` – primary statusline (catppuccin, `grapple`, `noice`, LSP clients, git diff, progress bar).
- `tabby.lua` – tabline (session name, diagnostics icons, window counts).
- `incline.lua` – per‑window title bar (devicon, git diff/diagnostics, grapple).
- `slimline.lua` – minimal alt statusline with custom highlights.

### `./lua/nvim/plugins`

- `init.lua` – general utilities: editing (**better‑escape**, **autopairs**, **treesj**, **img‑clip**), navigation (**outline**, **vim‑tmux‑navigator**,
  **maximize**), workflow (**trouble**, **todo‑comments**, **refactoring**, **bqf**, **marks**), writing (**markdown‑preview**, **cloak**), git conflict helper,
  misc (**early‑retirement**, **timber**).

### `./lua/nvim/git`

- `gitsigns.lua` – hunk signs / operations.
- `diffview.lua` – side‑by‑side diff (`<Leader>gd`).
- `neogit.lua` – floating Git UI (`<Leader>g[g/c]`).
- `octo.lua` – GitHub PR / issue interface.
- `init.lua` – loads the above.

### `./lua/nvim/debug`

- `init.lua` – **nvim‑dap** stack: auto‑open UI, virtual text, breakpoint signs, Python adapter.

### `./lua/nvim/literate`

- `init.lua` – loads Neopyter & Iron.
- `neopyter.lua` – direct Jupyter client, cell run maps, `:NewNotebook`.
- `iron.lua` – REPL manager, ipython & zsh presets, `<space>i*` keymaps.

### `./lua/nvim/ui`

- `init.lua` – central loader: pulls in visual helpers (Snacks, Tiny‑diagnostics, Mini‑indent, Indent‑blankline, Highlight‑colors, Notifications/Noice, Oil,
  Grapple, Reactive highlights, Folding/UFO, Colorful‑winsep, Zen‑mode/Twilight, Smear‑cursor).
- `colorful-winsep.lua` – draws colourful window separators with Unicode box‑drawing characters.
- `folding.lua` – configures **nvim‑ufo** advanced folds, custom virtual text handler, and `zR`/`zM`/`zK` keymaps.
- `grapple.lua` – sets up **grapple.nvim** bookmarks; `<leader>m…` keys to tag/jump, `[g` `\]g` cycle.
- `highlight-colors.lua` – shows CSS/Tailwind colours inline via **nvim‑highlight‑colors** virtual text.
- `indent.lua` – lazy‑loads **indent‑blankline.nvim**, adds `<leader>ii` toggle; smart indent cap and filetype excludes.
- `mini-indent.lua` – enables **mini.indentscope** border guides except for helper buffers.
- `notifications.lua` – initialises **nvim‑notify** and **noice.nvim** for rich messages, suppressing noisy deprecations.
- `oil.lua` – floats **oil.nvim** file manager with `-` key; trash‑aware delete and split/vsplit mappings.
- `reactive.lua` – dynamic cursor/cursorline colours with **reactive‑nvim** using Catppuccin palette.
- `smear.lua` – trailing cursor smear effect via **smear‑cursor.nvim**.
- `snacks.lua` – core **snacks.nvim** config (dashboard, pickers, git, lazygit, layouts, notifications, images, etc.).
- `snacks-dashboard.lua` – ASCII dashboard preset: quick git/files/todo/AI/session actions and sections.
- `snacks-rename.lua` – hooks Snacks rename helper into MiniFiles/Oil rename autocommands.
- `tiny-diagnostics.lua` – inline diagnostic messages from **tiny‑inline‑diagnostic.nvim**.
- `zen.lua` – distraction‑free **zen‑mode.nvim** plus Twilight toggles (`<leader>zz`/`<leader>zt`).

### `./lua/nvim/themes`

- `init.lua` – chooses and applies theme modules (Catppuccin by default).
- `catppuccin.lua` – Catppuccin‑Mocha theme with extensive highlight tweaks and plugin integrations.
- `rose-pine.lua` – optional Rose‑Pine palette with custom highlight groups for Telescope, Treesitter, etc.

### `./lua/nvim/misc`

- `init.lua` – orchestrates the Misc stack (Mini helpers, sessions, comments, Flash navigation, Obsidian integration, Markdown rendering, search & replace).
- `mini.lua` – bundles **mini.nvim** modules: AI text‑objects, animate (open/close only), basic options, glyph icons, move lines/blocks, operators
  (exchange/sort), surround.
- `mini-files.lua` – floating file explorer (`<leader>/`) with dot‑file toggle (`g.`) and split

### other config files

- `.editorconfig` – editor settings (indent, charset, end‑of‑line).
- `.envrc` – direnv script to watch flake files and enter dev shell.
- `.luacheckrc` – Luacheck globals & style rules.
- `.markdownlint.yaml` – Markdownlint config (160‑char lines limit).
- `.pre-commit-config.yaml` – auto‑generated hooks (alejandra, ruff, shellcheck, stylua, markdownlint).
- `.stylua.toml` – Stylua formatting rules for Lua code.
- `stylua.toml` – fallback Stylua config for CI.
- `.busted` – Busted test framework configuration (LuaJIT runtime, test pattern).
- `justfile` – handy Just tasks (run, update, lint, fix, test, etc.).

## Keyboard mappings

- `./lua/nvim/keymaps/keymaps.lua` – core leader, window, buffer, search & Avante mappings.
- `./lua/nvim/keymaps/keymaps-plugins.lua` – plugin actions: LSP, ChatGPT, DAP, Possession, etc.
- `./lua/nvim/keymaps/keymaps-snacks.lua` – Snacks pickers and git/search utilities.
- `./lua/nvim/misc/obsidian.lua` – Obsidian note‑taking shortcuts (`<leader>n…`).
- `./lua/nvim/misc/mini-files.lua` – mini.files explorer (`g.`, `⌃x/⌃v/⌃t`, sync).
- `./lua/nvim/misc/search-replace.lua` – search & replace commands (`<leader>sr`, `<leader>sR`).
- `./lua/nvim/literate/neopyter.lua` – Jupyter cell/run controls (`<leader>j*`).
- `./lua/nvim/ui/folding.lua` – fold control keys (`zR`, `zM`, `zK`).
- `./lua/nvim/ui/grapple.lua` – bookmark tag & jump keys (`<leader>m…`, `[g`, `]g`).
- `./lua/nvim/ui/indent.lua` – toggle indent guides (`<leader>ii`).
- `./lua/nvim/ui/zen.lua` – zen & twilight toggles (`<leader>zz`, `<leader>zt`).
- `./lua/nvim/ui/oil.lua` – `-` to open Oil file explorer.

### `./tests`

- `example_spec.lua` – example test file demonstrating TDD setup with busted framework.

### `./after/plugin`

- `colors.lua` – post-plugin color overrides and theme customizations.

### `./overlays`

- `default.nix` – Nix overlays for custom package modifications.

### `./run`

- `setup-ci` – CI setup script.
- `test-ci` – CI test execution script.
