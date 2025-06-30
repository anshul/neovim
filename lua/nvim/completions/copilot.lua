require('lze').load {
  {
    'copilot.lua',
    event = 'InsertEnter',
    cmd = 'Copilot',
    after = function(_)
      require('copilot').setup {
        panel = { enabled = false },
        copilot_model = 'gpt-4.1',
        suggestion = {
          enabled = false,
          auto_trigger = false,
          hide_during_completion = true,
          keymap = {
            accept = false,
            accept_word = false,
            next = false,
            prev = false,
          },
        },
        filetypes = {
          gitrebase = true,
          ['grug-far'] = false,
          ['grug-far-history'] = false,
          ['grug-far-help'] = false,
          ['.'] = false,
          [''] = false,
          ['chatgpt-input'] = false,
          oil = false,
          minifiles = false,
          markdown = true,
          yaml = true,
          gitcommit = true,
        },
      }
    end,
  },
}
