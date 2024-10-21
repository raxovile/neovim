return {
  { 
    'olimorris/onedarkpro.nvim', -- OneDark theme
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'onedark'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
