-- Simplified configuration validation tests
-- These tests validate the config structure without requiring full plugin loading

describe('Configuration Validation', function()
  describe('Config Files Exist and Load', function()
    it('should have valid init.lua', function()
      local success = pcall(require, 'nvim')
      assert.is_true(success, 'Main init.lua should load without syntax errors')
    end)

    it('should have valid options configuration', function()
      local success = pcall(require, 'nvim.options')
      assert.is_true(success, 'Options should load without errors')
    end)

    it('should have valid keymap configuration', function()
      local success = pcall(require, 'nvim.keymaps')
      assert.is_true(success, 'Keymaps should load without errors')
    end)

    it('should have valid LSP configuration', function()
      local success = pcall(require, 'nvim.lsps')
      assert.is_true(success, 'LSP config should load without errors')
    end)

    it('should have valid theme configuration', function()
      local success = pcall(require, 'nvim.themes')
      assert.is_true(success, 'Theme config should load without errors')
    end)

    it('should have valid treesitter configuration', function()
      local success = pcall(require, 'nvim.treesitter')
      assert.is_true(success, 'Treesitter config should load without errors')
    end)
  end)

  describe('Module Structure', function()
    it('should have all expected keymap modules', function()
      assert.is_true(pcall(require, 'nvim.keymaps.keymaps'))
      assert.is_true(pcall(require, 'nvim.keymaps.keymaps-plugins'))
      assert.is_true(pcall(require, 'nvim.keymaps.keymaps-snacks'))
      assert.is_true(pcall(require, 'nvim.keymaps.whichkey'))
    end)

    it('should have all expected LSP modules', function()
      assert.is_true(pcall(require, 'nvim.lsps.lsp'))
      assert.is_true(pcall(require, 'nvim.lsps.servers'))
      assert.is_true(pcall(require, 'nvim.lsps.formatters'))
      assert.is_true(pcall(require, 'nvim.lsps.linters'))
    end)

    it('should have all expected UI modules', function()
      assert.is_true(pcall(require, 'nvim.ui'))
      assert.is_true(pcall(require, 'nvim.bars'))
      assert.is_true(pcall(require, 'nvim.misc'))
    end)

    it('should have all expected AI modules', function()
      assert.is_true(pcall(require, 'nvim.ai'))
      assert.is_true(pcall(require, 'nvim.ai.avante'))
      assert.is_true(pcall(require, 'nvim.ai.chatgpt'))
    end)
  end)

  describe('Configuration Values', function()
    it('should set leader key', function()
      require 'nvim.keymaps'
      assert.is_not_nil(vim.g.mapleader, 'Leader key should be set')
    end)

    it('should configure basic options', function()
      require 'nvim.options'
      assert.is_true(vim.o.termguicolors, 'True colors should be enabled')
      assert.is_equal(2, vim.o.tabstop, 'Tab width should be 2')
      assert.is_true(vim.o.expandtab, 'Expand tabs should be enabled')
    end)

    it('should have clipboard configured', function()
      require 'nvim.options'
      assert.is_not_nil(vim.o.clipboard, 'Clipboard should be configured')
    end)
  end)

  describe('Plugin Configurations', function()
    it('should have valid plugin specs without loading', function()
      -- Test that plugin configs can be required without errors
      local plugin_configs = {
        'nvim.completions.blink-cmp',
        'nvim.git.gitsigns',
        'nvim.ui.snacks',
        'nvim.themes.catppuccin',
      }

      for _, config in ipairs(plugin_configs) do
        local success = pcall(require, config)
        assert.is_true(success, config .. ' should load without errors')
      end
    end)
  end)
end)
