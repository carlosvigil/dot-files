return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  keys = {
    { '<leader>gs', function() vim.cmd(':Git') end, desc = 'Git Status' }
  }
}
