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
          require 'neotest-elixir',
        },
      }
    end,
  },
  {
    'vim-endwise',
    ft = { 'elixir', 'ruby' },
  },
}
