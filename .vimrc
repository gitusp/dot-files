set nocompatible

"----------------------------------------
" plugin - NeoBundle
"----------------------------------------
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/neobundle.vim.git
    call neobundle#rc(expand('~/.vim/.bundle/'))
endif

NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'

filetype plugin indent on

"------------------------------------
" general
"------------------------------------
set number
set wildmenu
set wildmode=list:longest

set showmatch
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]

"color
syntax enable
set t_Co=256
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_bold=1
colorscheme solarized

"search
set ignorecase
set smartcase
set hlsearch
set incsearch
set nowrapscan

"indent
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set ambiwidth=double

"encoding
set encoding=utf-8
set fileencodings=utf-8,sjis

"nmap
nnoremap > >>
nnoremap < <<
nnoremap j gj
nnoremap k gk

"------------------------------------
" KEYWORDS
"------------------------------------
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
    endif
endif

