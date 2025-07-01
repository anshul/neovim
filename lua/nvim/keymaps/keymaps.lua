-- Helper function for key mappings
local function map(mode, key, action, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, key, action, options)
end

-- Disable Space (noop)
map('n', '<Space>', '<Nop>')

-- -- Paste keymaps (HACK: Avoid being overwritten)
-- map('n', 'p', 'p')
-- map('n', 'P', 'P')

-- Window splitting
map('n', '<Leader>wv', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
map('n', '<Leader>ws', '<cmd>split<CR>', { desc = 'Horizontal split' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to the window on the left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to the window below' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to the window above' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to the window on the right' })

-- Set/unset options
map('n', '<Leader>uw', '<cmd>set wrap!<CR>', { desc = 'Toggle wrap' })
map('n', '<Leader>us', '<cmd>set spell!<CR>', { desc = 'Toggle spell check' })

-- Tab navigation
map('n', '[t', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })
map('n', ']t', '<cmd>tabnext<CR>', { desc = 'Next tab' })

-- Resize window with Ctrl + arrow keys
map('n', '<C-Up>', '<cmd>resize +4<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -4<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize +4<CR>', { desc = 'Increase window width' })
map('n', '<C-Right>', '<cmd>vertical resize -4<CR>', { desc = 'Decrease window width' })
map('n', '<Leader>w=', '<cmd>tabdo wincmd =<CR>', { desc = 'Window auto resize' })

-- Navigate buffers
map('n', '[b', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', ']b', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<M-Left>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<M-Right>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<D-Left>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<D-Right>', '<cmd>bnext<CR>', { desc = 'Next buffer' })

-- Tab management
map('n', '<C-t>', '<cmd>tabnew<CR>', { desc = 'New tab' })

-- Turn off search highlight
-- Notes and utilities
map('n', '<C-n>', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Open notes' })
map('n', '<C-o>', '<cmd>lua Snacks.picker.files()<cr>', { desc = 'File finder' })
map('n', '<C-p>', '<cmd>lua Snacks.picker.git_files({untracked=true})<cr>', { desc = 'Git finder' })
map('n', '<C-f>', '<cmd>lua Snacks.picker.grep()<cr>', { desc = 'Grep search' })
map('n', '<C-b>', '<cmd>lua Snacks.picker.buffers()<cr>', { desc = 'Buffer finder' })
map('n', '<C-d>', "<cmd>lua require('snacks').bufdelete()<CR>", { desc = 'Close buffer' })
map('n', '<D-d>', "<cmd>lua require('snacks').bufdelete()<CR>", { desc = 'Close buffer' })
map('n', '<C-x>', '<cmd>Trouble diagnostics toggle focus=true<cr>', { desc = 'Diagnostics list' })
map('n', '<C-g>', '<cmd>CopilotChatToggle<cr>', { desc = 'Copilot Chat' })
map('i', '<D-r>', function()
  local copilot = require 'copilot.suggestion'
  if copilot.is_visible() then
    copilot.next()
  else
    copilot.trigger()
  end
end, { desc = 'Trigger/cycle Copilot suggestion' })

-- Save files
map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })

-- Close buffers, windows and tabs
map('n', '<Leader>qb', "<cmd>lua require('snacks').bufdelete()<CR>", { desc = 'Delete buffer' })
map('n', '<Leader>qB', "<cmd>lua require('snacks').bufdelete.all()<CR>", { desc = 'Delete all buffers' })
map('n', '<Leader>qw', '<cmd>q<CR>', { desc = 'Close window' })
map('n', '<Leader>qt', '<cmd>tabclose<CR>', { desc = 'Close tab' })
map('n', '<Leader>qa', '<cmd>qa<CR>', { desc = 'Close all and quit' })

-- Stay in visual mode while indenting
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })

-- Macros
map('n', 'Q', '@qj', { desc = 'Run q macro' })
map('x', 'Q', ':norm @q<CR>', { desc = 'Run q macro' })

-- Clipboard behavior - yank to system clipboard, delete to black hole
map('n', 'y', '"+y', { desc = 'Yank to system clipboard' })
map('v', 'y', '"+y', { desc = 'Yank to system clipboard' })
map('n', 'Y', '"+Y', { desc = 'Yank line to system clipboard' })
map('n', 'p', '"+p', { desc = 'Paste from system clipboard' })
map('n', 'P', '"+P', { desc = 'Paste before from system clipboard' })
map('v', 'p', '"+p', { desc = 'Paste from system clipboard' })

-- Delete operations use black hole register (don't affect clipboard)
map('n', 'd', '"_d', { desc = 'Delete to black hole register' })
map('v', 'd', '"_d', { desc = 'Delete to black hole register' })
map('n', 'D', '"_D', { desc = 'Delete to end of line (black hole)' })
map('n', 'x', '"_x', { desc = 'Delete character (black hole)' })
map('n', 'X', '"_X', { desc = 'Delete character before (black hole)' })
map('n', 'c', '"_c', { desc = 'Change (black hole)' })
map('v', 'c', '"_c', { desc = 'Change (black hole)' })
map('n', 'C', '"_C', { desc = 'Change to end of line (black hole)' })
map('n', 's', '"_s', { desc = 'Substitute character (black hole)' })
map('n', 'S', '"_S', { desc = 'Substitute line (black hole)' })
