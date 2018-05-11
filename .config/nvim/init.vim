"
" Begin plugin section.
"
call plug#begin()

" Highlight trailing spaces.
Plug 'ntpeters/vim-better-whitespace'

" Colorscheme
Plug 'chriskempson/vim-tomorrow-theme'

" Better substitution
Plug 'tpope/vim-abolish'

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
" Set color schema.
colorscheme Tomorrow-Night-Bright

" Search settings
set ignorecase
set smartcase

