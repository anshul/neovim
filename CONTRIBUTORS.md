# Contributors Guide

## Instructions

- This repository is a Neovim configuration built with **Nix** and **Lua**.
- Always update `CONTIBUTORS.md` after major structural changes (creating / deleting files, repurposing directories, files).
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
```

## Project Overview

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

## Architecture Decisions

### Key Technology Choices

#### **nixCats over other Neovim distributions**

- Reproducible builds across different systems
- Declarative plugin management with Nix

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

### Profiling Tools

```bash
# Custom build command defined in flake.nix
build
# Neovim startup profiling
./nvim --startuptime startup.log

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

### Testing

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

## Troubleshooting

### Common Issues

#### **Neovim won't start**

```bash
# Build the binary
build
# Check for configuration errors
./nvim --clean
./nvim -u NONE

# Quick test with headless mode
./nvim --headless
```

## Resources

### Essential Documentation

- [nixCats Documentation](https://github.com/BirdeeHub/nixCats-nvim) - Nix-based Neovim configuration framework
- [Neovim Documentation](https://neovim.io/doc/) - Official Neovim user manual and API reference
- [Nix Manual](https://nixos.org/manual/nix/stable/) - Nix package manager documentation

### Plugin Documentation

- [Snacks.nvim](https://github.com/folke/snacks.nvim) - Multi-purpose plugin suite
- [blink.cmp](https://github.com/Saghen/blink.cmp) - Modern completion engine
- [Catppuccin](https://github.com/catppuccin/nvim) - Pastel theme for Neovim
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting and parsing

> **Note for AI Agents**: This file is also available as `AGENTS.md` and `CLAUDE.md` (symlinks). All three files reference the same content. Please refer to
> this comprehensive development guide for project structure, architecture, and contribution guidelines.
