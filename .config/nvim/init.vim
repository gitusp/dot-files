"
" Begin plugin section.
"
call plug#begin()

" Theme
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
" JavaScript syntax highlight
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" TypeScript syntax highlight
Plug 'HerringtonDarkholme/yats.vim'
" Pug syntax highlight
Plug 'digitaltoad/vim-pug'
" Load editorconfig.
Plug 'editorconfig/editorconfig-vim'
" Open required files by `gf`.
Plug 'moll/vim-node'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'
Plug 'sodapopcan/vim-twiggy'
" Text alignment - e.g. TableFormat
Plug 'godlygeek/tabular'
" Markdown support
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/vim-xmark', { 'do': 'make' }
" Comment out/in
Plug 'tpope/vim-commentary'
" Text Surrounding
Plug 'machakann/vim-sandwich'
" Case preserving substitution(currently not supporting live preview)
Plug 'tpope/vim-abolish'
" Minimalist's better netrw
Plug 'justinmk/vim-dirvish'
" History util
Plug 'mbbill/undotree'
" Dockerfile syntax
Plug 'ekalinin/Dockerfile.vim'
" CSV Support
Plug 'mechatroner/rainbow_csv'
" nginx conf file syntax
Plug 'chr4/nginx.vim'
" Unified interface test runner
Plug 'janko-m/vim-test'
" Support terraform
Plug 'hashivim/vim-terraform'
" word switcher
Plug 'AndrewRadev/switch.vim'
" Auto pairing
Plug 'cohama/lexima.vim'
" Guide key
Plug 'liuchengxu/vim-which-key'
" Highlight trailing spaces
Plug 'ntpeters/vim-better-whitespace'
" Powerful matcher
Plug 'andymass/vim-matchup'
" Local vimrc
Plug 'embear/vim-localvimrc'
" Grep helper
Plug 'mhinz/vim-grepper'
Plug 'wsdjeg/FlyGrep.vim'
" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': 'bash install.sh' }
" Stylus syntax highlight
Plug 'iloginow/vim-stylus'
" Async task runner
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" Readline style bindings
Plug 'tpope/vim-rsi'
" Motion helper
Plug 'unblevable/quick-scope'
" Indent guide
Plug 'Yggdroot/indentLine'
" REPL helper
Plug 'jpalardy/vim-slime'
" LSC
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Highlight yanked region
Plug 'machakann/vim-highlightedyank'
" Interactive scratch pad
Plug 'metakirby5/codi.vim'
" Notational
Plug 'Alok/notational-fzf-vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme one
set background=dark
set updatetime=300
set hidden
set clipboard=unnamedplus
" Search settings
set ignorecase
set smartcase
set inccommand=split
" Undo settings
set undodir=~/.config/nvim/undodir/
set undofile
" Default tab settings
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
" Display settings
set lazyredraw
set shortmess+=c
set shortmess+=I
set laststatus=2
set termguicolors
set noshowmode
set signcolumn=yes

"
" Color settings
"
highlight! link CocErrorSign ALEErrorSign
highlight! link CocInfoSign ALEWarningSign

"
" Custom mappings
"
" Normal mode - normal assignments
nnoremap                Y         y$
nnoremap                Q         @q
nnoremap                _         @:
nmap     <silent>       gd        <Plug>(coc-definition)
nmap                    gs        <plug>(GrepperOperator)
nnoremap <silent>       gsp       :FlyGrep<CR>
nnoremap <silent>       gss       :Grepper<CR>
nnoremap <silent>       K         :call <SID>ShowDocumentation()<CR>
nmap     <silent>       [d        <Plug>(coc-diagnostic-prev)
nmap     <silent>       ]d        <Plug>(coc-diagnostic-next)
nnoremap <silent>       [q        :cprevious<CR>
nnoremap <silent>       ]q        :cnext<CR>
nnoremap <silent>       [Q        :cfirst<CR>
nnoremap <silent>       ]Q        :clast<CR>
nnoremap <silent>       [l        :lprevious<CR>
nnoremap <silent>       ]l        :lnext<CR>
nnoremap <silent>       [L        :lfirst<CR>
nnoremap <silent>       ]L        :llast<CR>
nnoremap <silent>       <C-L>     :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <silent>       <Esc>     :w<CR>
" Normal mode - mappings with <Meta>
nnoremap <silent>       <M-a>     :Switch<CR>
nnoremap <silent>       <M-x>     :SwitchReverse<CR>
nnoremap <silent>       <M-i>     :call <SID>SuperJump("1\<C-I>")<CR>
nnoremap <silent>       <M-o>     :call <SID>SuperJump("\<C-O>")<CR>
" Visual mode
xmap                    gs        <plug>(GrepperOperator)
" Terminal mode
tnoremap                <Esc>     <C-\><C-N>
" Insert mode
inoremap <silent><expr> <c-space> coc#refresh()

function! s:ShowDocumentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"
" autocmd
"
augroup vimrc
  autocmd!
  autocmd BufEnter * if &filetype ==# 'markdown' | call <SID>HandleMarkdownBufEnter() | endif
  autocmd FileType which_key set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
  " convenient shortcuts
  autocmd FileType help,qf nnoremap <silent><buffer> q :q<CR>
  autocmd BufEnter * if @% =~ "^fugitive://" | nnoremap <silent><buffer> q :q<CR> | endif
  autocmd FileType dirvish nnoremap <silent><buffer> t :let $VIM_DIR=@%<CR>:terminal<CR>icd $VIM_DIR<CR><C-\><C-N>
  " code formatting
  autocmd FileType haskell,javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd BufWritePre *.hs,*.js,*.jsx,*.json,*.ts,*.tsx try | undojoin | catch | endtry | Format
  " code highlight
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " custom events
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

function! s:HandleMarkdownBufEnter()
  call <SID>RegisterMarkdownWhichKey()
  autocmd BufLeave <buffer> call <SID>ClearMarkdownWhichKey()
endfunction

function! s:RegisterMarkdownWhichKey()
  let g:which_key_map.f = {
        \ 'name': '+format',
        \ 't': ['TableFormat', 'Table'],
        \ }
  let g:which_key_map.m = {
        \ 'name': '+markdown-preview',
        \ 'c': [':Xmark!', 'Close'],
        \ 'o': ['Xmark',   'Open'],
        \ 'h': [':Xmark<', 'Left'],
        \ 'j': [':Xmark-', 'Bottom'],
        \ 'k': [':Xmark+', 'Top'],
        \ 'l': [':Xmark>', 'Right'],
        \ }
endfunction

function! s:ClearMarkdownWhichKey()
  if has_key(g:which_key_map, 'f') | unlet g:which_key_map.f | endif
  if has_key(g:which_key_map, 'm') | unlet g:which_key_map.m | endif
endfunction

"
" Custom commands
"
command! -nargs=0 ToggleIwhite        call <SID>ToggleIwhite()
command! -nargs=0 SwitchDiffAlgorithm call <SID>SwitchDiffAlgorithm()
command! -nargs=0 Format              call CocAction('format')
command! -nargs=? Fold                call CocAction('fold', <f-args>)

"
" Sandwich settings
"
runtime macros/sandwich/keymap/surround.vim

"
" Slime settings
"
let g:slime_target = "neovim"

"
" airline settings
"
" REF: https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/term.vim
function! ApplyInactiveTerminalStatusLine(...)
  if getbufvar(a:2.bufnr, '&buftype') == 'terminal'
    let spc = g:airline_symbols.space
    call a:1.add_section('airline_a', spc.'TERMINAL'.spc)
    call a:1.add_section('airline_b', spc.'%f')
    call a:1.split()
    call a:1.add_section('airline_z', '#%{b:terminal_job_id}'.spc)
    return 1
  endif
endfunction
call airline#add_inactive_statusline_func('ApplyInactiveTerminalStatusLine')
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

"
" lexima settings
"
let g:lexima_ctrlh_as_backspace	= 1
call lexima#add_rule({'char': '<', 'input_after': '>'})

"
" Javascript settings
"
let g:javascript_plugin_jsdoc = 1

"
" JSX settings
"
let g:jsx_ext_required = 1

"
" Notational settings
"
let g:nv_search_paths = ['~/.notational']

"
" Markdown settings
"
" NOTE: To avoid conflicting
map <Plug> <Plug>Markdown_MoveToCurHeader

"
" Test settings
"
let test#go#gotest#options = '-v'
let test#strategy = "neovim"

"
" nvr settings
"
let $VISUAL = 'nvr -cc split --remote-wait'

"
" which key
"
nnoremap <silent> <Space> :WhichKey '<Space>'<CR>
call which_key#register('<Space>', "g:which_key_map")
let g:which_key_map =  {}
let g:which_key_map.g = {
      \ 'name': '+git',
      \ 'd': ['Gdiff',  'Diff'],
      \ 'g': ['Flog',   'Graph'],
      \ 'm': ['Magit',  'Magit'],
      \ 'r': ['Gread',  'Read'],
      \ 't': ['Twiggy', 'Twiggy'],
      \ 'w': ['Gwrite', 'Write'],
      \ }
let g:which_key_map.l = {
      \ 'name': '+lsp',
      \ 'a': ['<Plug>(coc-codeaction)',      'Code Action'],
      \ 'f': ['<Plug>(coc-fix-current)',     'Fix Current'],
      \ 'i': ['<Plug>(coc-implementation)',  'Implementation'],
      \ 'l': ['CocList',                     'CocList'],
      \ 'r': ['<Plug>(coc-rename)',          'Rename'],
      \ 'R': ['<Plug>(coc-references)',      'References'],
      \ 't': ['<Plug>(coc-type-definition)', 'Type Definition'],
      \ 'y': [':CocList -A --normal yank',   'Yank List'],
      \ }
let g:which_key_map.s = {
      \ 'name': '+settings',
      \ 'a': ['SwitchDiffAlgorithm', 'Switch algorithm for diffopt'],
      \ 'i': ['ToggleIwhite',        'Toggle iwhite for diffopt'],
      \ 's': [':set spell!',         'Toggle Spell Check'],
      \ }
let g:which_key_map.t = {
      \ 'name': '+test',
      \ 'l': ['TestLast',    'Last'],
      \ 'n': ['TestNearest', 'Nearest'],
      \ }

"
" word switcher settings
"
let g:switch_mapping = ""
let g:switch_custom_definitions = [
\   ['foo', 'bar', 'baz', 'qux', 'quux', 'corge', 'grault', 'garply', 'waldo', 'fred', 'plugh', 'xyzzy', 'thud']
\ ]

"
" Grepper settings
"
let g:grepper = {
      \ 'rg':         { 'grepprg': 'rg --vimgrep --no-heading --smart-case --hidden --glob !.git --word-regexp' },
      \ 'rg-in-word': { 'grepprg': 'rg --vimgrep --no-heading --smart-case --hidden --glob !.git' },
      \ 'tools':      ['rg', 'rg-in-word'],
      \ 'quickfix':   0
      \ }

"
" Fuzzy finder
"
let g:ctrlp_user_command = 'rg %s --files --hidden --glob !.git'
let g:ctrlp_use_caching = 0
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

"
" Codi settings
"
let g:codi#interpreters = {
  \ 'typescript': {
    \ 'bin': ['npx', 'ts-node'],
    \ 'prompt': '^\(>\|\.\.\.\+\) ',
    \ },
  \ }

"
" Toggle diffopt
"
function! s:ToggleIwhite()
 if &diffopt =~ 'iwhite'
   set diffopt-=iwhite
 else
   set diffopt+=iwhite
 endif
endfunction

"
" Switch diff algorithm
"
function! s:SwitchDiffAlgorithm()
  let algorithms = ['myers', 'minimal', 'patience', 'histogram']
  if &diffopt !~ 'algorithm'
    " Set default algorithm
    set diffopt+=algorithm:myers
  endif
  let i = 0
  while i < len(algorithms)
    if &diffopt =~ 'algorithm:' . algorithms[i]
      let j = i == len(algorithms) - 1 ? 0 : i + 1
      execute 'set diffopt-=algorithm:' . algorithms[i]
      execute 'set diffopt+=algorithm:' . algorithms[j]
      echo 'algorithm:' . algorithms[j]
      break
    endif
    let i = i + 1
  endwhile
endfunction

"
" Jump to another file
"
function! s:SuperJump(key)
  let lastBufnr = bufnr('%')
  let i = 0
  while i < 256
    execute 'normal! ' . a:key
    let currentBufnr = bufnr('%')
    if currentBufnr != lastBufnr
      break
    endif
    let i += 1
  endwhile
endfunction

