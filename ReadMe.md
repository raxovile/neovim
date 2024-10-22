# neovim configuration

## Inhaltsverzeichnis

- [Ordnerstruktur](#ordnerstruktur)
- [Plugins](#plugins)
  - [Utility Plugins](#utility-plugins)
  - [LSP Plugins](#lsp-plugins)
  - [Editor Plugins](#editor-plugins)
  - [UI Plugins](#ui-plugins)
  - [Completion Plugins](#completion-plugins)
  - [DAP Plugins](#dap-plugins)
  - [Fuzzy Finder Plugins](#fuzzy-finder-plugins)

## Ordnerstruktur

Die Konfigurationsdateien sind wie folgt organisiert:
```
~/.config/nvim/ 
├── init.lua 
└── lua 
  ├── basicAutocommands.lua 
  ├── globals.lua 
  ├── lazyInstallation.lua 
  ├── options.lua 
  ├── plugins 
    │   
    ├── completion.lua 
    │   ├── dap.lua │   ├── editor.lua │   ├── lsp.lua │   ├── telescope.lua │   ├── ui.lua │   └── utility.lua
```

## Plugins

### Utility Plugins

- **tpope/vim-sleuth**:
  - Automatische Erkennung von Tabstop- und Shiftwidth-Einstellungen in Dateien.
- **folke/lazy.nvim**:
  - Plugin-Manager, der Plugins effizient lädt und verwaltet.
- **BurntSushi/ripgrep**:
  - Ripgrep-Integration für schnelles Durchsuchen von Dateien im Projekt (schneller als `grep`).
- **nvim-lua/plenary.nvim**:
  - Hilfsbibliothek, die von vielen Neovim-Plugins verwendet wird (z.B. für Dateisystemoperationen).
- **PProvost/vim-ps1**:
  - Syntax-Highlighting und grundlegende Unterstützung für PowerShell-Scripts in Neovim.
- **KaiWalter/azure-functions.nvim**:
  - Unterstützung für Azure Functions, ermöglicht Interaktionen und Verwaltung von Azure Functions innerhalb von Neovim.

### LSP Plugins

- **nvim-lua/lsp-status.nvim**:
  - Zeigt LSP-Statusinformationen wie Linting und Fehlerstatus in der Statusleiste an.
- **dense-analysis/ale**:
  - Asynchrone Linting-Engine, die Fehler und Warnungen während der Codebearbeitung anzeigt.
- **TheLeoP/powershell.nvim**:
  - PowerShell Language Server Protocol (LSP) Unterstützung, bietet Autocomplete und Fehlerüberprüfung für PowerShell-Skripte.
- **jose-elias-alvarez/null-ls.nvim**:
  - Integration von externen Linter-, Formatter- und anderen Tools in den Neovim LSP. Unterstützt benutzerdefinierte Konfigurationen für verschiedene Sprachen.
  - Beispiel für die Konfiguration von `clang_format` für mehrere Sprachen:

    ```lua
    require('null-ls').setup {
      sources = {
        require('null-ls').builtins.formatting.clang_format.with {
          filetypes = { 'c', 'cpp', 'cs', 'typescript', 'javascript', 'json' },
        },
      },
    }
    ```
- **neovim/nvim-lspconfig**:
  - Haupt-Plugin für die Konfiguration und Verwaltung von LSP-Servern.
  - **williamboman/mason.nvim**:
    - Automatische Installation und Verwaltung von LSPs und zugehörigen Tools.
  - **williamboman/mason-lspconfig.nvim**:
    - Integration von mason.nvim mit nvim-lspconfig.
  - **WhoIsSethDaniel/mason-tool-installer.nvim**:
    - Automatische Installation von Tools, die von LSPs verwendet werden.
  - **j-hui/fidget.nvim**:
    - Zeigt nützliche Status-Updates für LSP an.
  - **nvim-lua/lsp-status.nvim**:
    - Anzeige des LSP-Status in der Statusleiste
  - **hrsh7th/cmp-nvim-lsp**:
    - Zusätzliche LSP-Fähigkeiten für nvim-cmp.

### Editor Plugins

- **tpope/vim-fugitive**:
  - Git-Integration für Neovim. Ermöglicht Git-Kommandos direkt in Neovim auszuführen.
- **rcarriga/nvim-dap-ui**:
  - UI für das Debugging-Plugin DAP (Debug Adapter Protocol), um Debugging-Informationen grafisch anzuzeigen.
- **lewis6991/gitsigns.nvim**:
  - Zeigt Git-Änderungen in der Gutter-Leiste an (z.B. geänderte, hinzugefügte und entfernte Zeilen).
- **windwp/nvim-autopairs**:
  - Automatisches Einfügen und Schließen von Klammern, Anführungszeichen und anderen Zeichen.
- **stevearc/conform.nvim**:
  - Automatisches Formatieren von Code beim Speichern.

### UI Plugins

- **olimorris/onedarkpro.nvim**:
  - Farbschema-Plugin, das das beliebte OneDark-Farbschema bereitstellt.

### Completion Plugins

- **hrsh7th/nvim-cmp**:
  - Autocompletion-Plugin für Neovim.
- **L3MON4D3/LuaSnip**:
  - Snippet-Engine für Neovim.
- **saadparwaiz1/cmp_luasnip**:
  - Integration von LuaSnip in nvim-cmp.
- **hrsh7th/cmp-nvim-lsp**:
  - LSP-Quelle für nvim-cmp.
- **hrsh7th/cmp-path**:
  - Dateipfad-Quelle für nvim-cmp.
- **folke/lazydev.nvim**:
  - Konfiguriert die Lua LSP für Neovim-Konfigurationen, Laufzeit und Plugins. Bietet Vervollständigung, Annotationen und Signaturen für Neovim-APIs.
  - Beispiel für die Konfiguration:

    ```lua
    require('lazydev').setup {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    }
    ```

### Fuzzy Finder Plugins

- **nvim-telescope/telescope.nvim**:
  - Fuzzy Finder, der Dateien, LSP-Symbole und vieles mehr durchsuchen kann.
  - Abhängigkeiten:
    - **nvim-lua/plenary.nvim**: Hilfsbibliothek für Neovim Plugins.
    - **nvim-telescope/telescope-fzf-native.nvim**: FZF-Suchalgorithmus-Unterstützung für Telescope.
    - **nvim-telescope/telescope-ui-select.nvim**: Ermöglicht die Nutzung von Telescope für die Neovim UI-Auswahl.
    - **nvim-tree/nvim-web-devicons**: Icons für eine ansprechendere Darstellung (erfordert Nerd Fonts).
    - **nvim-telescope/telescope-file-browser.nvim**: Dateibrowser-Erweiterung für Telescope.

### DAP Plugins

- **mfussenegger/nvim-dap**:
  - Debug Adapter Protocol (DAP) Unterstützung für Neovim, ermöglicht Debugging von Code direkt in Neovim.
  - Konfigurationen für .NET (netcoredbg) und PowerShell (PSES - PowerShell Editor Services).
- **rcarriga/nvim-dap-ui**:
  - Benutzeroberfläche für nvim-dap, um Debugging-Informationen grafisch anzuzeigen.
## Installation

1. Klone dieses Repository in dein Neovim-Konfigurationsverzeichnis:
   ```sh
   git clone <dein-repo-url> ~/.config/nvim
   ```

2. Installiere die Plugins, indem du Neovim startest und den Befehl `:Lazy sync` ausführst.

3. Genieße deine neue Neovim-Konfiguration!
