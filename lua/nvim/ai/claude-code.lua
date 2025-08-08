require('lze').load {
  {
    'claude-code-nvim',
    cmd = { 'ClaudeChat', 'ClaudeCode', 'ClaudeCancel', 'ClaudeImplement' },
    keys = {
      { '<leader>cc', '<cmd>ClaudeChat<cr>', desc = 'Open Claude chat' },
      { '<leader>ci', '<cmd>ClaudeImplement<cr>', desc = 'Claude implement' },
      { '<leader>cx', '<cmd>ClaudeCancel<cr>', desc = 'Cancel Claude request' },
      { '<leader>cc', '<cmd>ClaudeCode<cr>', mode = 'v', desc = 'Claude code with selection' },
    },
    after = function(_)
      require('claude-code').setup {
        max_tokens = 8192,
        accept_keymap = '<Tab>',
        cancel_keymap = '<C-c>',
      }
    end,
  },
}
