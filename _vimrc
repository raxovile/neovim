" ========================================================
"               VIM Konfigurationsdatei (_vimrc)
" ========================================================

" ------------------------------
"   Allgemeine Vim-Einstellungen
" ------------------------------

" Deaktiviere die Kompatibilität mit vi, um unerwartete Probleme zu vermeiden.
set nocompatible

" Erlaube Vim, den Dateityp automatisch zu erkennen.
filetype on

" Aktiviere Plugins und lade das Plugin für den erkannten Dateityp.
filetype plugin on

" Lade eine Einrückungsdatei für den erkannten Dateityp.
filetype indent on

" Syntax-Highlighting aktivieren.
syntax on

" Zeilennummern anzeigen.
set number

" Relative Zeilennummern aktivieren
" " Dies zeigt die Zeilennummer relativ zur aktuellen Cursorposition an.
" " Die aktuelle Zeile zeigt die absolute Nummer an, wobei alle anderen Zeilen
" " die relative Zahl zur aktuellen Zeile anzeigen.
set relativenumber

" Verschiebebreite auf 4 Leerzeichen setzen.
set shiftwidth=4

" Tabulatorbreite auf 4 Spalten setzen.
set tabstop=4

" Verwende Leerzeichen anstelle von Tabs.
set expandtab

" Keine Backup-Dateien speichern.
set nobackup

" Den Cursor nicht über die ersten oder letzten N Zeilen beim Scrollen hinaus bewegen.
set scrolloff=10

" Zeilen nicht umbrechen. Lange Zeilen sollen so weit gehen, wie sie gehen.
set nowrap

" Inkrementelle Suche aktivieren, um übereinstimmende Zeichen während der Eingabe hervorzuheben.
set incsearch

" Groß- und Kleinschreibung bei der Suche ignorieren.
set ignorecase

" Die Option ignorecase überschreiben, wenn nach Großbuchstaben gesucht wird.
set smartcase

" Teilweise Befehle in der letzten Zeile des Bildschirms anzeigen.
set showcmd

" Den Modus in der letzten Zeile anzeigen.
set showmode

" Übereinstimmende Klammern und Klammern anzeigen.
set showmatch

" Hervorhebung bei der Suche verwenden.
set hlsearch

" Anzahl der gespeicherten Befehle in der Historie auf 1000 setzen.

set history=1000
" Automatische Vervollständigung nach Drücken von TAB aktivieren.
set wildmenu

" Wildmenu wie Bash-Vervollständigung verhalten lassen.
set wildmode=list:longest

" Bestimmte Dateien, die wir nie mit Vim bearbeiten möchten, ignorieren.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set background=dark

" Schriftart 
set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h12

" cursor 
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" ------------------------------
"
"   Plugins und Benutzerdefinierte Konfiguration
" ------------------------------

call plug#begin('~/.vim/plugged')

 Plug 'dense-analysis/ale'
 Plug 'rakr/vim-one'
 Plug 'preservim/nerdtree'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'airblade/vim-gitgutter'
 Plug 'vim-airline/vim-airline'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-fugitive'
 Plug 'github/copilot.vim'
 Plug 'editorconfig/editorconfig-vim'
 Plug 'terryma/vim-multiple-cursors' 
 


call plug#end()

" ------------------------------
"   Tastenkombinationen
" ------------------------------


noremap <C-c> "+y


" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``

" Press \p to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
nnoremap <silent> <leader>p :%w !lp<CR>

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" Map the F5 key to run a Python script inside Vim.
" We map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <F3> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']



" ------------------------------
"   Vimscripts
" ------------------------------

" Code für Vimscripts, z.B. für Code-Folding.
" Hier ist ein Beispiel für das Marker-basierte Falten.

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" If GUI version of Vim is running set these options.
if has('gui_running')

    " Set the background tone.
    set background=dark

    " Set the color scheme.
    colorscheme one

    " Set a custom font you have installed on your computer.
    " Syntax: <font_name>\ <weight>\ <size>
    set guifont=Monospace\ Regular\ 12

    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the left-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>

" ------------------------------
"   Statuszeile
" ------------------------------

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

endif
