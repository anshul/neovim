vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  callback = function()
    vim.cmd 'set formatoptions-=cro'
  end,
})

vim.api.nvim_create_autocmd({ 'CmdWinEnter' }, {
  callback = function()
    vim.cmd 'quit'
  end,
})

local auto_resize_group = vim.api.nvim_create_augroup('_auto_resize', { clear = true })
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = auto_resize_group,
  pattern = '*',
  command = [[
          let _auto_resize_current_tab = tabpagenr()
          tabdo wincmd =
          execute 'tabnext' _auto_resize_current_tab
        ]],
})

-- Consolidated FileType autocmds
local filetype_group = vim.api.nvim_create_augroup('_filetype_sane_defaults', { clear = true })

-- Language-specific indentation overrides
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = filetype_group,
  pattern = { 'go' },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = filetype_group,
  pattern = { 'make', 'makefile' },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = filetype_group,
  pattern = {
    'alpha',
    'dashboard',
    'DressingSelect',
    'git',
    'help',
    'Jaq',
    'lir',
    'lspinfo',
    'man',
    'neogitstatus',
    'netrw',
    'notify',
    'oil',
    'qf',
    'spectre_panel',
    'toggleterm',
    'Trouble',
  },
  callback = function()
    -- Quick close with 'q' and remove from buffer list
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
    -- Disable mini-indentscope for helper buffers
    vim.b.miniindentscope_disable = true
  end,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'WinNew' }, {
  callback = function()
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)
    -- Only adjust floating windows (those with a non-empty 'relative' field)
    if config.relative ~= '' then
      vim.api.nvim_set_option_value('winblend', 0, { win = win })
    end
  end,
})

-- Large file performance guard
vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
  callback = function(args)
    local buf = args.buf
    local line_count = vim.api.nvim_buf_line_count(buf)

    if line_count > 5000 then
      -- Disable performance-heavy plugins for large files
      vim.b[buf].large_file = true

      -- Disable illuminate
      vim.b[buf].illuminate_disable = true

      -- Disable indent_blankline
      vim.b[buf].indent_blankline_enabled = false

      -- Disable matchup
      vim.b[buf].matchup_matchparen_enabled = 0

      -- Disable symbol-usage
      vim.b[buf].symbol_usage_disable = true

      -- Disable ufo folding
      vim.b[buf].ufo_disable = true

      vim.notify(string.format('Large file detected (%d lines). Performance optimizations applied.', line_count), vim.log.levels.INFO)
    end
  end,
})
