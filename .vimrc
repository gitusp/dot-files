"------------------------------------
"  NeoBundle
"------------------------------------
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"------------------------------------
" general
"------------------------------------
set number
set wildmenu
set wildmode=list:longest

set showmatch

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

