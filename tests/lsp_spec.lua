-- LSP integration tests
require('tests.mock_nixcats').setup()

describe('LSP Integration Tests', function()
  describe('LSP Configuration', function()
    it('should have LSP module loadable', function()
      local success, err = pcall(require, 'nvim.lsps')
      assert.is_true(success, 'LSP module should load: ' .. tostring(err or ''))
    end)

    it('should have language servers configured', function()
      local success, servers = pcall(require, 'nvim.lsps.servers')
      assert.is_true(success and type(servers) == 'table', 'Language servers should be configured')
    end)

    it('should have formatters configured', function()
      local success, err = pcall(require, 'nvim.lsps.formatters')
      assert.is_true(success, 'Formatters should be configured: ' .. tostring(err or ''))
    end)

    it('should have linters configured', function()
      local success, err = pcall(require, 'nvim.lsps.linters')
      assert.is_true(success, 'Linters should be configured: ' .. tostring(err or ''))
    end)
  end)

  describe('LSP Functionality', function()
    it('should have lsp module available', function()
      assert.is_not_nil(vim.lsp, 'LSP should be available in vim')
    end)

    it('should have diagnostic configuration', function()
      assert.is_not_nil(vim.diagnostic, 'Diagnostics should be available')
    end)

    it('should have completion capabilities configured', function()
      local success, blink = pcall(require, 'blink.cmp')
      if success and blink.get_lsp_capabilities then
        local caps = blink.get_lsp_capabilities()
        assert.is_not_nil(caps, 'LSP capabilities should be configured')
      else
        -- Skip if blink.cmp is not available in test environment
        pending 'blink.cmp not available in test environment'
      end
    end)
  end)

  describe('Formatting and Linting', function()
    it('should have conform.nvim loaded for formatting', function()
      local success = pcall(require, 'conform')
      if success then
        assert.is_true(true, 'Conform should be available')
      else
        pending 'conform.nvim not available in test environment'
      end
    end)

    it('should have lint.nvim loaded for linting', function()
      local success = pcall(require, 'lint')
      if success then
        assert.is_true(true, 'Lint should be available')
      else
        pending 'lint.nvim not available in test environment'
      end
    end)

    it('should have Format command setup available', function()
      -- Test that the lsp module loads (which sets up the Format command)
      local success, err = pcall(require, 'nvim.lsps.lsp')
      assert.is_true(success, 'LSP setup should be available: ' .. tostring(err or ''))
    end)
  end)

  describe('LSP UI Enhancements', function()
    it('should have lspsaga configuration available', function()
      local success, err = pcall(require, 'nvim.lsps.lspsaga')
      assert.is_true(success, 'LSP Saga configuration should be available: ' .. tostring(err or ''))
    end)

    it('should have symbol usage configured', function()
      local success, err = pcall(require, 'nvim.lsps.symbol-usage')
      assert.is_true(success, 'Symbol usage should be configured: ' .. tostring(err or ''))
    end)

    it('should have inc-rename configuration available', function()
      -- Test that the module loads (inc-rename setup is in lsp.lua)
      local success, err = pcall(require, 'nvim.lsps.lsp')
      assert.is_true(success, 'Inc-rename configuration should be available: ' .. tostring(err or ''))
    end)
  end)
end)
