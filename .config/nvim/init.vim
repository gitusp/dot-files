" Begin vim-plug section.
call plug#begin()

" List vim-plug packages.
Plug 'junegunn/seoul256.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'

" End vim-plug section.
call plug#end()

" Set color schema.
colo seoul256

" General settings.
set number
set ignorecase
set smartcase

" Indent settings.
set expandtab
set tabstop=2
set shiftwidth=2

" Custom key maps.
nmap <silent> \w :tabnext<CR>
nmap <silent> \q :tabprev<CR>
nmap <silent> \t :tabnew<CR>
