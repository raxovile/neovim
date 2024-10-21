-- load global vim configurations
require 'globals'

-- load vim option configurations
require 'options'

-- load vim basic autocommands
require 'basicAutocommands'

-- load lazy.vim as Plugin Manager
require 'lazyInstallation'

require('lazy').setup({
  { 'tpope/vim-sleuth' }, -- Automatische Erkennung von Tabstop- und Shiftwidth-Einstellungen in Dateien
  { 'folke/lazy.nvim' }, -- Plugin-Manager, der Plugins effizient lädt und verwaltet
  { 'BurntSushi/ripgrep' }, -- Ripgrep-Integration für schnelles Durchsuchen von Dateien im Projekt (schneller als `grep`)
  { 'nvim-lua/plenary.nvim' }, -- Hilfsbibliothek, die von vielen Neovim-Plugins verwendet wird (z.B. für Dateisystemoperationen)
  { 'PProvost/vim-ps1' }, -- Syntax-Highlighting und grundlegende Unterstützung für PowerShell-Scripts in Neovim
  { 'nvim-lua/lsp-status.nvim' }, -- Zeigt LSP-Statusinformationen wie Linting und Fehlerstatus in der Statuszeile an
  { 'rcarriga/nvim-dap-ui' }, -- UI für das Debugging-Plugin DAP (Debug Adapter Protocol), um Debugging-Informationen grafisch anzuzeigen
  { 'tpope/vim-fugitive' }, -- Git-Integration für Neovim. Ermöglicht Git-Kommandos direkt in Neovim auszuführen
  { 'KaiWalter/azure-functions.nvim' }, -- Unterstützung für Azure Functions, ermöglicht Interaktionen und Verwaltung von Azure Functions innerhalb von Neovim
  { 'dense-analysis/ale' }, -- Asynchrone Linting-Engine, die Fehler und Warnungen während der Codebearbeitung anzeigt
  { 'TheLeoP/powershell.nvim' }, -- PowerShell Language Server Protocol (LSP) Unterstützung, bietet Autocomplete und Fehlerüberprüfung für PowerShell-Skripte
  { 
    'olimorris/onedarkpro.nvim', -- Farbschema-Plugin, das das beliebte OneDark-Farbschema bereitstellt
    priority = 1000, -- Stellt sicher, dass dieses Farbschema zuerst geladen wird, um Konsistenz bei anderen Plugins zu gewährleisten
    init = function()
      vim.cmd.colorscheme 'onedark' -- Setzt das Farbschema auf 'onedark'
      vim.cmd.hi 'Comment gui=none' -- Entfernt das Formatieren von Kommentaren (z.B. Kursivschrift) für bessere Lesbarkeit
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
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
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        disable_filetype = { 'TelescopePrompt', 'vim' },
        check_ts = true, -- Enable treesitter integration
      }
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
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
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
        --
        -- Add C# formatter
        cs = { 'clang_format' },
        extra_args = { '--style=file', '--assume-filename=' .. vim.fn.stdpath 'config' .. '.clang-format' },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
})

