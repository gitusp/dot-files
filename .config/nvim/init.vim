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
" Better substitution(currently not supporting live preview)
Plug 'tpope/vim-abolish'

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
" Normal mode - normal assignments
nnoremap          >       >>
nnoremap          <       <<
nnoremap          Y       y$
nnoremap          _       @:
nnoremap <silent> +       :Files<CR>
nnoremap <silent> <C-l>   :noh<CR><C-l>
nnoremap <silent> [b      :bprevious<CR>
nnoremap <silent> ]b      :bnext<CR>
nnoremap <silent> [B      :bfirst<CR>
nnoremap <silent> ]B      :blast<CR>
nnoremap <silent> [t      :tabprevious<CR>
nnoremap <silent> ]t      :tabnext<CR>
nnoremap <silent> [T      :tabfirst<CR>
nnoremap <silent> ]T      :tablast<CR>
nnoremap <silent> <Space> :w<CR>
" Normal mode - aggresive assignments
nnoremap <silent> x       :e .scratch.md<CR>
nnoremap <silent> X       :e `scratchf`<CR>
nnoremap <silent> s       :vsplit<CR>
nnoremap <silent> S       :split<CR>
nnoremap <silent> <C-g>   :terminal<CR>iggl 
" Visual mode - aggresive assignments
vnoremap          x       <Nop>
vnoremap          X       <Nop>
vnoremap          s       <Nop>
vnoremap          S       <Nop>
" Terminal mode
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

