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
" Syntax checker
Plug 'vim-syntastic/syntastic'
" Javascript syntax highlight
Plug 'pangloss/vim-javascript'
" Grep
Plug 'mileszs/ack.vim'
" Surrounding helper
Plug 'tpope/vim-surround'

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme Tomorrow-Night-Bright
set ignorecase
set smartcase

"
" Search settings
"
" NOTE: This requires ag command.
" NOTE: To ignore files, put them in `.gitignore` or `.agignore`.
let g:ackprg = 'ag'

"
" Syntastic settings
"
" Add syntastic messages to statusline.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Symbols
let g:syntastic_error_symbol = '🌸'
let g:syntastic_style_error_symbol = '🌸'
let g:syntastic_warning_symbol = '🍀'
let g:syntastic_style_warning_symbol = '🍀'

" Remove background from error/warning signs.
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" General settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_loc_list_height = 5

"
" JavaScript settings
"
" NOTE: Install eslint project-locally, but install eslint-cli globally.
let g:syntastic_javascript_checkers=['eslint']

