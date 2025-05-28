require 'nvim.options'

-- Initialize debug logs
local function init_debug_logs()
  local state_path = vim.fn.stdpath 'state'
  local snacks_log = state_path .. '/snacks.log'
  local notifications_log = state_path .. '/notifications.log'
  local debug_value = vim.env.NVIM_DEBUG_NOTIFY or '0'
  local timestamp = os.date '%Y-%m-%d %H:%M:%S'

  local session_msg = string.format('[%s] SESSION_START: NVIM_DEBUG_NOTIFY=%s\n', timestamp, debug_value)

  -- Create/append to both log files
  for _, log_file in ipairs { snacks_log, notifications_log } do
    local file = io.open(log_file, 'a')
    if file then
      file:write(session_msg)
      file:close()
    end
  end
end

init_debug_logs()

-- NOTE: Register another one from lzextras. This one makes it so that
-- you can set up lsps within lze specs,
-- and trigger lspconfig setup hooks only on the correct filetypes
require('lze').register_handlers(require('lzextras').lsp)

require 'nvim.themes'
require 'nvim.lsps'
require 'nvim.completions'
require 'nvim.treesitter'
require 'nvim.plugins'
require 'nvim.ui'
require 'nvim.bars'
require 'nvim.git'
require 'nvim.ai'
require 'nvim.literate'
require 'nvim.misc'
require 'nvim.debug'

require 'nvim.keymaps'
require 'nvim.autocmds'
