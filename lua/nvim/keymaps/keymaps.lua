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

-- Default clipboard behavior - use local vim registers
map('n', 'y', 'y', { desc = 'Yank to vim register' })
map('v', 'y', 'y', { desc = 'Yank to vim register' })
map('n', 'Y', 'Y', { desc = 'Yank line to vim register' })

-- Default paste from vim register
map('n', 'p', 'p', { desc = 'Paste from vim register' })
map('n', 'P', 'P', { desc = 'Paste before from vim register' })
map('v', 'p', 'p', { desc = 'Paste from vim register' })

-- Global clipboard operations
map('n', '<D-S-V>', '"+p', { desc = 'Paste from global clipboard' })
map('i', '<D-S-V>', '<C-r>+', { desc = 'Paste from global clipboard' })
map('n', '<C-S-V>', '"+p', { desc = 'Paste from global clipboard' })
map('i', '<C-S-V>', '<C-r>+', { desc = 'Paste from global clipboard' })

map('n', '<C-S-C>', '"+y', { desc = 'Copy to global clipboard' })
map('v', '<C-S-C>', '"+y', { desc = 'Copy to global clipboard' })
map('n', '<D-S-C>', '"+y', { desc = 'Copy to global clipboard' })
map('v', '<D-S-C>', '"+y', { desc = 'Copy to global clipboard' })

-- Delete operations use vim local register (available for pasting)
map('n', 'd', 'd', { desc = 'Delete to vim register' })
map('v', 'd', 'd', { desc = 'Delete to vim register' })
map('n', 'D', 'D', { desc = 'Delete to end of line (vim register)' })
map('n', 'x', 'x', { desc = 'Delete character (vim register)' })
map('n', 'X', 'X', { desc = 'Delete character before (vim register)' })
map('n', 'c', 'c', { desc = 'Change (vim register)' })
map('v', 'c', 'c', { desc = 'Change (vim register)' })
map('n', 'C', 'C', { desc = 'Change to end of line (vim register)' })
map('n', 's', 's', { desc = 'Substitute character (vim register)' })
map('n', 'S', 'S', { desc = 'Substitute line (vim register)' })
