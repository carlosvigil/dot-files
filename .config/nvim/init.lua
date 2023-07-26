-- TODO: add a config for VSCode
-- TODO: remove or configure TreeSitter/LSP
-- TODO: test, fix, configure Telescope extentions fzf & harpoon

if vim.env.VSCODE then
  vim.g.vscode = true
end

require 'opts'
require 'keys'
require 'aintnobodygottimeforconfigs'
