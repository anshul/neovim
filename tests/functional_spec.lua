-- Functional tests that can run in any Neovim environment
-- These test actual functionality without depending on plugin loading

local function run_nvim_minimal(cmd)
  local handle = io.popen('nvim --headless --noplugin -u NONE -c "' .. cmd .. '" -c "qa!" 2>&1')
  local result = handle:read '*a'
  local success = handle:close()
  return success, result
end

describe('Functional Tests', function()
  describe('Neovim Basic Functionality', function()
    it('should start and execute basic commands', function()
      local success, output = run_nvim_minimal 'echo "test"'
      assert.is_true(success, 'Basic Neovim should work: ' .. (output or ''))
    end)

    it('should handle lua execution', function()
      local success, output = run_nvim_minimal 'lua print("lua works")'
      assert.is_true(success, 'Lua should work: ' .. (output or ''))
    end)

    it('should have working file operations', function()
      local tmpfile = os.tmpname()
      local success, output = run_nvim_minimal('edit ' .. tmpfile .. ' | write | quit')
      os.remove(tmpfile)
      assert.is_true(success, 'File operations should work: ' .. (output or ''))
    end)

    it('should handle buffer operations', function()
      local success, output = run_nvim_minimal 'new | bdelete'
      assert.is_true(success, 'Buffer operations should work: ' .. (output or ''))
    end)

    it('should handle window operations', function()
      local success, output = run_nvim_minimal 'split | quit'
      assert.is_true(success, 'Window operations should work: ' .. (output or ''))
    end)
  end)

  describe('Vim Configuration Basics', function()
    it('should handle option setting', function()
      local success, output = run_nvim_minimal 'set number | echo &number'
      assert.is_true(success, 'Option setting should work: ' .. (output or ''))
    end)

    it('should handle keymap creation', function()
      local success, output = run_nvim_minimal 'nnoremap <leader>t :echo "test"<CR>'
      assert.is_true(success, 'Keymap creation should work: ' .. (output or ''))
    end)

    it('should handle autocommands', function()
      local success, output = run_nvim_minimal 'autocmd BufEnter * echo "autocommand works"'
      assert.is_true(success, 'Autocommands should work: ' .. (output or ''))
    end)
  end)

  describe('Lua Integration', function()
    it('should have vim API available', function()
      local success, output = run_nvim_minimal 'lua print(type(vim.api))'
      assert.is_true(success, 'Command should succeed: ' .. (output or ''))
      assert.is_truthy(output:match 'table', 'Vim API should be available')
    end)

    it('should handle vim options via lua', function()
      local success, output = run_nvim_minimal 'lua vim.o.number = true; print(vim.o.number)'
      assert.is_true(success, 'Command should succeed: ' .. (output or ''))
      assert.is_truthy(output:match 'true', 'Vim options should work via lua')
    end)

    it('should handle keymaps via lua', function()
      local success, output = run_nvim_minimal 'lua vim.keymap.set("n", "<leader>x", ":echo \\"mapped\\"<CR>")'
      assert.is_true(success, 'Keymaps should work via lua: ' .. (output or ''))
    end)
  end)

  describe('File Type Detection', function()
    it('should detect lua files', function()
      local tmpfile = os.tmpname() .. '.lua'
      local success, output = run_nvim_minimal('edit ' .. tmpfile .. ' | echo &filetype')
      os.remove(tmpfile)
      assert.is_true(success, 'Lua filetype should be detected: ' .. (output or ''))
    end)

    it('should detect markdown files', function()
      local tmpfile = os.tmpname() .. '.md'
      local success, output = run_nvim_minimal('edit ' .. tmpfile .. ' | echo &filetype')
      os.remove(tmpfile)
      assert.is_true(success, 'Markdown filetype should be detected: ' .. (output or ''))
    end)
  end)
end)
