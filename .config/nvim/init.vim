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
" Enable plugin command repeat
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
" Fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" auto close
Plug 'jiangmiao/auto-pairs'
" utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Snippets
Plug 'SirVer/ultisnips'

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
nnoremap          >       >>
nnoremap          <       <<
nnoremap          Y       y$
nnoremap          _       @:
nnoremap <silent> s       :sp<CR>
nnoremap <silent> S       :vsp<CR>
nnoremap <silent> x       :bprevious<CR>
nnoremap <silent> X       :bnext<CR>
nnoremap <silent> +       :Files<CR>
nnoremap <silent> <C-l>   :noh<CR><C-l>
nnoremap <silent> [t      :tabprevious<CR>
nnoremap <silent> ]t      :tabnext<CR>
nnoremap <silent> [T      :tabfirst<CR>
nnoremap <silent> ]T      :tablast<CR>
nnoremap <silent> <Space> :w<CR>
vnoremap <silent> s       :sp<CR>
vnoremap <silent> S       :vsp<CR>
vnoremap <silent> x       :bprevious<CR>
vnoremap <silent> X       :bnext<CR>
tnoremap          <Esc>   <C-\><C-n>

"
" Airline settings
"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"
" Snips
"
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-f>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

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

