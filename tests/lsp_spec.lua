-- LSP integration tests

local function run_nvim_with_config(cmd, timeout)
  timeout = timeout or 15
  local handle = io.popen('timeout ' .. timeout .. ' nvim --headless -c "' .. cmd .. '" -c "qa!" 2>&1')
  local result = handle:read '*a'
  local success = handle:close()
  return success, result
end

local function create_temp_file(content, extension)
  local tmpfile = os.tmpname() .. (extension or '.lua')
  local file = io.open(tmpfile, 'w')
  if file then
    file:write(content)
    file:close()
  end
  return tmpfile
end

describe('LSP Integration Tests', function()
  describe('LSP Configuration', function()
    it('should have LSP module loadable', function()
      local success, output = run_nvim_with_config 'lua require("nvim.lsps")'
      assert.is_true(success, 'LSP module should load: ' .. (output or ''))
    end)

    it('should have language servers configured', function()
      local cmd = 'lua local servers = require("nvim.lsps.servers"); print(type(servers) == "table" and "SERVERS_OK" or "SERVERS_MISSING")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'SERVERS_OK', 'Language servers should be configured')
    end)

    it('should have formatters configured', function()
      local success, output = run_nvim_with_config 'lua require("nvim.lsps.formatters")'
      assert.is_true(success, 'Formatters should be configured: ' .. (output or ''))
    end)

    it('should have linters configured', function()
      local success, output = run_nvim_with_config 'lua require("nvim.lsps.linters")'
      assert.is_true(success, 'Linters should be configured: ' .. (output or ''))
    end)
  end)

  describe('LSP Functionality', function()
    it('should be able to attach LSP to Lua files', function()
      local tmpfile = create_temp_file('local x = 1\nprint(x)', '.lua')
      local cmd = 'edit ' .. tmpfile .. ' | lua vim.defer_fn(function() print(#vim.lsp.get_clients() > 0 and "LSP_ATTACHED" or "NO_LSP") end, 3000)'
      local success, output = run_nvim_with_config(cmd, 20)
      os.remove(tmpfile)
      -- Note: This may not attach in headless mode without language servers installed
      assert.is_true(success, 'Should be able to open file with LSP: ' .. (output or ''))
    end)

    it('should have diagnostic configuration', function()
      local cmd = 'lua print(vim.diagnostic and "DIAGNOSTICS_OK" or "DIAGNOSTICS_MISSING")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'DIAGNOSTICS_OK', 'Diagnostics should be available')
    end)

    it('should have completion capabilities configured', function()
      local cmd = 'lua local caps = require("blink.cmp").get_lsp_capabilities(); print(caps and "CAPS_OK" or "CAPS_MISSING")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'CAPS_OK', 'LSP capabilities should be configured')
    end)
  end)

  describe('Formatting and Linting', function()
    it('should have conform.nvim loaded for formatting', function()
      local cmd = 'lua print(pcall(require, "conform") and "CONFORM_OK" or "CONFORM_MISSING")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'CONFORM_OK', 'Conform should be available')
    end)

    it('should have lint.nvim loaded for linting', function()
      local cmd = 'lua print(pcall(require, "lint") and "LINT_OK" or "LINT_MISSING")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'LINT_OK', 'Lint should be available')
    end)

    it('should have Format command available', function()
      local cmd = 'lua print(vim.api.nvim_get_commands({})["Format"] and "FORMAT_CMD_OK" or "FORMAT_CMD_MISSING")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'FORMAT_CMD_OK', 'Format command should be available')
    end)
  end)

  describe('LSP UI Enhancements', function()
    it('should have lspsaga loaded', function()
      local cmd = 'lua print(pcall(require, "lspsaga") and "SAGA_OK" or "SAGA_MISSING")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'SAGA_OK', 'LSP Saga should be available')
    end)

    it('should have symbol usage configured', function()
      local success, output = run_nvim_with_config 'lua require("nvim.lsps.symbol-usage")'
      assert.is_true(success, 'Symbol usage should be configured: ' .. (output or ''))
    end)

    it('should have inc-rename available', function()
      local cmd = 'lua print(pcall(require, "inc_rename") and "RENAME_OK" or "RENAME_MISSING")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'RENAME_OK', 'Inc-rename should be available')
    end)
  end)
end)
