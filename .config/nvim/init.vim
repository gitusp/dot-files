"
" Begin plugin section.
"
call plug#begin()

" Colorscheme
Plug 'chriskempson/vim-tomorrow-theme'
" Syntax checker
Plug 'w0rp/ale', { 'do': 'npm install -g eslint-cli prettier' }
" Javascript syntax highlight
Plug 'pangloss/vim-javascript'
" Pug syntax highlight
Plug 'digitaltoad/vim-pug'
" Load editorconfig.
Plug 'editorconfig/editorconfig-vim'
" Better status line
Plug 'vim-airline/vim-airline'
" Dark powered asynchronous completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" ternjs integration
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Open required files by `gf`.
Plug 'moll/vim-node'
" Surrounding helper
Plug 'tpope/vim-surround'
" Enable to repeat surrounding
Plug 'tpope/vim-repeat'
" Git integration
Plug 'tpope/vim-fugitive'
" Better file explorer
Plug 'tpope/vim-vinegar'
" Text alignment - e.g. TableFormat
Plug 'godlygeek/tabular'
" Markdown support
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.vim'
" Session manager
Plug 'tpope/vim-obsession'
" Comment plugin
Plug 'tpope/vim-commentary'
" Case preserving substitution(currently its live preview is not supported)
Plug 'tpope/vim-abolish'
" Fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme Tomorrow-Night
set ignorecase
set smartcase
set inccommand=nosplit

"
" Custom mappings
"
nnoremap          >     >>
nnoremap          <     <<
nnoremap          Y     y$
nnoremap          _     @:
nnoremap <silent> +     :Files<CR>
nnoremap <silent> <C-l> :noh<CR><C-l>
nnoremap <silent> [t    :tabprevious<CR>
nnoremap <silent> ]t    :tabnext<CR>
nnoremap <silent> [T    :tabfirst<CR>
nnoremap <silent> ]T    :tablast<CR>
tnoremap          <Esc> <C-\><C-n>

"
" Airline settings
"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"
" ALE settings
"
let g:ale_sign_column_always = 1
let g:ale_sign_error = '🌸'
let g:ale_sign_warning = '🍀'
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" NOTE: Each linter and prettier's setup tips
" eslint: Install `eslint` project-locally while install `eslint-cli` globally.
" prettier: Install `prettier` globally.
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\}

"
" General completion settings
"
let g:deoplete#enable_at_startup = 1

"
" Javascript settings
"
let g:javascript_plugin_jsdoc = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#in_literal = 0

