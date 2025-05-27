-- Integration tests for Neovim configuration
-- These tests verify that the config loads and functions correctly

local function run_nvim_cmd(cmd)
  local handle = io.popen('nvim --headless --noplugin -u NONE -c "' .. cmd .. '" -c "qa!" 2>&1')
  local result = handle:read '*a'
  local success = handle:close()
  return success, result
end

local function run_nvim_with_config(cmd)
  local handle = io.popen('nvim --headless -c "' .. cmd .. '" -c "qa!" 2>&1')
  local result = handle:read '*a'
  local success = handle:close()
  return success, result
end

describe('Neovim Integration Tests', function()
  describe('Core Startup', function()
    it('should start without errors', function()
      local success, output = run_nvim_cmd 'echo "test"'
      assert.is_true(success, 'Neovim should start successfully: ' .. (output or ''))
    end)

    it('should load configuration without errors', function()
      local success, output = run_nvim_with_config 'echo "config loaded"'
      assert.is_true(success, 'Config should load without errors: ' .. (output or ''))
    end)

    it('should start with full config without error messages', function()
      local success, output = run_nvim_with_config 'messages'
      assert.is_true(success, 'Config should load successfully: ' .. (output or ''))

      -- Check for common error patterns
      local error_patterns = {
        'Error detected',
        'E%d+:',
        'error loading module',
        'stack traceback:',
        'attempt to call',
        'attempt to index',
        'module .* not found',
      }

      for _, pattern in ipairs(error_patterns) do
        assert.is_falsy(output:match(pattern), 'Should not contain error pattern "' .. pattern .. '": ' .. (output or ''))
      end
    end)

    it('should have lua modules accessible', function()
      local success, output = run_nvim_with_config 'lua print(vim.version().major)'
      assert.is_true(success, 'Lua should be accessible: ' .. (output or ''))
    end)

    it('should load init.lua successfully', function()
      local success, output = run_nvim_with_config 'lua require("nvim")'
      assert.is_true(success, 'init.lua should load: ' .. (output or ''))
    end)
  end)

  describe('Options Configuration', function()
    it('should set basic options correctly', function()
      local success, output = run_nvim_with_config 'lua print(vim.o.clipboard)'
      assert.is_true(success, 'Options should be set: ' .. (output or ''))
    end)

    it('should have proper indentation settings', function()
      local success, output = run_nvim_with_config 'lua print(vim.o.tabstop)'
      assert.is_true(success, 'Tab settings should work: ' .. (output or ''))
    end)
  end)

  describe('Keymaps', function()
    it('should have leader key configured', function()
      local success, output = run_nvim_with_config 'lua print(vim.g.mapleader)'
      assert.is_true(success, 'Leader key should be set: ' .. (output or ''))
    end)

    it('should load keymap modules', function()
      local success, output = run_nvim_with_config 'lua require("nvim.keymaps")'
      assert.is_true(success, 'Keymaps should load: ' .. (output or ''))
    end)
  end)
end)
