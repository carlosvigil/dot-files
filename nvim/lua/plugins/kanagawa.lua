return {
  "rebelot/kanagawa.nvim",
  lazy = false, -- make sure we load this during startup
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    vim.cmd.colorscheme('kanagawa')
    vim.api.nvim_set_hl(0, 'Normal', {bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'none' })
  end,
}