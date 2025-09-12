describe('Plugin Health Checks', function()
  local function check_plugin_loads(plugin_name)
    it('should load ' .. plugin_name .. ' without errors', function()
      local ok, err = pcall(require, plugin_name)
      if not ok then
        error(string.format('Failed to load %s: %s', plugin_name, err))
      end
    end)
  end

  local function check_optional_plugin(plugin_name)
    it('optional plugin ' .. plugin_name .. ' should be available', function()
      local plugin_path = vim.fn.globpath(vim.o.packpath, 'pack/*/opt/' .. plugin_name, 1)
      assert.is_not_equal('', plugin_path, plugin_name .. ' not found in opt plugins')
    end)
  end

  describe('Core plugin dependencies', function()
    local core_plugins = {
      'plenary',
      'nui',
      'lze',
    }

    for _, plugin in ipairs(core_plugins) do
      check_plugin_loads(plugin)
    end
  end)

  describe('Optional plugins availability', function()
    local optional_plugins = {
      'plenary.nvim',
      'blink-cmp',
      'fzf-lua',
      'obsidian.nvim',
      'snacks.nvim',
      'gitsigns.nvim',
      'diffview.nvim',
      'neogit',
      'oil.nvim',
      'trouble.nvim',
      'which-key.nvim',
      'conform.nvim',
      'nvim-lint',
      'nvim-dap',
      'nvim-dap-ui',
    }

    for _, plugin in ipairs(optional_plugins) do
      check_optional_plugin(plugin)
    end
  end)

  describe('Plugin configuration checks', function()
    it('should load all lua modules without errors', function()
      local config_modules = {
        'nvim.options',
        'nvim.autocmds',
        'nvim.keymaps',
        'nvim.lsps',
        'nvim.completions',
        'nvim.bars',
        'nvim.themes',
        'nvim.plugins',
        'nvim.git',
        'nvim.ai',
        'nvim.ui',
        'nvim.misc',
        'nvim.literate',
        'nvim.debug',
        'nvim.lang',
      }

      for _, module in ipairs(config_modules) do
        local ok, err = pcall(require, module)
        assert.is_true(ok, string.format('Failed to load %s: %s', module, tostring(err)))
      end
    end)

    it('obsidian.nvim should have required dependencies', function()
      local deps = {
        'plenary.nvim',
        'fzf-lua',
      }

      for _, dep in ipairs(deps) do
        local plugin_path = vim.fn.globpath(vim.o.packpath, 'pack/*/opt/' .. dep, 1)
        assert.is_not_equal('', plugin_path, 'obsidian.nvim dependency ' .. dep .. ' not found')
      end
    end)

    it('should detect if fzf-lua can be loaded for obsidian', function()
      local lze_available, lze = pcall(require, 'lze')
      if lze_available then
        lze.load { 'fzf-lua', 'plenary.nvim' }
        local ok, _ = pcall(require, 'fzf-lua')
        assert.is_true(ok, 'fzf-lua cannot be loaded - obsidian.nvim will fail')
      end
    end)
  end)

  describe('Startup error detection', function()
    it('should start nvim without errors', function()
      local handle = io.popen 'nix run .#nvim -- --headless -c "echo \'started\'" -c "qa!" 2>&1'
      if handle then
        local result = handle:read '*a'
        handle:close()
        assert.does_not_match('Error', result, 'Startup errors detected: ' .. result)
        assert.does_not_match('Failed', result, 'Startup failures detected: ' .. result)
        assert.does_not_match('require.*failed', result, 'Require failures detected: ' .. result)
      else
        error 'Failed to run nvim test'
      end
    end)

    it('should check health without errors', function()
      local handle = io.popen 'nix run .#nvim -- --headless -c "checkhealth" -c "qa!" 2>&1'
      if handle then
        local result = handle:read '*a'
        handle:close()
        assert.does_not_match('ERROR', result, 'Health check errors: ' .. result)
      else
        error 'Failed to run health check'
      end
    end)
  end)
end)
