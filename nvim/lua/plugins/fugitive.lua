return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  keys = {
    { '<leader>gs', '<cmd>vim.cmd.Git<cr>', desc = 'Git Status' }
  }
}