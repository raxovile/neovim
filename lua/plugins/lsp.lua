return {
  -- Haupt-LSP-Konfiguration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- Automatische Installation von LSP und zugehörigen Tools
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} }, -- Nützliche Status-Updates für LSP
      { 'nvim-lua/lsp-status.nvim' }, -- Anzeige des LSP-Status
      'hrsh7th/cmp-nvim-lsp', -- Zusätzliche Fähigkeiten durch nvim-cmp
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my-lsp-config-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- LSP Keymappings
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, '[D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument Symbols')
          map('<leader>ws', require('telescope.builtin').lsp_workspace_symbols, '[W]orkspace Symbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          map('<leader>wd', vim.diagnostic.setloclist, '[W]orkspace [D]iagnostics')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Autokommandos zum Hervorheben von Referenzen
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('my-lsp-config-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('my-lsp-config-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'my-lsp-config-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Funktion für Inlay Hints
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.toggle()
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP-Fähigkeiten für nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local tools_path = os.getenv 'TOOLS'
      local lsp_status = require 'lsp-status'
      lsp_status.register_progress()
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        omnisharp = {
          cmd = { tools_path .. '/omnisharp/OmniSharp.exe', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
          filetypes = { 'cs' },
          root_dir = require('lspconfig').util.root_pattern('*.sln', '*.csproj'),
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            require('lsp-status').on_attach(client, bufnr)

            vim.api.nvim_buf_set_keymap(
              bufnr,
              'n',
              '<leader>oi',
              '<cmd>lua vim.lsp.buf.formatting_sync()<CR>',
              { noremap = true, silent = true, desc = 'Organize Imports' }
            )

            vim.api.nvim_buf_set_keymap(
              bufnr,
              'n',
              '<leader>fi',
              '<cmd>lua vim.lsp.buf.code_action()<CR>',
              { noremap = true, silent = true, desc = '[F]ix [I]ssues' }
            )
          end,

          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          semantic_tokens = true,
        },

        powershell_es = {
          cmd = { 'pwsh', '-NoLogo', '-NoProfile', '-Command', tools_path .. '/PowerShellEditorServices/PowerShellEditorServices/Start-EditorServices.ps1' },
          filetypes = { 'ps1', 'psm1', 'psd1' },
          root_dir = require('lspconfig').util.root_pattern('.git', '*.ps1'),
          capabilities = capabilities,
          settings = {
            powershell = {
              codeFormatting = {
                autoCorrectAliases = true,
                useCorrectCasing = true,
              },
            },
          },
        },
      }

      -- nvim-cmp Setup für LSP-basierte Vervollständigungen
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true }, -- Bestätigung der Autovervollständigung
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- Falls du Snippets verwendest
        },
      }

      -- Diagnostik Einstellungen
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        update_in_insert = false,
      })

      -- Stelle sicher, dass die oben genannten Server installiert sind
      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { 'stylua' }) -- Hinzufügen von Stylua für Lua-Formatierung
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- Null-ls für externe Linter und Formatter
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.clang_format.with {
            filetypes = { 'c', 'cpp', 'cs', 'typescript', 'javascript', 'json' }, -- Hier die gewünschten Sprachen
          },
        },
      }
    end,
  },

  {
    -- `lazydev` konfiguriert die Lua LSP für deine Neovim-Konfiguration, Runtime und Plugins
    -- Wird für die Vervollständigung, Annotationen und Signaturen der Neovim APIs benutzt
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
}
