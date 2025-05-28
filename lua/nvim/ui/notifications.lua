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

      -- Log all notifications to file if NVIM_DEBUG_NOTIFY is set to 1
      if vim.env.NVIM_DEBUG_NOTIFY == '1' then
        local log_file = vim.fn.stdpath 'state' .. '/notify.log'
        local original_notify = notify
        local original_vim_notify = vim.notify

        local function log_notification(msg, level, source)
          level = level or vim.log.levels.INFO
          local timestamp = os.date '%Y-%m-%d %H:%M:%S'
          local level_name = ({
            [vim.log.levels.DEBUG] = 'DEBUG',
            [vim.log.levels.INFO] = 'INFO',
            [vim.log.levels.WARN] = 'WARN',
            [vim.log.levels.ERROR] = 'ERROR',
          })[level] or 'UNKNOWN'

          local log_entry = string.format('[%s] %s [%s]: %s\n', timestamp, level_name, source or 'unknown', msg)
          local file = io.open(log_file, 'a')
          if file then
            file:write(log_entry)
            file:close()
          end
        end

        -- Hook vim.notify
        vim.notify = function(msg, level, opts)
          level = level or vim.log.levels.INFO
          opts = opts or {}
          log_notification(msg, level, 'vim.notify')
          return original_vim_notify(msg, level, opts)
        end

        -- Hook nvim-notify
        local original_notify_fn = notify.notify
        notify.notify = function(msg, level, opts)
          level = level or vim.log.levels.INFO
          opts = opts or {}
          log_notification(msg, level, 'nvim-notify')
          return original_notify_fn(msg, level, opts)
        end

        -- Hook global notification events
        vim.api.nvim_create_autocmd('User', {
          pattern = 'NotifyBackground',
          callback = function(event)
            if event.data and event.data.message then
              log_notification(event.data.message, event.data.level, 'NotifyBackground')
            end
          end,
        })
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
