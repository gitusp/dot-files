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
Plug 'leafgarland/typescript-vim'
" Pug syntax highlight
Plug 'digitaltoad/vim-pug'
" Load editorconfig.
Plug 'editorconfig/editorconfig-vim'
" Open required files by `gf`.
Plug 'moll/vim-node'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'jreybert/vimagit'
" Text alignment - e.g. TableFormat
Plug 'godlygeek/tabular'
" Markdown support
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/vim-xmark', { 'do': 'make' }
" Comment out/in
Plug 'tpope/vim-commentary'
" Text Surrounding
Plug 'machakann/vim-sandwich'
" Snippets
Plug 'SirVer/ultisnips'
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
" LSP Client
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
" Completion Manager
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-path'
" Register util
Plug 'junegunn/vim-peekaboo'
" word switcher
Plug 'AndrewRadev/switch.vim'
" Auto pairing
Plug 'tmsvg/pear-tree'
" Guide key
Plug 'liuchengxu/vim-which-key'
" Highlight trailing spaces
Plug 'ntpeters/vim-better-whitespace'
" Powerful matcher
Plug 'andymass/vim-matchup'
" Extended text objects
Plug 'wellle/targets.vim'
" Local vimrc
Plug 'embear/vim-localvimrc'
" Grep helper
Plug 'mhinz/vim-grepper'
" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': 'bash install.sh' }
" Code formatter
Plug 'sbdchd/neoformat'
" Stylus syntax highlight
Plug 'iloginow/vim-stylus'
" Async task runner
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" Readline style bindings
Plug 'tpope/vim-rsi'
" Motion helper
Plug 'unblevable/quick-scope'

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme one
set background=dark
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
set nofoldenable
set lazyredraw
set shortmess+=c
set shortmess+=I
set laststatus=2
set termguicolors
set noshowmode
" Other settings
set hidden
set completeopt=noinsert,menuone,noselect
set clipboard=unnamedplus

"
" Custom mappings
"
" Normal mode - normal assignments
nnoremap          Y             y$
nnoremap          Q             @q
nnoremap          _             @:
nmap              gs            <plug>(GrepperOperator)
nnoremap <silent> gss           :Grepper<CR>
nnoremap <silent> [q            :cprevious<CR>
nnoremap <silent> ]q            :cnext<CR>
nnoremap <silent> [Q            :cfirst<CR>
nnoremap <silent> ]Q            :clast<CR>
nnoremap <silent> [l            :lprevious<CR>
nnoremap <silent> ]l            :lnext<CR>
nnoremap <silent> [L            :lfirst<CR>
nnoremap <silent> ]L            :llast<CR>
nnoremap <silent> <C-L>         :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <silent> <Esc>         :w<CR>
" Normal mode - mappings with <Meta>
nnoremap <silent> <M-a>         :Switch<CR>
nnoremap <silent> <M-x>         :SwitchReverse<CR>
nnoremap <silent> <M-i>         :call <SID>SuperJump("1\<C-I>")<CR>
nnoremap <silent> <M-o>         :call <SID>SuperJump("\<C-O>")<CR>
" Visual mode
xmap              gs            <plug>(GrepperOperator)
" Terminal mode
tnoremap          <Esc>         <C-\><C-N>

"
" autocmd
"
augroup vimrc
  autocmd!
  autocmd BufEnter *              call ncm2#enable_for_buffer()
  autocmd BufEnter *              if &filetype ==# 'markdown' | call <SID>HandleMarkdownBufEnter() | endif
  autocmd FileType go             setlocal noexpandtab
  autocmd FileType which_key      set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
  " convenient shortcuts
  autocmd FileType help,qf        nnoremap <silent><buffer> q :q<CR>
  autocmd FileType dirvish        nnoremap <silent><buffer> t :let $VIM_DIR=expand('%')<CR>:terminal<CR>icd $VIM_DIR<CR><C-\><C-N>
  " LSP
  autocmd FileType go,haskell,javascript,javascript.jsx,typescript nnoremap <silent><buffer> K  :call LanguageClient#textDocument_hover()<CR>
  autocmd FileType go,haskell,javascript,javascript.jsx,typescript nnoremap <silent><buffer> gd :call LanguageClient#textDocument_definition()<CR>
  autocmd FileType go,haskell,javascript,javascript.jsx,typescript setlocal signcolumn=yes
  autocmd BufEnter * if index(['go', 'haskell', 'javascript', 'javascript.jsx', 'typescript'], &filetype) != -1 | call <SID>HandleLSPBufEnter() | endif
  " Neoformat
  autocmd BufWritePre *.json,*.js,*.ts,*.tsx try | undojoin | catch | endtry | Neoformat
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
        \ 'c': ['Xmark!', 'Close'],
        \ 'o': ['Xmark',  'Open'],
        \ 'h': ['Xmark<', 'Left'],
        \ 'j': ['Xmark-', 'Bottom'],
        \ 'k': ['Xmark+', 'Top'],
        \ 'l': ['Xmark>', 'Right'],
        \ }
endfunction

function! s:ClearMarkdownWhichKey()
  if has_key(g:which_key_map, 'f') | unlet g:which_key_map.f | endif
  if has_key(g:which_key_map, 'm') | unlet g:which_key_map.m | endif
endfunction

function! s:HandleLSPBufEnter()
  call <SID>RegisterLSPWhichKey()
  autocmd BufLeave <buffer> call <SID>ClearLSPWhichKey()
endfunction

function! s:RegisterLSPWhichKey()
  " TODO: Expand context menu
  let g:which_key_map.l = {
        \ 'name': '+LSP',
        \ 'c': ['call LanguageClient_contextMenu()', 'Context Menu'],
        \ }
endfunction

function! s:ClearLSPWhichKey()
  if has_key(g:which_key_map, 'l') | unlet g:which_key_map.l | endif
endfunction

"
" Custom commands
"
command!       -nargs=? Note                call <SID>Note('<args>')
command!       -nargs=0 ToggleIwhite        call <SID>ToggleIwhite()
command!       -nargs=0 SwitchDiffAlgorithm call <SID>SwitchDiffAlgorithm()

"
" Completor Integration
" See https://github.com/ncm2/ncm2-ultisnips/issues/6#issuecomment-410186456
"
inoremap <silent> <expr> <Tab> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand_or_jump_or_tab)")
inoremap <silent> <Plug>(ultisnips_expand_or_jump_or_tab) <C-R>=<SID>UltiSnipsExpandOrJumpOrTab()<CR>
snoremap <silent> <Tab> <Esc>:call UltiSnips#ExpandSnippetOrJump()<cr>
let g:UltiSnipsExpandTrigger       = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger  = "<Plug>(ultisnips_jump_forward)"
let g:UltiSnipsJumpBackwardTrigger = "<M-i>"

function! s:UltiSnipsExpandOrJumpOrTab()
  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return ""
  else
    return "\<Tab>"
  endif
endfunction

"
" Sandwich settings
"
runtime macros/sandwich/keymap/surround.vim

"
" pear-tree settings
"
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_pairs = {
  \ '(':   {'closer': ')'},
  \ '[':   {'closer': ']'},
  \ '{':   {'closer': '}'},
  \ "'":   {'closer': "'"},
  \ '"':   {'closer': '"'},
  \ '`':   {'closer': '`'},
  \ '```': {'closer': '```'},
  \ '<*>': {'closer': '</*>', 'not_like': '/\|=$', 'until': '[[:space:]]'}
  \ }

"
" LSP Settings
" TODO: Javascript Language Server
"
highlight ALEErrorSign ctermfg=9
highlight ALEWarningSign ctermfg=11
let g:LanguageClient_serverCommands = {
  \ 'go':         ['go-langserver', '-gocodecompletion'],
  \ 'haskell':    ['hie-wrapper', '--lsp'],
  \ 'typescript': ['javascript-typescript-stdio'],
  \ }
let g:LanguageClient_autoStart = 1

"
" Javascript settings
"
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

"
" JSX settings
"
let g:jsx_ext_required = 1

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
      \ 'd': ['Gdiff',                'Diff'],
      \ 'm': ['Magit',                'Magit'],
      \ 'p': ['Gpush origin HEAD',    'Push'],
      \ 'P': ['Gpush -f origin HEAD', 'Force Push'],
      \ 'r': ['Gread',                'Read'],
      \ 'v': ['GV',                   'Visual Log'],
      \ 'V': ['GV --all',             'Visual Log (all)'],
      \ 'w': ['Gwrite',               'Write'],
      \ }
let g:which_key_map.n = {
      \ 'name': '+note',
      \ 'g': ['Note',   'Open Global Note'],
      \ 'l': ['Note .', 'Open Local Note'],
      \ }
let g:which_key_map.s = {
      \ 'name': '+settings',
      \ 'a': ['SwitchDiffAlgorithm', 'Switch algorithm for diffopt'],
      \ 'i': ['ToggleIwhite',        'Toggle iwhite for diffopt'],
      \ 's': ['set spell!',          'Toggle Spell Check'],
      \ }
let g:which_key_map.t = {
      \ 'name': '+test',
      \ 'l': ['TestLast',     'Last'],
      \ 'n': ['TestNearest',  'Nearest'],
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
" Opens note file
"
function! s:Note(name)
  if a:name == '.'
    edit .note.md
  else
    execute 'e ' . system('notef ' . a:name)
  endif
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

