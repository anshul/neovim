local snacks = require 'snacks'
local M = {}

M.dashboard = {
  enabled = true,
  preset = {
    keys = {
      {
        icon = ' ',
        key = '<C-p>',
        desc = 'Find git file',
        action = ':lua Snacks.picker.git_files({ untracked = true })',
      },
      {
        icon = ' ',
        key = '<C-f>',
        desc = 'Search',
        action = ':lua Snacks.picker.grep()',
      },
      {
        icon = ' ',
        key = '<C-o>',
        desc = 'Open file',
        action = ':lua Snacks.picker.files()',
      },
      {
        icon = ' ',
        key = '<C-n>',
        desc = 'New note',
        action = ':ObsidianNew',
      },
      {
        icon = ' ',
        key = '<C-t>',
        desc = 'Find todos',
        action = ':lua Snacks.picker.todo_comments()',
      },
      {
        icon = '󰚩 ',
        key = '<C-g>',
        desc = 'Supermaven Status',
        action = ':SupermavenStatus',
      },
      {
        icon = ' ',
        key = 'r',
        desc = 'Restore Session',
        action = ':PossessionLoadCwd',
      },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
    header = [[

     __  _ __  __ _  __  __
    |  \| |\ \/ /| ||  \/  |
    |_|\__| \__/ |_||_|\/|_|

    ]],
  },
  formats = {
    key = function(item)
      return {
        { '[', hl = 'special' },
        { item.key, hl = 'key' },
        { ']', hl = 'special' },
      }
    end,
  },
  sections = {
    {
      section = 'header',
      indent = -5,
    },
    {
      -- icon = ' ',
      -- title = 'Builtin Actions',
      section = 'keys',
      gap = 1,
      padding = 1,
    },
    {
      text = '󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘 󰄛 󰄛 󰄛 󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘󰇘',
      padding = 1,
    },
    {
      -- icon = ' ',
      title = 'Recent Files',
      section = 'recent_files',
      padding = 1,
    },
    {
      -- icon = ' ',
      title = 'Projects',
      section = 'projects',
      padding = 1,
    },
    {
      -- icon = ' ',
      title = 'Git Status',
      section = 'terminal',
      enabled = function()
        return snacks.git.get_root() ~= nil
      end,
      cmd = 'git status --short --branch --renames',
      height = 5,
      padding = 1,
      ttl = 5 * 60,
    },
  },
}

return M
