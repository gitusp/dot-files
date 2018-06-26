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
Plug 'gregsexton/gitv', {'on': ['Gitv']}
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
" Minimalist's better netrw
Plug 'justinmk/vim-dirvish'
" History util
Plug 'mbbill/undotree'
" Fancy start screen
Plug 'mhinz/vim-startify'

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme Tomorrow-Night
" Search settings
set ignorecase
set smartcase
set inccommand=nosplit
" Undo settings
set undodir=~/.config/nvim/undodir/
set undofile
" Default tab settings
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
" Other settings
set hidden
autocmd TermOpen * startinsert
set nofoldenable
set lazyredraw

"
" Custom mappings
"
" Normal mode - normal assignments
nmap              <C-J>       <C-M>
nnoremap          >           >>
nnoremap          <           <<
nnoremap          Y           y$
nnoremap          _           @:
nnoremap <silent> +           :Files<CR>
nnoremap <silent> [a          :ALEPreviousWrap<CR>
nnoremap <silent> ]a          :ALENextWrap<CR>
nnoremap <silent> [A          :ALEFirst<CR>
nnoremap <silent> ]A          :ALELast<CR>
nnoremap <silent> [b          :bprevious<CR>
nnoremap <silent> ]b          :bnext<CR>
nnoremap <silent> [B          :bfirst<CR>
nnoremap <silent> ]B          :blast<CR>
nnoremap <silent> [t          :tabprevious<CR>
nnoremap <silent> ]t          :tabnext<CR>
nnoremap <silent> [T          :tabfirst<CR>
nnoremap <silent> ]T          :tablast<CR>
nnoremap <silent> gl          :Lines<CR>
nnoremap <silent> gs          :Gstatus<CR>
nnoremap <silent> sh          :split<CR>
nnoremap <silent> sv          :vsplit<CR>
nnoremap <silent> <C-L>       :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <silent> <Space>     :w<CR>
nnoremap <silent> <C-Space>   :Commands<CR>
nnoremap <silent> z<Space>    :call IwhiteToggle()<CR>
" Normal mode - aggresive assignments
nnoremap          x           <Nop>
nnoremap          X           <Nop>
nnoremap          s           <Nop>
nnoremap          S           <Nop>
" Normal mode - meta assignments
nnoremap          <M-p>       "+p
nnoremap          <S-M-p>     "+P
nnoremap          <M-y>       "+y
nnoremap          <M-y><M-y>  "+yy
nmap              <S-M-y>     "+Y
" Visual mode - aggresive assignments
vnoremap          x           <Nop>
vnoremap          X           <Nop>
vnoremap          s           <Nop>
vnoremap          S           <Nop>
" Visual mode - meta assignments
vnoremap          <M-p>       "+p
vnoremap          <S-M-p>     "+P
vnoremap          <M-y>       "+y
vnoremap          <S-M-y>     "+Y
" Terminal mode
tnoremap          <Esc>       <C-\><C-N>
tnoremap          <C-J>       <C-M>
" Command line mode(excerpt from rsi.vim)
cnoremap          <C-A>       <Home>
cnoremap          <C-B>       <Left>
cnoremap <expr>   <C-D>       getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr>   <C-F>       getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
" Insert mode
imap              <C-X><C-L>  <Plug>(fzf-complete-line)
" File specific mappings
autocmd FileType help nnoremap <silent><buffer> q :q<CR>

" 
" Custom commands
"
command! -nargs=? Scratch :e `scratchf <args>`
command!          LScratch :e .scratch.md

"
" Shortcuts
"
cabbrev <expr> ag getcmdtype() == ':' ? 'Ag'    : 'ag'
cabbrev <expr> gd getcmdtype() == ':' ? 'Gdiff' : 'gd'
cabbrev <expr> gv getcmdtype() == ':' ? 'Gitv'  : 'gv'

"
" AutoPairs Settings
"
" Change mapping since it conflicts with paste from `system clipboard`.
let g:AutoPairsShortcutToggle = '<M-q>'

"
" Airline settings
"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"
" Snips
"
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-F>'
let g:UltiSnipsJumpBackwardTrigger = '<C-B>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

"
" ALE settings
"
let g:ale_sign_column_always = 1
let g:ale_sign_warning = '──'
let g:ale_sign_error = '══'
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1

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

"
" Toggle diffopt
"
function! IwhiteToggle()
 if &diffopt =~ 'iwhite'
   set diffopt-=iwhite
 else
   set diffopt+=iwhite
 endif
endfunction

