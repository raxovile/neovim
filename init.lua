-- load global vim configurations
require 'globals'

-- load vim option configurations
require 'options'

-- load vim basic autocommands
require 'basicAutocommands'

-- load lazy.vim as Plugin Manager
require 'lazyInstallation'

require('lazy').setup({
  { 'tpope/vim-sleuth' },
  { 'folke/lazy.nvim' },
  { 'BurntSushi/ripgrep' },
  { 'nvim-lua/plenary.nvim' },
  { 'PProvost/vim-ps1' },
  { 'nvim-lua/lsp-status.nvim' },
  { 'rcarriga/nvim-dap-ui' },
  { 'tpope/vim-fugitive' },
  { 'KaiWalter/azure-functions.nvim' },
  { 'dense-analysis/ale' },
  { 'TheLeoP/powershell.nvim' },
    { 
    'olimorris/onedarkpro.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'onedark'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  })
