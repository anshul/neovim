# Neovim Configuration Test Suite

This directory contains integration tests for the Neovim configuration to ensure it compiles and functions correctly.

## Test Structure

### Working Tests

- **`simple_spec.lua`** - File structure and syntax validation tests
- **`functional_spec.lua`** - Basic Neovim functionality tests
- **`example_spec.lua`** - Simple unit test examples

### Plugin-Dependent Tests (require full Neovim environment)

- **`integration_spec.lua`** - Full config loading tests
- **`plugins_spec.lua`** - Plugin loading verification
- **`lsp_spec.lua`** - LSP integration tests
- **`keymaps_spec.lua`** - Keymap functionality tests
- **`config_spec.lua`** - Configuration validation tests

## Available Test Commands

```bash
# Run all tests
just test

# Run only working integration tests
just test_integration

# Run unit tests only
just test_unit

# Run CI test suite (unit + integration)
just test_ci

# Watch for changes and auto-run tests
just test_watch

# TDD mode - continuous testing
just tdd
```

## Test Categories

### 1. **File Structure Tests** (`simple_spec.lua`)

- Verifies all essential config files exist
- Validates Lua syntax of configuration files
- Checks directory structure integrity
- Tests build system files (justfile, flake.nix, etc.)

### 2. **Functional Tests** (`functional_spec.lua`)

- Tests basic Neovim functionality in headless mode
- Validates core Vim operations (files, buffers, windows)
- Verifies Lua integration works properly
- Tests filetype detection

### 3. **Integration Tests** (plugin-dependent)

- Full configuration loading
- Plugin initialization
- LSP functionality
- Keymap configuration
- Theme and UI components

## Usage

The test suite is designed to run in multiple environments:

- **Local Development**: Full test suite with plugins
- **CI/Headless**: Basic functionality tests only
- **Syntax Validation**: File structure and syntax tests

Run `just test_ci` for the most reliable test execution that works in any environment.

## Test Framework

Tests use the [Busted](https://lunarmodules.github.io/busted/) framework with LuaJIT runtime. Configuration is in `.busted`.

## Adding New Tests

1. Create `*_spec.lua` files in this directory
2. Use existing test patterns for consistency
3. Keep plugin-dependent tests separate from core functionality tests
4. Add new test commands to `justfile` if needed
