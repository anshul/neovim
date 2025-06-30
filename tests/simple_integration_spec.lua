-- Simple integration tests focused on configuration structure
require('tests.mock_nixcats').setup()

describe('Configuration Integration', function()
  describe('Core Module Loading', function()
    it('should load all main modules without errors', function()
      local modules = {
        'nvim.options',
        'nvim.autocmds',
        'nvim.treesitter',
        'nvim.keymaps',
        'nvim.themes',
        'nvim.lsps',
        'nvim.completions',
        'nvim.ai',
        'nvim.bars',
        'nvim.plugins',
        'nvim.git',
        'nvim.debug',
        'nvim.literate',
        'nvim.ui',
        'nvim.misc',
        'nvim.lang',
      }

      for _, module in ipairs(modules) do
        local success, err = pcall(require, module)
        assert.is_true(success, 'Module ' .. module .. ' should load without errors: ' .. (type(err) == 'string' and err or 'unknown error'))
      end
    end)

    it('should have proper language support modules', function()
      local lang_modules = {
        'nvim.lang.elixir',
        'nvim.lang.rust',
      }

      for _, module in ipairs(lang_modules) do
        local success, err = pcall(require, module)
        assert.is_true(success, 'Language module ' .. module .. ' should load: ' .. (type(err) == 'string' and err or 'unknown error'))
      end
    end)

    it('should have streamlined AI configuration', function()
      -- Should only have copilot-chat now
      local success = pcall(require, 'nvim.ai.copilot-chat')
      assert.is_true(success, 'CopilotChat should be available')

      -- These should not exist anymore (files were deleted)
      -- Since require will return {} from our mock, check file existence directly
      local function file_exists(path)
        local f = io.open(path, 'r')
        if f then
          f:close()
          return true
        end
        return false
      end

      assert.is_false(file_exists 'lua/nvim/ai/claude.lua', 'Claude file should be removed')
      assert.is_false(file_exists 'lua/nvim/ai/wtf.lua', 'WTF file should be removed')
    end)
  end)

  describe('Configuration Values', function()
    it('should have correct indentation settings', function()
      require 'nvim.options'
      assert.is_equal(2, vim.o.tabstop, 'Tab width should be 2')
      assert.is_equal(2, vim.o.shiftwidth, 'Shift width should be 2')
      assert.is_true(vim.o.expandtab, 'Expand tabs should be enabled')
    end)

    it('should have leader keys configured', function()
      require 'nvim.init'
      assert.is_equal(' ', vim.g.mapleader, 'Leader should be space')
      assert.is_equal(' ', vim.g.maplocalleader, 'Local leader should be space')
    end)
  end)

  describe('LSP Configuration', function()
    it('should have servers configuration', function()
      local servers = require 'nvim.lsps.servers'
      assert.is_table(servers, 'Servers should be a table')

      -- Check for key language servers
      assert.is_not_nil(servers.lua_ls, 'Lua LSP should be configured')
      assert.is_not_nil(servers.rust_analyzer, 'Rust analyzer should be configured')
      assert.is_not_nil(servers.ts_ls, 'TypeScript LSP should be configured')
      assert.is_not_nil(servers.lexical, 'Elixir Lexical should be configured')
    end)

    it('should have enhanced Rust configuration', function()
      local servers = require 'nvim.lsps.servers'
      local rust_config = servers.rust_analyzer
      assert.is_table(rust_config.settings, 'Rust analyzer should have settings')
      assert.is_table(rust_config.settings['rust-analyzer'], 'Should have rust-analyzer settings')
      assert.is_equal('clippy', rust_config.settings['rust-analyzer'].check.command, 'Should use clippy')
    end)
  end)

  describe('Dashboard Configuration', function()
    it('should have updated dashboard without Claude references', function()
      local dashboard = require 'nvim.ui.snacks-dashboard'
      assert.is_table(dashboard.dashboard, 'Dashboard should be configured')

      local keys = dashboard.dashboard.preset.keys
      local has_copilot = false
      local has_claude = false

      for _, key in ipairs(keys) do
        if key.desc and key.desc:match '[Cc]opilot' then
          has_copilot = true
        end
        if key.desc and key.desc:match '[Cc]laude' then
          has_claude = true
        end
      end

      assert.is_true(has_copilot, 'Dashboard should have Copilot Chat')
      assert.is_false(has_claude, 'Dashboard should not have Claude references')
    end)
  end)
end)
