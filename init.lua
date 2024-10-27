-- Load global vim configurations
require 'globals'

-- Load vim option configurations
require 'options'

-- Load vim basic autocommands
require 'basicAutocommands'

-- Load lazy.vim as Plugin Manager
require 'lazyInstallation'
-- Configure and install plugins
require('lazy').setup({
  { import = 'plugins.utility' },
  { import = 'plugins.lsp' },
  { import = 'plugins.editor' },
  { import = 'plugins.theme' },
  { import = 'plugins.completion' },
  { import = 'plugins.dap' },
  { import = 'plugins.telescope' },
  { import = 'plugins.which-key' },
  { import = 'plugins.indent-blankline' },
  { import = 'plugins.prettier' },
  { import = 'plugins.todo-comments' },
  { import = 'plugins.mini' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.obsidian' },
}, {
  ui = {
    -- Customize the LazyVim UI
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
