" Begin vim-plug section.
call plug#begin()

" List vim-plug packages.
Plug 'junegunn/seoul256.vim'
Plug 'ntpeters/vim-better-whitespace'

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

