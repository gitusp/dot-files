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
Plug 'Raimondi/delimitMate'
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/emmet-vim'

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

" Indent settings.
set expandtab
set tabstop=2
set shiftwidth=2

" Custom key maps.
nmap <silent> \w      :tabnext<CR>
nmap <silent> \q      :tabprev<CR>
nmap <silent> \t      :tabnew<CR>
nmap <silent> \<S-T>  :tab split<CR>
nmap <silent> \e      :NERDTreeToggle<CR>
" Yunk to the system clipboard.
map  <silent> \c      "+y
" Paste from the system clipboard.
map  <silent> \v      "+p
map  <silent> \V      "+P

" Load local settings.
if filereadable(glob('~/.config/nvim/local.vim'))
  source ~/.config/nvim/local.vim
endif

