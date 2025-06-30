require('lze').load {
  {
    'CopilotChat.nvim',
    event = 'DeferredUIEnter',
    keys = {
      { '<leader>cc', '<cmd>CopilotChatToggle<cr>', desc = 'Copilot Chat Toggle' },
      { '<leader>ce', '<cmd>CopilotChatExplain<cr>', desc = 'Copilot Explain', mode = { 'n', 'v' } },
      { '<leader>cr', '<cmd>CopilotChatReview<cr>', desc = 'Copilot Review', mode = { 'n', 'v' } },
      { '<leader>cf', '<cmd>CopilotChatFix<cr>', desc = 'Copilot Fix', mode = { 'n', 'v' } },
      { '<leader>co', '<cmd>CopilotChatOptimize<cr>', desc = 'Copilot Optimize', mode = { 'n', 'v' } },
      { '<leader>cd', '<cmd>CopilotChatDocs<cr>', desc = 'Copilot Docs', mode = { 'n', 'v' } },
      { '<leader>ct', '<cmd>CopilotChatTests<cr>', desc = 'Copilot Tests', mode = { 'n', 'v' } },
      { '<leader>cm', '<cmd>CopilotChatCommit<cr>', desc = 'Copilot Commit', mode = { 'n', 'v' } },
    },
    dep = { 'copilot.lua', 'plenary.nvim' },
    after = function(_)
      require('CopilotChat').setup {
        model = 'gpt-4.1',
        auto_follow_cursor = false,
        show_help = true,
        question_header = '## User ',
        answer_header = '## Copilot ',
        error_header = '## Error ',
        separator = '───',
        prompts = {
          Explain = {
            prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.',
          },
          Review = {
            prompt = '/COPILOT_REVIEW Review the selected code.',
            callback = function(response, source)
              -- Additional processing can be added here
            end,
          },
          Fix = {
            prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.',
          },
          Optimize = {
            prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readability.',
          },
          Docs = {
            prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.',
          },
          Tests = {
            prompt = '/COPILOT_GENERATE Please generate tests for my code.',
          },
          Commit = {
            prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
          },
        },
        window = {
          layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
          width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
          height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
          -- Options below only apply to floating windows
          relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
          border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
          row = nil, -- row position of the window, default is centered
          col = nil, -- column position of the window, default is centered
          title = 'Copilot Chat', -- title of chat window
          footer = nil, -- footer of chat window
          zindex = 1, -- determines if window is on top or below other floating windows
        },
        mappings = {
          complete = {
            detail = 'Use @<Tab> or /<Tab> for options.',
            insert = '<Tab>',
          },
          close = {
            normal = 'q',
            insert = '<C-c>',
          },
          reset = {
            normal = '<C-r>',
            insert = '<C-r>',
          },
          submit_prompt = {
            normal = '<CR>',
            insert = '<C-s>',
          },
          accept_diff = {
            normal = '<C-y>',
            insert = '<C-y>',
          },
          yank_diff = {
            normal = 'gy',
          },
          show_diff = {
            normal = 'gd',
          },
          show_system_prompt = {
            normal = 'gp',
          },
          show_user_selection = {
            normal = 'gs',
          },
        },
      }
    end,
  },
}
