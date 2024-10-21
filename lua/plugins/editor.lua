return {
  { 'tpope/vim-fugitive' }, -- Git integration
  { 
    'lewis6991/gitsigns.nvim', -- Git signs
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { 
    'windwp/nvim-autopairs', -- Automatic pairing of brackets
    config = function()
      require('nvim-autopairs').setup {
        disable_filetype = { 'TelescopePrompt', 'vim' },
        check_ts = true, -- Enable treesitter integration
      }
    end,
  },
  { 
    'stevearc/conform.nvim', -- Autoformatting
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        cs = { 'clang_format' },
        extra_args = { '--style=file', '--assume-filename=' .. vim.fn.stdpath 'config' .. '.clang-format' },
      },
    },
  },
}
