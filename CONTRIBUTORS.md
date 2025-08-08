# Contributors Guide

This file provides guidance to all human and AI agents when working with code in this repository.

## Repository Overview

This is an AI-first Neovim configuration built with Nix and Lua using the nixCats framework. It's designed for use with Supermaven Pro (1M token context)
and focuses on performance, modern development workflows, and vim aesthetics.

## Essential Commands

### Development & Testing

```bash
# Enter development environment (required before running tools)
nix develop

# Build and run Neovim
just run           # or: nix run .#nvim
just build         # Build binary only

# Run tests
just test          # Run all tests with busted
just test_unit     # Unit tests only
just test_integration  # Integration tests
just test_ci       # CI-safe test suite
just test_watch    # Watch mode for TDD
just tdd           # Continuous testing loop

# Code quality (ALWAYS run before committing)
just fix           # Format and lint all code (alejandra, stylua, prettier, markdownlint, ruff, shellcheck)
just lint          # Run linters only

# Update dependencies
just update        # Update flake inputs
```

### Important Testing Notes

- Test framework: **Busted** with **LuaJIT**
- Test files located in `tests/` directory
- Run formatting/linting with `just fix` after any changes
- Never assume test commands - check `justfile` or ask user

## Architecture Overview

### Directory Structure

```text
lua/nvim/              # Core Neovim configuration
├── init.lua          # Main orchestrator, loads all modules
├── options.lua       # Core settings (118 lines of tuned options)
├── autocmds.lua      # Quality-of-life autocommands
├── keymaps/          # Keyboard mappings (4 modules)
├── lsps/             # LSP configurations and servers
├── completions/      # blink.cmp and Supermaven Pro setup
├── bars/             # Status/tab bars (5 variants)
├── themes/           # Catppuccin and Rose Pine
├── plugins/          # General utilities
├── git/              # Git integrations (gitsigns, neogit, diffview, octo)
├── ui/               # Visual enhancements (14 components)
├── misc/             # Additional utilities (10 tools)
├── literate/         # REPL integrations
├── debug/            # DAP configurations
└── lang/             # Language-specific (Elixir, Rust)

flake.nix             # Nix flake with 15 plugin inputs
packages.nix          # 84 LSPs/tools, 116 startup, 206+ optional plugins
categories.nix        # nixCats plugin categorization
```

### Key Technical Decisions

- **Framework**: nixCats (Nix-based) with lze (lazy loading)
- **Completion**: blink.cmp (faster than nvim-cmp)
- **AI**: Supermaven Pro as primary, Claude.vim for chat
- **Multi-tool suite**: Snacks.nvim for unified UX
- **Theme**: Catppuccin with Rose Pine alternative
- **Plugin count**: 16 startup, 200+ lazy-loaded

### Unique Behaviors

- **Clipboard**: Uses vim local registers by default, NOT system clipboard
  - `y`, `d`, `c` operations stay in vim
  - `Shift+Cmd+V` / `Shift+Ctrl+V` for system paste
  - `Cmd+Shift+C` / `Ctrl+Shift+C` for system copy
- **Kitty terminal**: Special scrollback handling
- **Obsidian**: Auto-creates vault at `~/Documents/Obsidian`

## Development Guidelines

### Code Style

- **Lua**: 2-space indentation, single quotes, no call parentheses (stylua.toml)
- **Nix**: alejandra formatter
- **All languages**: 2-space indentation
- **NO COMMENTS** unless explicitly requested

### Commit Standards

Use Conventional Commits format:

- `feat:` New feature/enhancement
- `fix:` Bug fix
- `perf:` Performance improvement
- `refactor:` Code restructuring
- `docs:` Documentation updates
- `test:` Test changes
- `chore:` Maintenance tasks

### Before Making Changes

1. Always check existing patterns in neighboring files
2. Use existing libraries/frameworks (check package.json, cargo.toml, etc.)
3. Follow existing naming conventions and code style
4. Run `just fix` after changes
5. Verify with appropriate tests

### Working with Plugins

- Startup plugins (16): Essential, loaded immediately
- Optional plugins (200+): Lazy-loaded on demand
- Always verify a library exists before using it
- Check `packages.nix` for available tools/LSPs

## Performance Targets

- Startup time: < 100ms
- Memory usage: < 50MB basic editing
- LSP response: < 200ms
- File opening: < 50ms for files under 1MB

## Common Workflows

### Adding Language Support

1. Check `lua/nvim/lsps/servers.lua` for existing LSP configs
2. Add LSP to `packages.nix` if needed
3. Configure in appropriate module under `lua/nvim/lang/`

### Modifying Keymaps

1. Check `lua/nvim/keymaps/` for the appropriate module
2. Update keymap definition
3. Update README.md keyboard shortcuts section
4. Run `just fix` to format

### Plugin Management

1. Add to `flake.nix` inputs if external
2. Update `packages.nix` startup/optional lists
3. Configure in appropriate `lua/nvim/` module
4. Test with `just test_integration`

## Critical Files to Know

- `lua/nvim/init.lua` - Main entry point and module loader
- `lua/nvim/options.lua:33-50` - Unique clipboard configuration
- `lua/nvim/completions/supermaven.lua` - AI completion setup
- `lua/nvim/keymaps/keymaps.lua` - Core keyboard mappings
- `justfile` - All available commands
- `CONTRIBUTORS.md` - Development guidelines (also symlinked as AGENTS.md)

> Note: This file is also symlinked as `AGENTS.md` and `CLAUDE.md` for convenience.
