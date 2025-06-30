-- Mock nixCats environment for testing
-- This provides stubs for lze, lzextras, and other nixCats-specific modules

local M = {}

-- Mock vim if not available
if not vim then
  _G.vim = {
    g = {
      mapleader = ' ',
      maplocalleader = ' ',
    },
    o = {
      termguicolors = true,
      tabstop = 2,
      shiftwidth = 2,
      expandtab = true,
      clipboard = 'unnamedplus',
    },
    opt = setmetatable({}, {
      __index = function(_, key)
        return {
          append = function() end,
        }
      end,
      __newindex = function() end,
    }),
    opt_local = setmetatable({}, {
      __index = function()
        return {}
      end,
      __newindex = function() end,
    }),
    api = {
      nvim_create_augroup = function()
        return 1
      end,
      nvim_create_autocmd = function() end,
      nvim_buf_line_count = function()
        return 100
      end,
      nvim_get_current_win = function()
        return 1
      end,
      nvim_win_get_config = function()
        return { relative = '' }
      end,
      nvim_set_option_value = function() end,
      nvim_get_keymap = function()
        return {}
      end,
    },
    keymap = {
      set = function(mode, lhs, rhs, opts)
        -- Store keymaps for testing
        if not _G._test_keymaps then
          _G._test_keymaps = {}
        end
        _G._test_keymaps[mode .. ':' .. lhs] = { rhs = rhs, opts = opts or {} }
      end,
    },
    cmd = function() end,
    notify = function() end,
    log = {
      levels = {
        INFO = 1,
        DEBUG = 0,
      },
    },
    b = {},
    fn = {
      expand = function()
        return ''
      end,
      mapcheck = function()
        return ''
      end,
    },
    fs = {
      dirname = function()
        return ''
      end,
      find = function()
        return {}
      end,
    },
    lsp = {
      get_clients = function()
        return {}
      end,
      buf = {
        hover = function() end,
        definition = function() end,
        references = function() end,
      },
    },
    diagnostic = {
      config = function() end,
    },
    tbl_extend = function(behavior, ...)
      local result = {}
      for _, t in ipairs { ... } do
        for k, v in pairs(t) do
          result[k] = v
        end
      end
      return result
    end,
    tbl_keys = function(t)
      local keys = {}
      for k, _ in pairs(t) do
        table.insert(keys, k)
      end
      return keys
    end,
  }
end

-- Ensure vim.lsp and vim.diagnostic are available even if vim exists
if vim and not vim.lsp then
  vim.lsp = {
    get_clients = function()
      return {}
    end,
    buf = {
      hover = function() end,
      definition = function() end,
      references = function() end,
    },
  }
elseif vim and vim.lsp and not vim.lsp.buf then
  vim.lsp.buf = {
    hover = function() end,
    definition = function() end,
    references = function() end,
  }
end

if vim and not vim.diagnostic then
  vim.diagnostic = {
    config = function() end,
  }
end

if vim and not vim.tbl_extend then
  vim.tbl_extend = function(behavior, ...)
    local result = {}
    for _, t in ipairs { ... } do
      for k, v in pairs(t) do
        result[k] = v
      end
    end
    return result
  end
end

if vim and not vim.tbl_keys then
  vim.tbl_keys = function(t)
    local keys = {}
    for k, _ in pairs(t) do
      table.insert(keys, k)
    end
    return keys
  end
end

-- Mock lze (lazy loading)
local function mock_lze()
  return {
    load = function(specs)
      -- Just validate the spec structure without actually loading
      if type(specs) == 'table' then
        for _, spec in ipairs(specs) do
          if type(spec) == 'table' and spec.after then
            -- Call after function to test setup
            if type(spec.after) == 'function' then
              spec.after()
            end
          end
        end
      end
    end,
  }
end

-- Mock lzextras
local function mock_lzextras()
  return {
    loaders = {
      multi = function() end,
    },
  }
end

-- Mock snacks
local function mock_snacks()
  return {
    picker = {
      git_files = function() end,
      grep = function() end,
      files = function() end,
      todo_comments = function() end,
    },
    git = {
      get_root = function()
        return '/mock/git/root'
      end,
    },
    bufdelete = function() end,
  }
end

-- Mock plugin modules
local plugin_mocks = {
  ['blink.cmp'] = { setup = function() end },
  ['catppuccin'] = { setup = function() end },
  ['gitsigns'] = { setup = function() end },
  ['CopilotChat'] = { setup = function() end },
  ['copilot'] = { setup = function() end },
  ['neogen'] = { setup = function() end, generate = function() end },
  ['which-key'] = {
    setup = function() end,
    add = function() end,
    show = function() end,
  },
  ['lualine'] = { setup = function() end },
  ['nvim-treesitter.configs'] = { setup = function() end },
  ['nvim-lspconfig'] = {
    lua_ls = { setup = function() end },
    rust_analyzer = { setup = function() end },
    ts_ls = { setup = function() end },
  },
  ['conform'] = {
    setup = function() end,
    format = function() end,
  },
  ['lint'] = {
    setup = function() end,
  },
  ['lspsaga'] = { setup = function() end },
  ['inc_rename'] = { setup = function() end },
  ['nvim-treesitter'] = { setup = function() end },
  ['telescope'] = { setup = function() end },
  ['avante'] = { setup = function() end },
  ['mini.files'] = { setup = function() end },
  snacks = mock_snacks(),
}

-- Override require for nixCats-specific modules
local original_require = require
function _G.require(modname)
  -- Mock nixCats modules
  if modname == 'lze' then
    return mock_lze()
  elseif modname == 'lzextras' then
    return mock_lzextras()
  elseif modname == 'snacks' then
    return mock_snacks()
  elseif plugin_mocks[modname] then
    return plugin_mocks[modname]
  else
    -- Try original require, catch errors gracefully
    local success, result = pcall(original_require, modname)
    if success then
      return result
    else
      -- Return empty table for missing modules
      return {}
    end
  end
end

M.setup = function()
  -- Additional setup if needed
end

-- Helper function to check if a keymap exists
M.keymap_exists = function(mode, lhs)
  if not _G._test_keymaps then
    return false
  end
  return _G._test_keymaps[mode .. ':' .. lhs] ~= nil
end

-- Helper function to simulate vim.fn.mapcheck
M.mapcheck = function(lhs, mode)
  mode = mode or 'n'
  if M.keymap_exists(mode, lhs) then
    return 'mapped'
  end
  return ''
end

-- Add mapcheck to vim.fn
if _G.vim and _G.vim.fn then
  _G.vim.fn.mapcheck = M.mapcheck
elseif _G.vim then
  _G.vim.fn = { mapcheck = M.mapcheck }
end

return M
