return {
  { 'nvim-lua/lsp-status.nvim' }, -- LSP status updates
  { 'dense-analysis/ale' }, -- Asynchronous linting
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.clang_format.with {
            filetypes = { 'c', 'cpp', 'cs', 'typescript', 'javascript', 'json' },
          },
        },
      }
    end,
  },
}
