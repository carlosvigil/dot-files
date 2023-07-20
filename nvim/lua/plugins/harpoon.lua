return {
  'theprimeagen/harpoon',
  event = 'VeryLazy',
  dependencies =  { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>j', '<cmd>harpoon.mark.add_file<cr>',
      desc = 'Hook file',
    },
    {
      '<leader>m', '<cmd>lua:harpoon.ui.toggle_quick_menu<cr>',
      desc = 'Harpoon Menu',
    },
    {
      '<leader>k', function() harpoon.ui.nav_next() end,
      desc = 'Go to next Hook',
    },
    {
      '<leader>1', function() harpoon.ui.nav_file(1) end,
      desc = 'Go to Hook 1',
    },
    {
      '<leader>2', function() harpoon.ui.nav_file(2) end,
      desc = 'Go to Hook 2',
    },
    {
      '<leader>3', function() harpoon.ui.nav_file(3) end,
      desc = 'Go to Hook 3',
    },
    {
      '<leader>t', function() harpoon.term.gotoTerminal(1) end,
      desc = 'Go to Terminal',
    },
  },
  opts = {
    global_settings = {
      mark_branch = true
    },
    menu = {
      width = vim.api.nvim_win_get_width(0) - 8,
      height = 5
    }
  }
}