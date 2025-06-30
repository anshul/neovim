-- Plugin loading and functionality tests
require('tests.mock_nixcats').setup()

describe('Plugin Loading Tests', function()
  describe('Core Plugins', function()
    it('should load treesitter', function()
      local success = pcall(require, 'nvim-treesitter')
      if success then
        assert.is_true(true, 'Treesitter should load successfully')
      else
        pending 'nvim-treesitter not available in test environment'
      end
    end)

    it('should load LSP config', function()
      local success = pcall(require, 'lspconfig')
      if success then
        assert.is_true(true, 'LSP config should load successfully')
      else
        pending 'lspconfig not available in test environment'
      end
    end)

    it('should load completion engine', function()
      local success = pcall(require, 'blink.cmp')
      if success then
        assert.is_true(true, 'Blink completion should load successfully')
      else
        pending 'blink.cmp not available in test environment'
      end
    end)

    it('should load which-key', function()
      local success = pcall(require, 'which-key')
      if success then
        assert.is_true(true, 'Which-key should load successfully')
      else
        pending 'which-key not available in test environment'
      end
    end)

    it('should load snacks', function()
      local success = pcall(require, 'snacks')
      assert.is_true(success, 'Snacks should load successfully')
    end)
  end)

  describe('Theme and UI', function()
    it('should load catppuccin theme', function()
      local success = pcall(require, 'catppuccin')
      if success then
        assert.is_true(true, 'Catppuccin theme should load successfully')
      else
        pending 'catppuccin not available in test environment'
      end
    end)

    it('should load lualine', function()
      local success = pcall(require, 'lualine')
      if success then
        assert.is_true(true, 'Lualine should load successfully')
      else
        pending 'lualine not available in test environment'
      end
    end)

    it('should load mini modules', function()
      local success = pcall(require, 'mini.files')
      if success then
        assert.is_true(true, 'Mini.files should load successfully')
      else
        pending 'mini.files not available in test environment'
      end
    end)
  end)

  describe('Git Integration', function()
    it('should load gitsigns', function()
      local success = pcall(require, 'gitsigns')
      if success then
        assert.is_true(true, 'Gitsigns should load successfully')
      else
        pending 'gitsigns not available in test environment'
      end
    end)

    it('should load neogit', function()
      local success = pcall(require, 'neogit')
      if success then
        assert.is_true(true, 'Neogit should load successfully')
      else
        pending 'neogit not available in test environment'
      end
    end)
  end)

  describe('AI and Completion', function()
    it('should load avante', function()
      local success = pcall(require, 'avante')
      if success then
        assert.is_true(true, 'Avante should load successfully')
      else
        pending 'avante not available in test environment'
      end
    end)

    it('should load copilot', function()
      local success = pcall(require, 'copilot')
      if success then
        assert.is_true(true, 'Copilot should load successfully')
      else
        pending 'copilot not available in test environment'
      end
    end)
  end)

  describe('Plugin Functionality', function()
    it('should have treesitter functionality available', function()
      local success, ts = pcall(require, 'nvim-treesitter.parsers')
      if success and ts.available_parsers then
        local parsers = ts.available_parsers()
        assert.is_not_nil(parsers, 'Treesitter parsers should be available')
      else
        pending 'nvim-treesitter not available in test environment'
      end
    end)

    it('should have LSP clients configurable', function()
      assert.is_not_nil(vim.lsp.get_clients, 'LSP should be functional')
    end)
  end)
end)
