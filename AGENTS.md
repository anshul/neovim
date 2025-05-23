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
├── AGENTS.md
├── flake.nix
├── packages.nix
├── categories.nix
├── init.lua
├── after
│   └── plugin
│   └── colors.lua
├── lua
│   └── nvim
│   ├── ai
│   │   ├── avante.lua
│   │   ├── chatgpt.lua
│   │   ├── init.lua
│   │   └── wtf.lua
│   ├── autocmds.lua
│   ├── bars
│   │   ├── incline.lua
│   │   ├── init.lua
│   │   ├── lualine.lua
│   │   ├── slimline.lua
│   │   └── tabby.lua
│   ├── completions
│   │   ├── blink-cmp.lua
│   │   ├── copilot.lua
│   │   ├── init.lua
│   │   └── neogen.lua
│   ├── debug
│   │   └── init.lua
│   ├── git
│   │   ├── diffview.lua
│   │   ├── gitsigns.lua
│   │   ├── init.lua
│   │   ├── neogit.lua
│   │   └── octo.lua
│   ├── init.lua
│   ├── keymaps
│   │   ├── init.lua
│   │   ├── keymaps-plugins.lua
│   │   ├── keymaps-snacks.lua
│   │   ├── keymaps.lua
│   │   └── whichkey.lua
│   ├── literate
│   │   ├── init.lua
│   │   ├── iron.lua
│   │   └── neopyter.lua
│   ├── lsps
│   │   ├── diagnostic-signs.lua
│   │   ├── formatters.lua
│   │   ├── init.lua
│   │   ├── linters.lua
│   │   ├── lsp.lua
│   │   ├── lspsaga.lua
│   │   ├── servers.lua
│   │   └── symbol-usage.lua
│   ├── misc
│   │   ├── comment.lua
│   │   ├── flash.lua
│   │   ├── init.lua
│   │   ├── mini-files.lua
│   │   ├── mini.lua
│   │   ├── obsidian.lua
│   │   ├── render-markdown.lua
│   │   ├── search-replace.lua
│   │   └── session.lua
│   ├── options.lua
│   ├── plugins
│   │   └── init.lua
│   ├── themes
│   │   ├── catppuccin.lua
│   │   ├── init.lua
│   │   └── rose-pine.lua
│   ├── treesitter.lua
│   └── ui
│   ├── colorful-winsep.lua
│   ├── folding.lua
│   ├── grapple.lua
│   ├── highlight-colors.lua
│   ├── indent.lua
│   ├── init.lua
│   ├── mini-indent.lua
│   ├── notifications.lua
│   ├── oil.lua
│   ├── reactive.lua
│   ├── smear.lua
│   ├── snacks-dashboard.lua
│   ├── snacks-rename.lua
│   ├── snacks.lua
│   ├── tiny-diagnostics.lua
│   └── zen.lua
├── overlays
│   └── default.nix
├── run
│   ├── setup-ci
│   └── test-ci
├── README.md
├── justfile
└── stylua.toml
