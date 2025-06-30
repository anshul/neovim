require('lze').load {
  {
    'windsurf-vim',
    event = 'BufEnter',
    cmd = 'Codeium',
    after = function(_)
      -- Disable default keybindings to set our own
      vim.g.codeium_disable_bindings = 1

      -- Set up Copilot-style keybindings
      vim.keymap.set('i', '<Tab>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true, desc = 'Accept Windsurf suggestion' })

      vim.keymap.set('i', '<M-]>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true, desc = 'Next Windsurf suggestion' })

      vim.keymap.set('i', '<M-[>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true, desc = 'Previous Windsurf suggestion' })

      vim.keymap.set('i', '<C-]>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true, desc = 'Clear Windsurf suggestion' })

      -- Use Cmd+A instead of Cmd+R to force autocomplete (on macOS)
      vim.keymap.set('i', '<D-a>', function()
        return vim.fn['codeium#Complete']()
      end, { expr = true, silent = true, desc = 'Trigger Windsurf suggestion' })

      -- Alternative for non-macOS systems
      vim.keymap.set('i', '<M-a>', function()
        return vim.fn['codeium#Complete']()
      end, { expr = true, silent = true, desc = 'Trigger Windsurf suggestion' })

      -- Accept word/line from suggestion
      vim.keymap.set('i', '<C-k>', function()
        return vim.fn['codeium#AcceptNextWord']()
      end, { expr = true, silent = true, desc = 'Accept next word from Windsurf' })

      vim.keymap.set('i', '<C-l>', function()
        return vim.fn['codeium#AcceptNextLine']()
      end, { expr = true, silent = true, desc = 'Accept next line from Windsurf' })

      -- Enable Windsurf by default
      vim.g.codeium_enabled = true

      -- Configure filetypes (enable only for specific languages)
      vim.g.codeium_filetypes = {
        -- Windsurf enabled languages
        python = true,
        ruby = true,
        elixir = true,
        rust = true,
        typescript = true,
        javascript = true,
        javascriptreact = true,
        typescriptreact = true,
        -- Enable for Lua
        lua = true,
        go = false,
        nix = false,
        markdown = false,
        json = false,
        yaml = false,
        toml = false,
        html = false,
        css = false,
        scss = false,
        vue = false,
        svelte = false,
        bash = false,
        zsh = false,
        fish = false,
        c = false,
        cpp = false,
        java = false,
        php = false,
        -- Disable for certain filetypes
        gitcommit = false,
        gitrebase = false,
        help = false,
        TelescopePrompt = false,
        lazy = false,
      }

      -- Auto-render suggestions
      vim.g.codeium_render = true

      -- Workspace root hints for chat functionality
      vim.g.codeium_workspace_root_hints = {
        '.bzr',
        '.git',
        '.hg',
        '.svn',
        '_FOSSIL_',
        'package.json',
        'Cargo.toml',
        'go.mod',
        'flake.nix',
      }
    end,
  },
}
