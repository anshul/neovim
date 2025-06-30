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

## Commit Standards

Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```text
<type>: <description>

[optional body]
[optional footer]
```

### Types

- `feat:` - New feature or enhancement
- `fix:` - Bug fix
- `perf:` - Performance improvement
- `refactor:` - Code restructuring without behavior change
- `style:` - Code style/formatting changes
- `docs:` - Documentation updates
- `test:` - Add or update tests
- `build:` - Build system or dependency changes
- `ci:` - CI/CD configuration changes
- `chore:` - Maintenance tasks

### Examples

```bash
feat: add floating terminal integration for enhanced workflow
fix: correct t_ut terminal option syntax for modern Neovim
perf: optimize LSP startup time with lazy loading
refactor: consolidate keybinding modules for better organization
docs: update README with new keyboard shortcuts
test: add comprehensive Elixir language support tests
build: update nixCats to latest version
```

## Development Environment

### Setup

```bash
# Automatic with direnv
direnv allow

# Manual activation
nix develop
```

### Available Tools

- **Nix** - Reproducible development environment
- **Just** - Command runner for common tasks
- **Lua Tools** - stylua (formatting), luacheck (linting), busted (testing)
- **Formatters** - alejandra (Nix), prettier (Markdown), ruff (Python)
- **Quality Tools** - markdownlint, shellcheck

## Development Workflow

### Common Commands

```bash
# Setup and run
just run                 # Build and run Neovim
just update             # Update flake inputs

# Code quality
just fix                # Format and lint all code
just lint               # Run all linters
just format             # Format all code

# Testing
just test               # Run all tests with busted
just test-watch         # Watch for changes and run tests

# Development
nix develop             # Enter development shell
just --list             # Show all available commands
```

### File Watching

```bash
# Watch Lua files for changes
find lua -name "*.lua" | entr -c just test

# Auto-format on save (with your editor)
# Most editors support format-on-save with stylua
```

## Project Overview (ordered by day‑to‑day importance)

### Project Structure

```text
neovim/
├── lua/nvim/           # Core Neovim configuration
│   ├── init.lua        # Root loader and LSP handlers
│   ├── options.lua     # Baseline UX settings
│   ├── autocmds.lua    # Quality-of-life autocommands
│   ├── treesitter.lua  # Syntax highlighting and motions
│   ├── keymaps/        # Keyboard mapping modules
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   ├── keymaps-plugins.lua
│   │   ├── keymaps-snacks.lua
│   │   └── whichkey.lua
│   ├── lsps/           # Language Server Protocol
│   │   ├── init.lua
│   │   ├── lsp.lua
│   │   ├── servers.lua
│   │   ├── formatters.lua
│   │   ├── linters.lua
│   │   └── ...
│   ├── completions/    # Code completion
│   ├── ai/             # AI integrations
│   ├── bars/           # Status and tab bars
│   ├── plugins/        # General utilities
│   ├── git/            # Git integrations
│   ├── debug/          # Debug Adapter Protocol
│   ├── literate/       # REPL integrations
│   ├── ui/             # Visual enhancements
│   ├── themes/         # Color schemes
│   ├── misc/           # Everything else
│   └── lang/           # Language-specific configs
├── tests/              # Test suite
├── after/plugin/       # Post-plugin customizations
├── overlays/           # Nix package overlays
├── run/                # CI scripts
├── flake.nix           # Nix flake definition
├── categories.nix      # nixCats plugin catalog
├── packages.nix        # Package definitions
└── justfile            # Command runner tasks
```

### `./`

- `flake.nix` – repository flake: declares Nix inputs, exports packages/devShells/overlays, and wires NixOS + Home Manager modules.
- `categories.nix` – plugin & dependency catalogue used by nixCats: env vars, runtime deps, startup & optional plugin sets.
- `packages.nix` – defines the `nvim` package (settings, categories, extra overrides) that nixCats builds.
- `justfile` – handy Just tasks (run, update, lint, fix, test, etc.).
- `CLAUDE.md` – project instructions and coding conventions for AI assistants.
- Other root helpers – `.gitignore`, `.editorconfig`, `LICENSE`, etc., handle repo housekeeping.

### `./lua/nvim`

- `init.lua` – root loader: pulls in options, themes, LSP, completions, treesitter, plugins, UI, bars, git, AI, literate, misc, debug, lang modules; registers
  `lze` LSP handlers.
- `options.lua` – baseline UX settings (clipboard, termguicolors, search behaviour, splits, soft‑tabs, folds, listchars, font, terminal integration…).
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
- `servers.lua` – declarative configs for \~26 language servers (Lua, Python, Nix, Go, TS, Rust, Elixir, etc.).
- `diagnostic-signs.lua` – disables virtual text; custom gutter icons.
- `formatters.lua` – **conform.nvim** auto‑format on save; per‑ft formatter map; `<Leader>lF` manual format.
- `linters.lua` – **lint.nvim** on save; per‑ft linters.
- `lspsaga.lua` – enhanced UI (finder, outline float, beacon, lightbulb, _vim‑illuminate_).
- `symbol-usage.lua` – inline usage / impl counts; toggles `<Leader>lu` / `<Leader>lU`.

### `./lua/nvim/completions`

- `blink-cmp.lua` – primary completion engine (keymaps, sources, signature pop‑ups).
- `copilot.lua` – Copilot inline suggestions (model `gpt‑4.1`).
- `neogen.lua` – docstring generator (NumpyDoc / TSDoc).
- `init.lua` – simply requires the above three.

### `./lua/nvim/ai`

- `init.lua` – loads AI helpers.
- `avante.lua` – **avante.nvim** with Copilot backend (`gpt-4.1`), planning & hints on, autosuggest off.
- `wtf.lua` – **wtf.nvim** diagnostic explain / fix (`<Leader>cd/‌cs`).
- `chatgpt.lua` – **ChatGPT.nvim** wrapper (model `gpt‑4.1`).

### `./lua/nvim/bars`

- `init.lua` – enables `slimline`, `tabby`, `incline`.
- `lualine.lua` – primary statusline (catppuccin, `grapple`, `noice`, LSP clients, git diff, progress bar).
- `tabby.lua` – tabline (session name, diagnostics icons, window counts).
- `incline.lua` – per‑window title bar (devicon, git diff/diagnostics, grapple).
- `slimline.lua` – minimal alt statusline with custom highlights.

### `./lua/nvim/plugins`

- `init.lua` – general utilities: editing (**better‑escape**, **autopairs**, **treesj**, **img‑clip**), navigation (**outline**, **vim‑tmux‑navigator**,
  **maximize**), workflow (**trouble**, **todo‑comments**, **refactoring**, **bqf**, **marks**), writing (**markdown‑preview**, **cloak**), git conflict helper,
  misc (**early‑retirement**, **timber**), terminal integration (**terminal‑scrollback**).

### `./lua/nvim/git`

- `gitsigns.lua` – hunk signs / operations.
- `diffview.lua` – side‑by‑side diff (`<Leader>gd`).
- `neogit.lua` – floating Git UI (`<Leader>g[g/c]`).
- `octo.lua` – GitHub PR / issue interface.
- `init.lua` – loads the above.

### `./lua/nvim/debug`

- `init.lua` – **nvim‑dap** stack: auto‑open UI, virtual text, breakpoint signs, Python adapter.

### `./lua/nvim/literate`

- `init.lua` – loads Iron.
- `iron.lua` – REPL manager, ipython, zsh & iex presets, `<space>i*` keymaps.

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
- `mini-files.lua` – floating file explorer (`<leader>/`) with dot‑file toggle (`g.`) and split mappings.
- `obsidian.lua` – Obsidian note-taking integration with `<leader>n…` keymaps.
- `search-replace.lua` – search & replace commands (`<leader>sr`, `<leader>sR`).
- `flash.lua` – enhanced navigation with Flash motions.
- `comment.lua` – smart commenting with mini.comment.
- `markdown.lua` – Markdown rendering and editing support.
- `sessions.lua` – session management with Possession.nvim.

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
- `./lua/nvim/ui/folding.lua` – fold control keys (`zR`, `zM`, `zK`, `z1`-`z5`, `zz`).
- `./lua/nvim/ui/grapple.lua` – bookmark tag & jump keys (`<leader>m…`, `[g`, `]g`).
- `./lua/nvim/ui/indent.lua` – toggle indent guides (`<leader>ii`).
- `./lua/nvim/ui/zen.lua` – zen & twilight toggles (`<leader>zz`, `<leader>zt`).
- `./lua/nvim/ui/oil.lua` – `-` to open Oil file explorer.

### `./lua/nvim/lang`

- `elixir.lua` – Elixir language support: elixir-tools.nvim with Lexical LSP, neotest-elixir, vim-endwise.

## Architecture Decisions

### Core Design Principles

- **Nix-First**: Reproducible environments over traditional package managers
- **Modular Structure**: Each feature in its own module for maintainability
- **Performance**: Lazy loading and efficient startup time prioritized
- **Extensibility**: Easy to add new languages and plugins

### Key Technology Choices

#### **nixCats over other Neovim distributions**

- Reproducible builds across different systems
- Declarative plugin management with Nix
- Integration with NixOS and Home Manager
- Better dependency management than traditional Lua configs

#### **blink.cmp over nvim-cmp**

- Faster completion performance
- Better integration with modern LSP features
- Less configuration overhead
- More responsive UI

#### **Snacks.nvim over multiple smaller plugins**

- Unified interface for common functionality
- Better performance through shared codebase
- Consistent UX across different features
- Reduced plugin count and startup overhead

#### **Catppuccin over other themes**

- Excellent plugin ecosystem support
- Consistent color palette across tools
- High contrast and accessibility
- Active maintenance and updates

### Plugin Selection Criteria

1. **Performance Impact**: Must not significantly slow startup
2. **Maintenance**: Actively maintained with regular updates
3. **Integration**: Works well with existing plugin ecosystem
4. **Functionality**: Provides clear value over built-in alternatives
5. **Configuration**: Reasonable defaults with customization options

## Performance Guidelines

### Startup Optimization

- Use lazy loading for non-essential plugins
- Minimize autocmds and heavy computations on startup
- Profile startup time regularly with `:Lazy profile`
- Defer complex initialization to after UI is ready

### Memory Management

- Monitor memory usage with `:checkhealth`
- Use appropriate buffer limits for large files
- Configure LSP to avoid memory leaks
- Clean up temporary files and caches

### Profiling Tools

```bash
# Neovim startup profiling
nvim --startuptime startup.log

# Lua profiling within Neovim
:lua require('plenary.profile').start('profile.log', {flame = true})
# ... perform actions ...
:lua require('plenary.profile').stop()
```

### Performance Targets

- Startup time < 100ms on modern hardware
- Memory usage < 50MB for basic editing
- LSP response time < 200ms for common operations
- File opening < 50ms for files under 1MB

### `./tests`

- `example_spec.lua` – example test file demonstrating TDD setup with busted framework.

### Testing

#### Test Categories

- **Unit Tests**: Individual module functionality
- **Integration Tests**: Plugin interactions and workflows
- **Performance Tests**: Startup time and memory usage
- **Configuration Tests**: Verify all configurations load properly

#### Running Tests

```bash
# All tests
just test

# Specific test file
busted tests/example_spec.lua

# Watch mode for development
just test-watch

# With coverage (if available)
busted --coverage
```

#### Writing Tests

```lua
-- tests/example_spec.lua
describe("example module", function()
  local example = require("nvim.example")

  before_each(function()
    -- Setup before each test
  end)

  after_each(function()
    -- Cleanup after each test
  end)

  it("should do something", function()
    local result = example.do_something("input")
    assert.are.equal("expected", result)
  end)

  it("should handle edge cases", function()
    assert.has_error(function()
      example.do_something(nil)
    end)
  end)
end)
```

### `./after/plugin`

- `colors.lua` – post-plugin color overrides and theme customizations.

### `./overlays`

- `default.nix` – Nix overlays for custom package modifications.

### `./run`

- `setup-ci` – CI setup script.
- `test-ci` – CI test execution script.

## Troubleshooting

### Common Issues

#### **Neovim won't start**

```bash
# Check for configuration errors
nvim --clean
nvim -u NONE

# Check nixCats build
nix build .#nvim
```

#### **LSP not working**

```bash
# Check LSP status
:LspInfo
:checkhealth lsp

# Restart LSP server
:LspRestart
```

#### **Plugins not loading**

```bash
# Check plugin status
:Lazy
:checkhealth lazy

# Rebuild configuration
just run
```

#### **Performance issues**

```bash
# Profile startup time
nvim --startuptime startup.log

# Check resource usage
:checkhealth
```

#### **Nix build failures**

```bash
# Clean and rebuild
nix flake update
nix build .#nvim --rebuild

# Check flake inputs
nix flake show
```

### Debug Tips

- Use `:messages` to see recent Neovim messages
- Check `:checkhealth` for system-wide issues
- Use `NVIM_APPNAME=nvim-debug nvim` for isolated testing
- Enable verbose logging with `vim.log.level = vim.log.levels.DEBUG`
- Test with minimal config using `nvim --clean -u minimal.lua`

### Getting Help

- Check existing GitHub issues before creating new ones
- Include `:checkhealth` output in bug reports
- Provide minimal reproduction steps
- Mention your OS and Nix version

## Resources

### Essential Documentation

- [nixCats Documentation](https://github.com/BirdeeHub/nixCats-nvim) - Nix-based Neovim configuration framework
- [Neovim Documentation](https://neovim.io/doc/) - Official Neovim user manual and API reference
- [Nix Manual](https://nixos.org/manual/nix/stable/) - Nix package manager documentation
- [Home Manager](https://nix-community.github.io/home-manager/) - Declarative dotfile management

### Plugin Documentation

- [Snacks.nvim](https://github.com/folke/snacks.nvim) - Multi-purpose plugin suite
- [blink.cmp](https://github.com/Saghen/blink.cmp) - Modern completion engine
- [Catppuccin](https://github.com/catppuccin/nvim) - Pastel theme for Neovim
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting and parsing

### Neovim Learning Resources

- [Neovim from Scratch](https://github.com/LunarVim/Neovim-from-scratch) - Step-by-step configuration guide
- [Lua for Neovim](https://github.com/nanotee/nvim-lua-guide) - Comprehensive Lua in Neovim guide
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig) - Language server protocol setup

### Nix Learning Resources

- [Nix Pills](https://nixos.org/guides/nix-pills/) - Introduction to Nix concepts
- [NixOS Wiki](https://nixos.wiki/) - Community-driven documentation
- [Nix Flakes](https://nixos.wiki/wiki/Flakes) - Modern Nix configuration format

### Development Tools

- [Nix Direnv](https://github.com/nix-community/nix-direnv) - Automatic environment setup
- [Just](https://github.com/casey/just) - Command runner and task automation
- [Busted](https://olivinelabs.com/busted/) - Lua testing framework

---

> **Note for AI Agents**: This file is also available as `AGENTS.md` and `CLAUDE.md` (symlinks). All three files reference the same content. Please refer to
> this comprehensive development guide for project structure, architecture, and contribution guidelines.
