require('lze').load {
  {
    'claude.vim',
    cmd = {
      'Claude',
      'ClaudeChat',
      'ClaudeAsk',
      'ClaudeImplement',
      'ClaudeReview',
      'ClaudeGenerate',
    },
    keys = {
      { '<leader>cc', '<cmd>ClaudeChat<cr>', desc = 'Claude Chat' },
      { '<leader>ca', '<cmd>ClaudeAsk<cr>', desc = 'Claude Ask', mode = { 'n', 'v' } },
      { '<leader>ci', '<cmd>ClaudeImplement<cr>', desc = 'Claude Implement', mode = { 'n', 'v' } },
      { '<leader>cr', '<cmd>ClaudeReview<cr>', desc = 'Claude Review', mode = { 'n', 'v' } },
      { '<leader>cg', '<cmd>ClaudeGenerate<cr>', desc = 'Claude Generate', mode = { 'n', 'v' } },
    },
    after = function(_)
      -- Claude.vim configuration
      -- Set API key (try NVIM_ANTHROPIC_API_KEY first, fallback to ANTHROPIC_API_KEY)
      local api_key = vim.env.NVIM_ANTHROPIC_API_KEY or vim.env.ANTHROPIC_API_KEY
      if api_key then
        vim.g.claude_api_key = api_key
      end

      -- Set default model to Claude 4 Sonnet
      vim.g.claude_model = 'claude-sonnet-4-20250514'

      -- Enable syntax highlighting for Claude responses
      vim.g.claude_syntax_highlight = 1

      -- Set response window height (optional)
      vim.g.claude_window_height = 20

      -- Auto-close response window after applying changes (optional)
      vim.g.claude_auto_close = 0
    end,
  },
}
