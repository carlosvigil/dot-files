return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  event = "BufRead",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    'theprimeagen/harpoon',
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require('telescope').load_extension('telescope-fzf-native.nvim')
    end,
  },
  opts = {
    defaults = {
      file_ignore_patterns = {
        "%.git", "node_modules", "venv", ".venv", "env", ".env"
      },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
    },
    extensions = {
      'fzf',
      'harpoon'
    }
  },
  keys = {
    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files()
      end, {},
      desc = 'Find files',
    },
    {
      '<leader>fg',
      function()
        require('telescope.builtin').git_files()
      end, {},
      desc = 'Find git files',
    },
    {
      '<leader>fb',
      function()
        require('telescope.builtin').buffers()
      end, {},
      desc = 'Find buffers',
    },
    {
      '<leader>fh',
      function()
        require('telescope.builtin').help_tags()
      end, {},
      desc = 'Find help tags',
    },
    {
      '<leader>fw',
      function() 
        require('telescope.builtin').grep_string({
          search = vim.fn.input("grep > ")
        })
      end,
      desc = 'Find word'
    }
  }
}
