-- Keymap integration tests
require('tests.mock_nixcats').setup()

local function check_keymap_exists(mode, lhs)
  if not _G._test_keymaps then
    return false
  end
  return _G._test_keymaps[mode .. ':' .. lhs] ~= nil
end

local function has_keymaps_with_prefix(mode, prefix)
  if not _G._test_keymaps then
    return false
  end
  for key, _ in pairs(_G._test_keymaps) do
    local map_mode, map_lhs = key:match '^([^:]+):(.+)$'
    if map_mode == mode and map_lhs:match('^' .. prefix) then
      return true
    end
  end
  return false
end

describe('Keymap Integration Tests', function()
  before_each(function()
    -- Clear any existing keymaps
    _G._test_keymaps = {}
  end)

  describe('Leader Key', function()
    it('should have leader key configured', function()
      assert.is_equal(' ', vim.g.mapleader)
    end)

    it('should load keymap modules', function()
      local success, err = pcall(require, 'nvim.keymaps')
      assert.is_true(success, 'Keymap modules should load: ' .. tostring(err or ''))
    end)
  end)

  describe('Core Navigation Keymaps', function()
    before_each(function()
      -- Clear require cache to ensure fresh load
      package.loaded['nvim.keymaps.keymaps'] = nil

      -- Test if the keymap mock is working
      vim.keymap.set('n', '<test>', 'test')
      print('Test keymap set, _test_keymaps has keys:', _G._test_keymaps and #vim.tbl_keys(_G._test_keymaps) or 0)

      -- Load keymaps
      local success, err = pcall(require, 'nvim.keymaps.keymaps')
      if not success then
        print('Error loading keymaps.keymaps:', err)
      else
        print 'Successfully loaded keymaps.keymaps'
      end
      print('After loading keymaps, _test_keymaps has keys:', _G._test_keymaps and #vim.tbl_keys(_G._test_keymaps) or 0)
    end)

    it('should have window navigation keymaps', function()
      -- Check for Ctrl+h window navigation
      local exists = check_keymap_exists('n', '<C-h>')
      if not exists then
        -- Debug: print what keymaps are actually set
        print 'Available keymaps (first 10):'
        if _G._test_keymaps then
          local count = 0
          for k, v in pairs(_G._test_keymaps) do
            print('  ' .. k)
            count = count + 1
            if count >= 10 then
              break
            end
          end
        else
          print '  No keymaps found'
        end
      end
      assert.is_true(exists, 'Ctrl+h window navigation should exist')
    end)

    it('should have buffer navigation keymaps', function()
      -- Check for buffer next/prev keymaps (core keymaps)
      local has_prev = check_keymap_exists('n', '[b')
      local has_next = check_keymap_exists('n', ']b')
      assert.is_true(has_prev and has_next, 'Buffer navigation maps should exist')
    end)

    it('should have tab navigation keymaps', function()
      local has_prev = check_keymap_exists('n', '[t')
      local has_next = check_keymap_exists('n', ']t')
      assert.is_true(has_prev and has_next, 'Tab navigation maps should exist')
    end)
  end)

  describe('LSP Keymaps', function()
    before_each(function()
      -- Clear require cache to ensure fresh load
      package.loaded['nvim.keymaps.keymaps-plugins'] = nil
      -- Load plugin keymaps
      require 'nvim.keymaps.keymaps-plugins'
    end)

    it('should have LSP action keymaps configured', function()
      local has_lsp_maps = has_keymaps_with_prefix('n', '<leader>l')
      assert.is_true(has_lsp_maps, 'LSP keymaps should exist')
    end)

    it('should have goto definition keymap', function()
      local exists = check_keymap_exists('n', 'gd')
      assert.is_true(exists, 'Goto definition keymap should exist')
    end)

    it('should have hover functionality available', function()
      -- K is default LSP behavior, check that LSP buf functions are available
      assert.is_not_nil(vim.lsp.buf, 'LSP buffer functions should be available')
    end)
  end)

  describe('Plugin Specific Keymaps', function()
    before_each(function()
      -- Clear require cache to ensure fresh load
      package.loaded['nvim.keymaps.keymaps'] = nil
      package.loaded['nvim.keymaps.keymaps-snacks'] = nil
      -- Load all keymap modules
      require 'nvim.keymaps.keymaps'
      require 'nvim.keymaps.keymaps-snacks'
    end)

    it('should have file explorer keymaps', function()
      -- Oil keymap is set via lze, so test if the module loads
      local success = pcall(require, 'nvim.ui.oil')
      assert.is_true(success, 'File explorer configuration should exist')
    end)

    it('should have which-key toggle', function()
      -- Check if which-key configuration exists
      local success = pcall(require, 'nvim.keymaps.whichkey')
      assert.is_true(success, 'Which-key configuration should exist')
    end)

    it('should have git keymaps', function()
      local has_git_maps = has_keymaps_with_prefix('n', '<leader>g')
      assert.is_true(has_git_maps, 'Git keymaps should exist')
    end)

    it('should have search/picker keymaps', function()
      local has_search_maps = has_keymaps_with_prefix('n', '<leader>f') or has_keymaps_with_prefix('n', '<leader>s')
      assert.is_true(has_search_maps, 'Search/picker keymaps should exist')
    end)
  end)

  describe('AI and Special Feature Keymaps', function()
    before_each(function()
      -- Clear require cache to ensure fresh load
      package.loaded['nvim.keymaps.keymaps'] = nil
      package.loaded['nvim.keymaps.keymaps-plugins'] = nil
      -- Load relevant keymap modules
      require 'nvim.keymaps.keymaps'
      require 'nvim.keymaps.keymaps-plugins'
    end)

    it('should have AI/Copilot keymaps', function()
      -- Check for Copilot Chat keymap
      local has_copilot_chat = check_keymap_exists('n', '<C-g>')
      assert.is_true(has_copilot_chat, 'Copilot Chat keymap should exist')
    end)

    it('should have diagnostic keymaps', function()
      -- Check for diagnostic keymaps from LSP
      local has_diag_float = check_keymap_exists('n', '<leader>le')
      local has_diag_next = check_keymap_exists('n', ']d')
      assert.is_true(has_diag_float and has_diag_next, 'Diagnostic keymaps should exist')
    end)

    it('should have zen mode configuration', function()
      -- Zen mode keymaps are set via lze, so test if the module loads
      local success = pcall(require, 'nvim.ui.zen')
      assert.is_true(success, 'Zen mode configuration should exist')
    end)
  end)

  describe('Keymap Functionality', function()
    it('should have escape sequences properly configured', function()
      local success, err = pcall(require, 'nvim.keymaps.keymaps')
      assert.is_true(success, 'Core keymaps should load without errors: ' .. tostring(err or ''))
    end)

    it('should have plugin keymaps properly configured', function()
      local success, err = pcall(require, 'nvim.keymaps.keymaps-plugins')
      assert.is_true(success, 'Plugin keymaps should load without errors: ' .. tostring(err or ''))
    end)

    it('should have snacks keymaps properly configured', function()
      local success, err = pcall(require, 'nvim.keymaps.keymaps-snacks')
      assert.is_true(success, 'Snacks keymaps should load without errors: ' .. tostring(err or ''))
    end)
  end)
end)
