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

" Indent settings.
set expandtab
set tabstop=2
set shiftwidth=2

" Custom key maps.
nmap <silent> ÷ :tabnext<CR>
nmap <silent> ñ :tabprev<CR>
nmap <silent> ô :tabnew<CR>
nmap <silent> Ô :tab split<CR>
nmap <silent> å :NERDTreeToggle<CR>
" Yunk to the system clipboard.
map  <silent> ù "+y
" Paste from the system clipboard.
map  <silent> ð "+p
map  <silent> Ð "+P
" Settings for EasyMotion.
map  <silent> ó \\s

" Load local settings.
if filereadable(glob('~/.config/nvim/local.vim'))
  source ~/.config/nvim/local.vim
endif

