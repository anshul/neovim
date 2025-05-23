# Instructions

- This repository is a neovim configuration using nix and lua.
- Always remember to update the root AGENTS.md file after major changes like creating and deleting files or changing their purpose.
- Always update the README.md when keyboard shortcuts change. When you do this verify that all the info in the README.md is correct.
- The dev shell includes `just`, `alejandra`, `markdownlint`, `ruff`, `stylua` and `shellcheck` for linting and formatting tasks.

## Coding Conventions

- Use 2-space indentation for all code files
- Comments in code should be concise and relevant
- Use `nix develop` to enter the development environment before running commands

## Overview

Here is a high-level overiew of the project structure:

.
├── AGENTS.md - contributor instructions and file overview
├── flake.nix - Nix flake defining packages and dev shell
├── packages.nix - plugin package specifications
├── categories.nix - plugin categories and environment settings
├── init.lua - entry point for the Neovim config
├── after - runtime configuration executed after plugins load
│   └── plugin - plugin specific config
│   └── colors.lua - custom highlight tweaks
├── lua - root Lua sources
│   └── nvim - main Lua module
│   ├── ai - AI helper plugins
│   │   ├── avante.lua - Avante AI integration
│   │   ├── chatgpt.lua - ChatGPT prompts
│   │   ├── init.lua - loads AI plugins
│   │   └── wtf.lua - debug AI helper
│   ├── autocmds.lua - autocommand definitions
│   ├── bars - statusline and tabline modules
│   │   ├── incline.lua - incline statusline
│   │   ├── init.lua - loads bar modules
│   │   ├── lualine.lua - lualine statusline
│   │   ├── slimline.lua - slimline statusline
│   │   └── tabby.lua - tabby tabline
│   ├── completions - completion sources
│   │   ├── blink-cmp.lua - blink completion
│   │   ├── copilot.lua - GitHub Copilot source
│   │   ├── init.lua - loads completions
│   │   └── neogen.lua - docs generation
│   ├── debug - debugging setup
│   │   └── init.lua - debugging helpers
│   ├── git - git integration modules
│   │   ├── diffview.lua - diffview setup
│   │   ├── gitsigns.lua - git signs config
│   │   ├── init.lua - loads git modules
│   │   ├── neogit.lua - Neogit config
│   │   └── octo.lua - GitHub interactions
│   ├── init.lua - loads all nvim modules
│   ├── keymaps - keyboard mappings
│   │   ├── init.lua - loads keymaps
│   │   ├── keymaps-plugins.lua - plugin bindings
│   │   ├── keymaps-snacks.lua - snack bindings
│   │   ├── keymaps.lua - core mappings
│   │   └── whichkey.lua - which-key menu
│   ├── literate - literate programming tools
│   │   ├── init.lua - loads literate tools
│   │   ├── iron.lua - REPL management
│   │   └── neopyter.lua - Jupyter helpers
│   ├── lsps - LSP configuration
│   │   ├── diagnostic-signs.lua - diagnostic icons
│   │   ├── formatters.lua - formatter configs
│   │   ├── init.lua - loads LSP modules
│   │   ├── linters.lua - linter configs
│   │   ├── lsp.lua - LSP setup
│   │   ├── lspsaga.lua - lspsaga UI
│   │   ├── servers.lua - server definitions
│   │   └── symbol-usage.lua - symbol UI
│   ├── misc - misc helper plugins
│   │   ├── comment.lua - comment toggler
│   │   ├── flash.lua - jump helper
│   │   ├── init.lua - loads misc
│   │   ├── mini-files.lua - mini file explorer
│   │   ├── mini.lua - minilib setup
│   │   ├── obsidian.lua - obsidian notes
│   │   ├── render-markdown.lua - markdown renderer
│   │   ├── search-replace.lua - search and replace
│   │   └── session.lua - session management
│   ├── options.lua - vim options
│   ├── plugins - plugin manager
│   │   └── init.lua - plugin definitions
│   ├── themes - color themes
│   │   ├── catppuccin.lua - catppuccin theme
│   │   ├── init.lua - loads themes
│   │   └── rose-pine.lua - rose-pine theme
│   ├── treesitter.lua - treesitter setup
│   └── ui - UI enhancements
│   ├── colorful-winsep.lua - window separators
│   ├── folding.lua - folding visuals
│   ├── grapple.lua - quick navigation
│   ├── highlight-colors.lua - highlight color codes
│   ├── indent.lua - indentation guides
│   ├── init.lua - loads UI modules
│   ├── mini-indent.lua - minimal indent guides
│   ├── notifications.lua - notification system
│   ├── oil.lua - file browser
│   ├── reactive.lua - reactive UI helpers
│   ├── smear.lua - smear plugin setup
│   ├── snacks-dashboard.lua - snacks dashboard
│   ├── snacks-rename.lua - rename popup
│   ├── snacks.lua - snacks utilities
│   ├── tiny-diagnostics.lua - slim diagnostics
│   └── zen.lua - zen mode
├── overlays - additional Nix overlays
│   └── default.nix - optional custom overlay
├── run - helper scripts
│   ├── setup-ci - CI environment bootstrap
│   └── test-ci - minimal CI check
├── README.md - usage instructions
├── justfile - command shortcuts
└── stylua.toml - Lua formatter settings
