require('lze').load {
  {
    'plenary.nvim',
    lazy = false,
  },
  {
    'obsidian.nvim',
    dep = { 'plenary.nvim' },
    event = { 'DeferredUIEnter' },
    cmd = {
      'ObsidianNew',
      'ObsidianQuickSwitch',
      'ObsidianToday',
      'ObsidianTemplate',
      'ObsidianLink',
      'ObsidianBacklinks',
      'ObsidianLinks',
      'ObsidianRename',
      'ObsidianTOC',
    },
    after = function(_)
      local obsidian_path = vim.fn.expand '~/Documents/Obsidian'
      if vim.fn.isdirectory(obsidian_path) == 0 then
        vim.fn.mkdir(obsidian_path, 'p')
      end

      require('obsidian').setup {
        disable_frontmatter = true,
        workspaces = {
          {
            name = 'Obsidian',
            path = '~/Documents/Obsidian',
          },
        },
        new_notes_location = 'root',
        preferred_link_style = 'wiki',
        note_id_func = function(title)
          if title and title ~= '' then
            return title
          else
            return os.date '%Y-%m-%d'
          end
        end,
        daily_notes = {
          folder = 'Calendar/Notes/Daily',
          date_format = '%Y-%m-%d',
          template = 'Templates/Daily template.md',
        },
        templates = {
          folder = 'Templates',
          date_format = '%Y-%m-%d',
          time_format = '%H:%M',
          substitutions = {},
        },
        completion = {
          min_chars = 2,
          nvim_cmp = false,
          blink = true,
        },
        picker = { name = 'snacks.pick' },
        ui = { enable = false },
        attachments = {
          img_folder = 'Atlas/Utilities/Attachments',
        },
      }
    end,
  },
}

local function map(mode, key, action, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, key, action, options)
end

map('n', '<leader>nn', '<cmd>ObsidianNew<cr>', { desc = 'Obsidian new note' })
map('n', '<leader>nf', '<cmd>ObsidianQuickSwitch<cr>', { desc = 'Obsidian quick switch' })
map('n', '<leader>nd', '<cmd>ObsidianToday<cr>', { desc = 'Obsidian today' })
map('n', '<leader>nt', '<cmd>ObsidianTemplate<cr>', { desc = 'Obsidian template' })
map('v', '<leader>nk', '<cmd>ObsidianLink<cr>', { desc = 'Obsidian link' })
map('n', '<leader>nb', '<cmd>ObsidianBacklinks<cr>', { desc = 'Obsidian backlinks' })
map('n', '<leader>nl', '<cmd>ObsidianLinks<cr>', { desc = 'Obsidian links' })
map('n', '<leader>nr', '<cmd>ObsidianRename<cr>', { desc = 'Obsidian rename' })
map('n', '<leader>no', '<cmd>ObsidianTOC<cr>', { desc = 'Obsidian table of contents' })
