-- Clipboard settings
vim.opt.clipboard = { 'unnamedplus' }

-- General Neovim options
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.cmdheight = 1
vim.opt.conceallevel = 0
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.title = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = 'cursor'
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.guifont = 'Maple Mono NF:h13'
vim.opt.listchars = { tab = '󰌒 ', trail = '•', nbsp = '␣' }
vim.opt.list = true
vim.opt.showbreak = '↪ '
vim.opt.foldnestmax = 20
vim.opt.foldminlines = 2
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.o.foldenable = true
vim.o.foldcolumn = '0'
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,stl:─]]

-- Always show tabline
vim.o.showtabline = 2
-- Save and restore tabpages
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Kitty terminal integration
if vim.env.TERM == 'xterm-kitty' then
  -- Disable background color erase for kitty
  vim.cmd [[let &t_ut='']]

  -- Handle cursor colors properly
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      -- Reset terminal colors on enter
      io.stdout:write '\027]10;#ffffff\007\027]11;#000000\007'
    end,
  })

  vim.api.nvim_create_autocmd('VimLeave', {
    callback = function()
      -- Restore terminal colors on exit
      io.stdout:write '\027]110\007\027]111\007'
    end,
  })
end

-- Scrollback-specific settings for kitty integration
if vim.env.KITTY_SCROLLBACK_NVIM == 'true' then
  -- Disable unnecessary features for scrollback mode
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.signcolumn = 'no'
  vim.opt.laststatus = 0

  -- Search-friendly settings
  vim.opt.hlsearch = true
  vim.opt.incsearch = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  -- Quick exit mapping for scrollback mode
  vim.keymap.set('n', 'q', '<cmd>qa!<cr>', { silent = true, desc = 'Quick exit scrollback' })

  -- Prevent paste issues in scrollback mode
  vim.api.nvim_create_autocmd('TermEnter', {
    pattern = '*',
    callback = function()
      vim.cmd 'stopinsert'
    end,
  })

  -- Disable conflicting plugins in scrollback mode
  local disable_plugins = {
    'auto-save.nvim',
    'auto-session',
    'neovim-session-manager',
    'bufferline.nvim',
  }

  for _, plugin in ipairs(disable_plugins) do
    vim.g['loaded_' .. plugin:gsub('%.nvim', ''):gsub('-', '_')] = 1
  end
end
