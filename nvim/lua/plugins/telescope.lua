return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    'theprimeagen/harpoon',
  },

  keys = {
    -- {
    --   '<leader>ff', '<cmd>builtin.find_files<cr>', {},
    --   desc = 'Find files',
    -- },
    -- {
    --   '<leader>fg', '<cmd>builtin.git_files<cr>', {},
    --   desc = 'Find git files',
    -- },
    -- {
    --   '<leader>fb', '<cmd>builtin.buffers<cr>', {},
    --   desc = 'Find buffers',
    -- },
    -- {
    --   '<leader>fh', '<cmd>builtin.help_tags<cr>', {},
    --   desc = 'Find help tags',
    -- },
    {
      '<leader>fw',
      function() require('telescope').builtin.grep_string({ search = vim.fn.input("grep > ") }) end,
      desc = 'Find word'
    }
  },

  opts = {
    extensions = {
      'fzf',
      'harpoon'
    }
  }
}