return {
  { 'nvim-lua/lsp-status.nvim' }, -- LSP status updates
  { 'dense-analysis/ale' }, -- Asynchronous linting
  { 
    'TheLeoP/powershell.nvim', -- PowerShell LSP
    config = function()
      require('powershell').setup()
    end 
  },
}
