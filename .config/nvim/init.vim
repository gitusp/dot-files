"
" Begin plugin section.
"
call plug#begin()

" Colorscheme
Plug 'chriskempson/vim-tomorrow-theme'
" Better substitution
Plug 'tpope/vim-abolish'
" Syntax checker
Plug 'w0rp/ale'
" Javascript syntax highlight
Plug 'pangloss/vim-javascript'
" In-editor better grep
Plug 'mileszs/ack.vim'
" Surrounding helper
Plug 'tpope/vim-surround'
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

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme Tomorrow-Night-Bright
set ignorecase
set smartcase

"
" Search settings
"
" NOTE: This requires ag command.
" NOTE: To ignore files, put them in `.gitignore` or `.agignore`.
let g:ackprg = 'ag'

"
" Custom mappings
"
nnoremap <C-l> :noh<CR><C-l>
nnoremap <C-w><C-w>n :tabnew<CR>
nnoremap <C-w><C-w><C-n> :tabnew<CR>
nnoremap <C-w><C-w>l :tabnext<CR>
nnoremap <C-w><C-w><C-l> :tabnext<CR>
nnoremap <C-w><C-w>h :tabprev<CR>
nnoremap <C-w><C-w><C-h> :tabprev<CR>

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

" NOTE: Each linter's setup tips
" eslint: Install `eslint` project-locally while install `eslint-cli` globally.
" prettier: Install `prettier` project-locally while install `prettier-cli` globally.
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

