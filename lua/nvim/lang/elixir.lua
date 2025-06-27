-- Exit early if Elixir is not available
if vim.fn.executable 'elixir' == 0 then
  return
end

require('lze').load {
  {
    'elixir-tools.nvim',
    ft = { 'elixir', 'eelixir', 'heex', 'surface' },
    after = function()
      require('elixir').setup {
        nextls = { enable = false },
        elixirls = { enable = false },
        projectionist = { enable = true },
        credo = { enable = true },
      }
    end,
  },
  {
    'neotest-elixir',
    dependencies = { 'nvim-neotest/neotest' },
    ft = { 'elixir' },
    after = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-elixir' {
            mix_task = 'test',
            post_process_command = function(cmd)
              return vim.tbl_flatten { 'env', 'MIX_ENV=test', cmd }
            end,
          },
        },
      }
    end,
  },
  {
    'vim-endwise',
    ft = { 'elixir', 'ruby' },
  },
}

-- Elixir-specific settings and autocommands
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'elixir', 'eelixir', 'heex', 'surface' },
  callback = function()
    -- Set up Elixir-specific options
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true

    -- Enable spell checking for comments and strings
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'

    -- Set up better folding for Elixir
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt_local.foldlevel = 99

    -- Elixir-specific keymaps
    local opts = { buffer = true, silent = true }

    -- Quick test running
    vim.keymap.set('n', '<leader>tt', '<cmd>lua require("neotest").run.run()<cr>', vim.tbl_extend('force', opts, { desc = 'Run nearest test' }))
    vim.keymap.set('n', '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', vim.tbl_extend('force', opts, { desc = 'Run file tests' }))
    vim.keymap.set('n', '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>', vim.tbl_extend('force', opts, { desc = 'Toggle test summary' }))

    -- Mix commands
    vim.keymap.set('n', '<leader>mc', '<cmd>terminal mix compile<cr>', vim.tbl_extend('force', opts, { desc = 'Mix compile' }))
    vim.keymap.set('n', '<leader>mt', '<cmd>terminal mix test<cr>', vim.tbl_extend('force', opts, { desc = 'Mix test' }))
    vim.keymap.set('n', '<leader>md', '<cmd>terminal mix deps.get<cr>', vim.tbl_extend('force', opts, { desc = 'Mix deps.get' }))
    vim.keymap.set('n', '<leader>mf', '<cmd>terminal mix format<cr>', vim.tbl_extend('force', opts, { desc = 'Mix format' }))
  end,
})
