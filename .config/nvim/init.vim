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
" Tern commands
Plug 'ternjs/tern_for_vim', { 'do': 'npm install -g tern' }
" Surrounding helper
Plug 'tpope/vim-surround'
" Better substitution
Plug 'tpope/vim-abolish'
" Git integration
Plug 'tpope/vim-fugitive'
" Better file explorer
Plug 'tpope/vim-vinegar'
" Markdown support
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.vim'

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
" Custom mappings
"
" NOTE: Do not assign these like `inoremap ( ()` or `inoremap [ []`, which
" output other characters aside from what you typed.

" Tabs
nnoremap <Tab>n :tabnew<CR>
nnoremap <Tab>l :tabnext<CR>
nnoremap <Tab>h :tabprev<CR>
nnoremap <Tab>L :execute 'tabmove ' . (tabpagenr() + 1)<CR>
nnoremap <Tab>H :execute 'tabmove ' . (tabpagenr() - 2)<CR>

" Copied from tpope's dotfile
nnoremap Y y$
nnoremap <C-l> :noh<CR><C-l>

" ft specific mappings
autocmd FileType javascript nnoremap <buffer> <C-]> :TernDef<CR>
autocmd FileType javascript nnoremap <buffer> <C-[> :TernRefs<CR>

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

" Use the same tern command for `tern_for_vim`.
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

