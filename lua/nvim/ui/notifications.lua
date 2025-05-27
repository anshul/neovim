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

      -- Log all notifications to file
      local log_file = vim.fn.stdpath 'state' .. '/notify.log'
      local original_notify = notify

      vim.notify = function(msg, level, opts)
        level = level or vim.log.levels.INFO
        opts = opts or {}

        -- Write to log file
        local timestamp = os.date '%Y-%m-%d %H:%M:%S'
        local level_name = ({
          [vim.log.levels.DEBUG] = 'DEBUG',
          [vim.log.levels.INFO] = 'INFO',
          [vim.log.levels.WARN] = 'WARN',
          [vim.log.levels.ERROR] = 'ERROR',
        })[level] or 'UNKNOWN'

        local log_entry = string.format('[%s] %s: %s\n', timestamp, level_name, msg)
        local file = io.open(log_file, 'a')
        if file then
          file:write(log_entry)
          file:close()
        end

        -- Call original notify
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
