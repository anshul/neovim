-- Plugin loading and functionality tests

local function run_nvim_with_config(cmd, timeout)
  timeout = timeout or 10
  local handle = io.popen('timeout ' .. timeout .. ' nvim --headless -c "' .. cmd .. '" -c "qa!" 2>&1')
  local result = handle:read '*a'
  local success = handle:close()
  return success, result
end

local function check_plugin_loaded(plugin_name)
  local cmd = 'lua if pcall(require, "' .. plugin_name .. '") then print("LOADED") else print("FAILED") end'
  local success, output = run_nvim_with_config(cmd)
  return success and output:match 'LOADED'
end

describe('Plugin Loading Tests', function()
  describe('Core Plugins', function()
    it('should load treesitter', function()
      local loaded = check_plugin_loaded 'nvim-treesitter'
      assert.is_true(loaded, 'Treesitter should load successfully')
    end)

    it('should load LSP config', function()
      local loaded = check_plugin_loaded 'lspconfig'
      assert.is_true(loaded, 'LSP config should load successfully')
    end)

    it('should load completion engine', function()
      local loaded = check_plugin_loaded 'blink.cmp'
      assert.is_true(loaded, 'Blink completion should load successfully')
    end)

    it('should load which-key', function()
      local loaded = check_plugin_loaded 'which-key'
      assert.is_true(loaded, 'Which-key should load successfully')
    end)

    it('should load snacks', function()
      local loaded = check_plugin_loaded 'snacks'
      assert.is_true(loaded, 'Snacks should load successfully')
    end)
  end)

  describe('Theme and UI', function()
    it('should load catppuccin theme', function()
      local loaded = check_plugin_loaded 'catppuccin'
      assert.is_true(loaded, 'Catppuccin theme should load successfully')
    end)

    it('should load lualine', function()
      local loaded = check_plugin_loaded 'lualine'
      assert.is_true(loaded, 'Lualine should load successfully')
    end)

    it('should load mini modules', function()
      local loaded = check_plugin_loaded 'mini.files'
      assert.is_true(loaded, 'Mini.files should load successfully')
    end)
  end)

  describe('Git Integration', function()
    it('should load gitsigns', function()
      local loaded = check_plugin_loaded 'gitsigns'
      assert.is_true(loaded, 'Gitsigns should load successfully')
    end)

    it('should load neogit', function()
      local loaded = check_plugin_loaded 'neogit'
      assert.is_true(loaded, 'Neogit should load successfully')
    end)
  end)

  describe('AI and Completion', function()
    it('should load avante', function()
      local loaded = check_plugin_loaded 'avante'
      assert.is_true(loaded, 'Avante should load successfully')
    end)

    it('should load copilot', function()
      local loaded = check_plugin_loaded 'copilot'
      assert.is_true(loaded, 'Copilot should load successfully')
    end)
  end)

  describe('Plugin Functionality', function()
    it('should have treesitter parsers available', function()
      local cmd = 'lua local ts = require("nvim-treesitter.parsers"); print(#ts.available_parsers() > 0 and "PARSERS" or "NO_PARSERS")'
      local success, output = run_nvim_with_config(cmd, 15)
      assert.is_true(success and output:match 'PARSERS', 'Treesitter parsers should be available')
    end)

    it('should have LSP clients configurable', function()
      local cmd = 'lua print(vim.lsp.get_clients and "LSP_OK" or "LSP_MISSING")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'LSP_OK', 'LSP should be functional')
    end)
  end)
end)
