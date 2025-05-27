-- Keymap integration tests

local function run_nvim_with_config(cmd, timeout)
  timeout = timeout or 10
  local handle = io.popen('timeout ' .. timeout .. ' nvim --headless -c "' .. cmd .. '" -c "qa!" 2>&1')
  local result = handle:read '*a'
  local success = handle:close()
  return success, result
end

local function check_keymap_exists(mode, lhs)
  local cmd = 'lua local maps = vim.api.nvim_get_keymap("'
    .. mode
    .. '"); for _, map in ipairs(maps) do if map.lhs == "'
    .. lhs
    .. '" then print("KEYMAP_EXISTS") return end end print("KEYMAP_MISSING")'
  local success, output = run_nvim_with_config(cmd)
  return success and output:match 'KEYMAP_EXISTS'
end

describe('Keymap Integration Tests', function()
  describe('Leader Key', function()
    it('should have leader key configured', function()
      local cmd = 'lua print(vim.g.mapleader and "LEADER_" .. vim.g.mapleader or "NO_LEADER")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'LEADER_', 'Leader key should be configured: ' .. (output or ''))
    end)

    it('should load keymap modules', function()
      local success, output = run_nvim_with_config 'lua require("nvim.keymaps")'
      assert.is_true(success, 'Keymap modules should load: ' .. (output or ''))
    end)
  end)

  describe('Core Navigation Keymaps', function()
    it('should have window navigation keymaps', function()
      -- Check for Ctrl+h window navigation
      local exists = check_keymap_exists('n', '<C-h>')
      assert.is_true(exists, 'Ctrl+h window navigation should exist')
    end)

    it('should have buffer navigation keymaps', function()
      -- Check for buffer next/prev
      local cmd =
        'lua local maps = vim.api.nvim_get_keymap("n"); for _, map in ipairs(maps) do if map.lhs:find("^<[Ll]eader>b") then print("BUFFER_MAPS") return end end print("NO_BUFFER_MAPS")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'BUFFER_MAPS', 'Buffer navigation maps should exist')
    end)

    it('should have tab navigation keymaps', function()
      local cmd =
        'lua local maps = vim.api.nvim_get_keymap("n"); for _, map in ipairs(maps) do if map.lhs:find("^<[Ll]eader>t") then print("TAB_MAPS") return end end print("NO_TAB_MAPS")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'TAB_MAPS', 'Tab navigation maps should exist')
    end)
  end)

  describe('LSP Keymaps', function()
    it('should have LSP action keymaps configured', function()
      local cmd =
        'lua local maps = vim.api.nvim_get_keymap("n"); for _, map in ipairs(maps) do if map.lhs:find("^<[Ll]eader>l") then print("LSP_MAPS") return end end print("NO_LSP_MAPS")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'LSP_MAPS', 'LSP keymaps should exist')
    end)

    it('should have goto definition keymap', function()
      local exists = check_keymap_exists('n', 'gd')
      assert.is_true(exists, 'Goto definition keymap should exist')
    end)

    it('should have hover keymap', function()
      local exists = check_keymap_exists('n', 'K')
      assert.is_true(exists, 'Hover keymap should exist')
    end)
  end)

  describe('Plugin Specific Keymaps', function()
    it('should have file explorer keymaps', function()
      local exists = check_keymap_exists('n', '-')
      assert.is_true(exists, 'File explorer keymap should exist')
    end)

    it('should have which-key toggle', function()
      local cmd =
        'lua local maps = vim.api.nvim_get_keymap("n"); for _, map in ipairs(maps) do if map.lhs:find("^<[Ll]eader>%?") then print("WHICHKEY_MAP") return end end print("NO_WHICHKEY_MAP")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'WHICHKEY_MAP', 'Which-key toggle should exist')
    end)

    it('should have git keymaps', function()
      local cmd =
        'lua local maps = vim.api.nvim_get_keymap("n"); for _, map in ipairs(maps) do if map.lhs:find("^<[Ll]eader>g") then print("GIT_MAPS") return end end print("NO_GIT_MAPS")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'GIT_MAPS', 'Git keymaps should exist')
    end)

    it('should have search/picker keymaps', function()
      local cmd =
        'lua local maps = vim.api.nvim_get_keymap("n"); for _, map in ipairs(maps) do if map.lhs:find("^<[Ll]eader>f") or map.lhs:find("^<[Ll]eader>s") then print("SEARCH_MAPS") return end end print("NO_SEARCH_MAPS")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'SEARCH_MAPS', 'Search/picker keymaps should exist')
    end)
  end)

  describe('AI and Special Feature Keymaps', function()
    it('should have AI/Avante keymaps', function()
      local cmd =
        'lua local maps = vim.api.nvim_get_keymap("n"); for _, map in ipairs(maps) do if map.lhs:find("^<[Ll]eader>a") then print("AI_MAPS") return end end print("NO_AI_MAPS")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'AI_MAPS', 'AI keymaps should exist')
    end)

    it('should have diagnostic keymaps', function()
      local cmd =
        'lua local maps = vim.api.nvim_get_keymap("n"); for _, map in ipairs(maps) do if map.lhs:find("^<[Ll]eader>c") then print("DIAG_MAPS") return end end print("NO_DIAG_MAPS")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'DIAG_MAPS', 'Diagnostic keymaps should exist')
    end)

    it('should have zen mode keymaps', function()
      local cmd =
        'lua local maps = vim.api.nvim_get_keymap("n"); for _, map in ipairs(maps) do if map.lhs:find("^<[Ll]eader>z") then print("ZEN_MAPS") return end end print("NO_ZEN_MAPS")'
      local success, output = run_nvim_with_config(cmd)
      assert.is_true(success and output:match 'ZEN_MAPS', 'Zen mode keymaps should exist')
    end)
  end)

  describe('Keymap Functionality', function()
    it('should have escape sequences properly configured', function()
      local success, output = run_nvim_with_config 'lua require("nvim.keymaps.keymaps")'
      assert.is_true(success, 'Core keymaps should load without errors: ' .. (output or ''))
    end)

    it('should have plugin keymaps properly configured', function()
      local success, output = run_nvim_with_config 'lua require("nvim.keymaps.keymaps-plugins")'
      assert.is_true(success, 'Plugin keymaps should load without errors: ' .. (output or ''))
    end)

    it('should have snacks keymaps properly configured', function()
      local success, output = run_nvim_with_config 'lua require("nvim.keymaps.keymaps-snacks")'
      assert.is_true(success, 'Snacks keymaps should load without errors: ' .. (output or ''))
    end)
  end)
end)
