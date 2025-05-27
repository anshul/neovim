-- Simple tests that verify core functionality

describe('Simple Neovim Config Tests', function()
  describe('File Structure', function()
    it('should have init.lua file', function()
      local file = io.open('./init.lua', 'r')
      assert.is_not_nil(file, 'init.lua should exist')
      if file then
        file:close()
      end
    end)

    it('should have lua directory', function()
      local lfs = require 'lfs'
      local attr = lfs.attributes './lua'
      assert.is_not_nil(attr, 'lua directory should exist')
      assert.is_equal('directory', attr.mode, 'lua should be a directory')
    end)

    it('should have nvim subdirectory', function()
      local lfs = require 'lfs'
      local attr = lfs.attributes './lua/nvim'
      assert.is_not_nil(attr, 'lua/nvim directory should exist')
      assert.is_equal('directory', attr.mode, 'lua/nvim should be a directory')
    end)
  end)

  describe('Basic Lua Syntax', function()
    it('should have valid init.lua syntax', function()
      local chunk, err = loadfile './init.lua'
      assert.is_not_nil(chunk, 'init.lua should have valid syntax: ' .. (err or ''))
    end)

    it('should have valid options.lua syntax', function()
      local chunk, err = loadfile './lua/nvim/options.lua'
      assert.is_not_nil(chunk, 'options.lua should have valid syntax: ' .. (err or ''))
    end)

    it('should have valid main nvim module syntax', function()
      local chunk, err = loadfile './lua/nvim/init.lua'
      assert.is_not_nil(chunk, 'nvim/init.lua should have valid syntax: ' .. (err or ''))
    end)
  end)

  describe('Key Configuration Files', function()
    local config_files = {
      './lua/nvim/options.lua',
      './lua/nvim/keymaps/init.lua',
      './lua/nvim/lsps/init.lua',
      './lua/nvim/themes/init.lua',
      './lua/nvim/treesitter.lua',
    }

    for _, file_path in ipairs(config_files) do
      it('should have valid syntax in ' .. file_path, function()
        local chunk, err = loadfile(file_path)
        assert.is_not_nil(chunk, file_path .. ' should have valid syntax: ' .. (err or ''))
      end)
    end
  end)

  describe('Justfile Commands', function()
    it('should have justfile', function()
      local file = io.open('./justfile', 'r')
      assert.is_not_nil(file, 'justfile should exist')
      if file then
        file:close()
      end
    end)

    it('should have test commands in justfile', function()
      local file = io.open('./justfile', 'r')
      assert.is_not_nil(file, 'justfile should exist')
      if file then
        local content = file:read '*a'
        file:close()
        assert.is_truthy(content:match 'test:', 'justfile should have test command')
        assert.is_truthy(content:match 'test_ci:', 'justfile should have test_ci command')
      end
    end)
  end)

  describe('Package Configuration', function()
    it('should have flake.nix', function()
      local file = io.open('./flake.nix', 'r')
      assert.is_not_nil(file, 'flake.nix should exist')
      if file then
        file:close()
      end
    end)

    it('should have categories.nix', function()
      local file = io.open('./categories.nix', 'r')
      assert.is_not_nil(file, 'categories.nix should exist')
      if file then
        file:close()
      end
    end)

    it('should have packages.nix', function()
      local file = io.open('./packages.nix', 'r')
      assert.is_not_nil(file, 'packages.nix should exist')
      if file then
        file:close()
      end
    end)
  end)
end)
