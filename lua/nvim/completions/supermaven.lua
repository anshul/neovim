require('lze').load {
  {
    'supermaven-nvim',
    event = 'InsertEnter',
    cmd = { 'SupermavenUsePro', 'SupermavenLogout', 'SupermavenRestart', 'SupermavenStatus', 'SupermavenToggle' },
    after = function(_)
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<Tab>',
          clear_suggestion = '<C-]>',
          accept_word = '<C-k>',
        },
        ignore_filetypes = {
          oil = true,
          minifiles = true,
          ['grug-far'] = true,
          ['grug-far-history'] = true,
          ['grug-far-help'] = true,
          ['.'] = true,
          [''] = true,
          ['chatgpt-input'] = true,
        },
        color = {
          suggestion_color = '#808080',
          cterm = 244,
        },
        log_level = 'info',
        disable_inline_completion = false,
        disable_keymaps = false,
      }
    end,
  },
}
