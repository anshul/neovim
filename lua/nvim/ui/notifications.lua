require('lze').load {
  {
    'nvim-notify',
    -- event = { 'DeferredUIEnter' },
    after = function(_)
      local notify = require 'notify'
      notify.setup {
        level = 'info',
        background_color = '#191724',
      }

      local default_timeout = notify._config.timeout or 5000
      local original_notify = vim.notify

      local function map_level(l)
        if type(l) == 'string' then
          return vim.log.levels[string.upper(l)]
        end
        return l
      end

      vim.notify = function(msg, level, opts)
        opts = opts or {}
        if map_level(level) == vim.log.levels.ERROR then
          opts.timeout = (opts.timeout or default_timeout) * 2

          local dir = vim.fn.expand '~/.config/state/nvim'
          vim.fn.mkdir(dir, 'p')
          local file = dir .. '/errors.log'
          local f = io.open(file, 'a')
          if f then
            f:write(os.date '%Y-%m-%d %H:%M:%S' .. ' ' .. msg .. '\n')
            f:close()
          end
        end

        return original_notify(msg, level, opts)
      end
    end,
  },
  {
    'noice.nvim',
    -- Comment this out because lualine uses noice at startup
    event = { 'DeferredUIEnter' },
    load = function(name)
      require('lzextras').loaders.multi {
        name,
        'nui.nvim',
        'nvim-notify',
      }
    end,
    after = function(_)
      require('noice').setup {
        lsp = {
          progress = { enabled = true },
          hover = { enabled = true },
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = false,
          lsp_doc_border = true,
          inc_rename = true,
        },
        notify = { enabled = true },
        messages = { enabled = true },
      }
    end,
  },
}

-- NOTE: Disable deprecation warnings for vim.tbl_islist
local original_deprecate = vim.deprecate

vim.deprecate = function(msg, ...)
  if msg:find 'vim.tbl_islist' then
    return
  end
  original_deprecate(msg, ...)
end
