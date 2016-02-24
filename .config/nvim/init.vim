" Begin vim-plug section.
call plug#begin()

" List vim-plug packages.
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/emmet-vim'
Plug 'easymotion/vim-easymotion'
Plug 'leafgarland/typescript-vim'

" End vim-plug section.
call plug#end()

" Set color schema.
colorscheme Tomorrow-Night-Bright

" Set up vim-airline.
let g:airline_powerline_fonts = 1

" General settings.
set number
set ignorecase
set smartcase
set mouse-=a
set nowrapscan

" Indent settings.
set expandtab
set tabstop=2
set shiftwidth=2

" Custom key maps.
nmap <silent> <M-w>   :tabnext<CR>
nmap <silent> <M-q>   :tabprev<CR>
nmap <silent> <M-t>   :tabnew<CR>
nmap <silent> <M-S-t> :tab split<CR>
nmap <silent> <M-e>   :NERDTreeToggle<CR>
" Yunk to the system clipboard.
map  <silent> <M-y>   "+y
" Paste from the system clipboard.
map  <silent> <M-p>   "+p
map  <silent> <M-P>   "+P
" Settings for EasyMotion.
map  <silent> <M-s>   \\s

" Load local settings.
if filereadable(glob('~/.config/nvim/local.vim'))
  source ~/.config/nvim/local.vim
endif

