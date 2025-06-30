-- Helper function for key mappings
local function map(mode, key, action, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, key, action, options)
end

-- LSP (keymaps)
map('n', 'gD', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = '[G]oto [D]eclaration' })
map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'Type [D]efinition' })
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Type [D]efinition' })
map('n', '<leader>le', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'LSP diagnostics at cursor' })
map('n', '<leader>la', '<cmd>Lspsaga code_action<cr>', { desc = 'Lspsaga code action' })
map('n', '<leader>lp', '<cmd>Lspsaga peek_definition<cr>', { desc = 'Lspsaga peek definition' })
map('n', '<leader>lf', '<cmd>Lspsaga finder<cr>', { desc = 'Lspsaga finder' })
map('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'LSP info' })
map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = 'next Lspsaga diagnostic' })
map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { desc = 'previous Lspsaga diagnostic' })
map('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', { desc = 'Run code lens' })
map('n', '<leader>lo', '<cmd>Lspsaga outline<cr>', { desc = 'Lspsaga outline' })
map('n', '<leader>lI', '<cmd>Lspsaga incoming_calls<cr>', { desc = 'Lspsaga incoming calls' })
map('n', '<leader>lO', '<cmd>Lspsaga outgoing_calls<cr>', { desc = 'Lspsaga outgoing calls' })
map('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', { desc = 'Lspsaga goto definition' })
-- LSP (rename)
map('n', '<Leader>lr', ':IncRename ', { desc = 'Incremental rename' })
-- LSP (documentation generation)
map('n', '<Leader>lg', "<cmd>lua require('neogen').generate()<CR>", {
  desc = 'Generate documentation (neogen)',
})
-- Getting highlights at cursor
map('n', '<leader>lh', '<cmd>lua vim.notify(vim.inspect(vim.treesitter.get_captures_at_cursor(0)))<CR>', { desc = 'Get highlight at cursor' })

-- CopilotChat keymaps are defined in ai/copilot-chat.lua

-- DAP
map('n', '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = 'DAP toggle breakpoint' })
map('n', '<leader>dc', "<cmd>lua require'dap'.continue()<cr>", { desc = 'DAP continue' })
map('n', '<leader>do', "<cmd>lua require'dapui'.toggle()<cr>", { desc = 'DAP toggle UI' })

-- sessions ([P]ossession)
map('n', '<leader>pl', '<cmd>PossessionLoadCwd<cr>', { desc = 'Possession Load' })
map('n', '<leader>ps', '<cmd>PossessionSave<cr>', { desc = 'Possession Save' })
map('n', '<leader>pr', '<cmd>PossessionRename<cr>', { desc = 'Possession Rename' })
map('n', '<leader>pq', '<cmd>PossessionClose<cr>', { desc = 'Possession Quit' })
map('n', '<leader>pd', '<cmd>PossessionDelete<cr>', { desc = 'Possession Delete' })
map('n', '<leader>pp', '<cmd>PossessionPick<cr>', { desc = 'Possession Pick' })

-- DeepWiki ([W]iki)
map('n', '<leader>ws', function()
  require('deepwiki').search()
end, { desc = 'DeepWiki search' })
map('n', '<leader>wf', function()
  require('deepwiki').fetch()
end, { desc = 'DeepWiki fetch page' })
map('n', '<leader>wa', function()
  require('deepwiki').ask()
end, { desc = 'DeepWiki ask question' })
map('v', '<leader>wa', function()
  require('deepwiki').ask_selection()
end, { desc = 'DeepWiki ask about selection' })
map('n', '<leader>wh', function()
  require('deepwiki').help()
end, { desc = 'DeepWiki help' })
