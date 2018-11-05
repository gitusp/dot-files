"
" Begin plugin section.
"
call plug#begin()

" Colorscheme
Plug 'chriskempson/vim-tomorrow-theme'
" Syntax checker
Plug 'w0rp/ale'
" Javascript syntax highlight
Plug 'pangloss/vim-javascript'
" Pug syntax highlight
Plug 'digitaltoad/vim-pug'
" Load editorconfig.
Plug 'editorconfig/editorconfig-vim'
" Open required files by `gf`.
Plug 'moll/vim-node'
" Enable plugin command repeat
Plug 'tpope/vim-repeat'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" Text alignment - e.g. TableFormat
Plug 'godlygeek/tabular'
" Markdown support
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/vim-xmark', { 'do': 'make' }
" Fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Comment out/in
Plug 'tpope/vim-commentary'
" Text Surrounding
Plug 'machakann/vim-sandwich'
" Snippets
Plug 'SirVer/ultisnips'
" Better substitution(currently not supporting live preview)
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
" Register util
Plug 'junegunn/vim-peekaboo'
" auto save
Plug '907th/vim-auto-save'
" word switcher
Plug 'AndrewRadev/switch.vim'
" Auto pairing
Plug 'cohama/lexima.vim'
" Guide key
Plug 'liuchengxu/vim-which-key'
" Align helper
Plug 'junegunn/vim-easy-align'
" Async task runner
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" Highlight trailing spaces
Plug 'ntpeters/vim-better-whitespace'
" Powerful matcher
Plug 'andymass/vim-matchup'
" Extended text objects
Plug 'wellle/targets.vim'

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme Tomorrow-Night-Bright
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
" Other settings
set hidden
set completeopt=noinsert,menuone,noselect

"
" Custom mappings
"
" Normal mode - normal assignments
nnoremap          Y             y$
nnoremap          Q             @q
nnoremap          _             @:
nnoremap <silent> [a            :ALEPreviousWrap<CR>
nnoremap <silent> ]a            :ALENextWrap<CR>
nnoremap <silent> [A            :ALEFirst<CR>
nnoremap <silent> ]A            :ALELast<CR>
" NOTE: `q` stands for 'quickfix'
nnoremap <silent> [q            :cprevious<CR>
nnoremap <silent> ]q            :cnext<CR>
nnoremap <silent> [Q            :cfirst<CR>
nnoremap <silent> ]Q            :clast<CR>
nnoremap <silent> <C-L>         :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" Normal mode - mappings with <Meta>
nnoremap <silent> <M-a>         :Switch<CR>
nnoremap <silent> <M-x>         :SwitchReverse<CR>
nnoremap <silent> <M-i>         :call <SID>SuperJump("1\<C-I>")<CR>
nnoremap <silent> <M-o>         :call <SID>SuperJump("\<C-O>")<CR>
" Terminal mode
tnoremap          <Esc>         <C-\><C-N>
" Insert mode
imap              <C-X><C-L>    <Plug>(fzf-complete-buffer-line)

"
" autocmd
"
augroup vimrc
  autocmd!
  autocmd BufEnter *              call ncm2#enable_for_buffer()
  autocmd BufEnter *              if &filetype ==# 'markdown' | call <SID>RegisterMarkdownWhichKey() | endif
  autocmd TermOpen *              startinsert
  autocmd BufEnter COMMIT_EDITMSG startinsert
  autocmd FileType go             setlocal noexpandtab
  autocmd FileType go             nnoremap <silent><buffer> K  :call LanguageClient#textDocument_hover()<CR>
  autocmd FileType go             nnoremap <silent><buffer> gd :call LanguageClient#textDocument_definition()<CR>
  autocmd FileType help           nnoremap <silent><buffer> q  :q<CR>
  autocmd FileType which_key      set laststatus=0 noshowmode | autocmd BufLeave <buffer> set laststatus=2 showmode
augroup END

function! s:RegisterMarkdownWhichKey()
  let g:which_key_map.a.t = ['TableFormat', 'Format Table']
  let g:which_key_map.m = {
        \ 'name': '+markdown-preview',
        \ 'c': ['Xmark!', 'Close'],
        \ 'o': ['Xmark',  'Open'],
        \ 'h': ['Xmark<', 'Left'],
        \ 'j': ['Xmark-', 'Bottom'],
        \ 'k': ['Xmark+', 'Top'],
        \ 'l': ['Xmark>', 'Right'],
        \ }
  autocmd BufLeave <buffer> if has_key(g:which_key_map.a, 't') | unlet g:which_key_map.a.t | endif
  autocmd BufLeave <buffer> if has_key(g:which_key_map, 'm') | unlet g:which_key_map.m | endif
endfunction

"
" Custom commands
"
command!       -nargs=? Note call <SID>Notef('<args>')
command!       -nargs=0 ToggleIwhite call <SID>ToggleIwhite()
command! -bang -nargs=* WAg call fzf#vim#ag(<q-args>, '--word-regexp', <bang>0)

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
" ALE settings
"
let g:ale_sign_column_always = 1
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
highlight ALEErrorSign ctermfg=9
highlight ALEWarningSign ctermfg=11

" Linters
" Setup tips:
" eslint: Install `eslint` project-locally while install `eslint-cli` globally.
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
" Faster go linter
call ale#linter#Define('go', {
\   'name': 'revive',
\   'output_stream': 'both',
\   'executable': 'revive',
\   'read_buffer': 0,
\   'command': 'revive %t',
\   'callback': 'ale#handlers#unix#HandleAsWarning',
\})

" Fixers
let g:ale_fixers = {
\   'go': ['goimports'],
\   'javascript': ['prettier', 'eslint'],
\}

"
" LSP Settings
"
let g:LanguageClient_serverCommands = {
  \ 'go': ['go-langserver', '-gocodecompletion'],
  \ }
let g:LanguageClient_autoStart = 1

"
" Javascript settings
"
let g:javascript_plugin_jsdoc = 1

"
" Markdown settings
"
" NOTE: To avoid conflicting
map <Plug> <Plug>Markdown_MoveToCurHeader

"
" Auto save settings
"
let g:auto_save = 1
let g:auto_save_silent = 1

"
" Test settings
"
let test#go#gotest#options = '-v'
let test#strategy = "neovim"

"
" nvr settings
"
let $VISUAL = 'nvr -cc split --remote-wait --remote-send i'

"
" matchup settings
"
let g:matchup_transmute_enabled = 1

"
" which key
"
nnoremap <silent> <Space> :WhichKey '<Space>'<CR>
xnoremap <silent> <Space> :WhichKeyVisual '<Space>'<CR>
call which_key#register('<Space>', "g:which_key_map")
let g:which_key_map =  {}
let g:which_key_map.a = {
      \ 'name': '+auto-format',
      \ 'a': ['<Plug>(EasyAlign)', 'Align'],
      \ 'f': ['ALEFix',            'Fix'],
      \ }
let g:which_key_map.d = {
      \ 'name': '+diff',
      \ 'i': ['ToggleIwhite', 'Toggle iwhite for diffopt'],
      \ 'o': ['diffoff',      'Diff Off'],
      \ 't': ['diffthis',     'Diff This'],
      \ }
let g:which_key_map.f = {
      \ 'name': '+fzf',
      \ 'b': ['Buffers',  'Buffers'],
      \ 'c': ['Commands', 'Commands'],
      \ 'f': ['Files',    'Files'],
      \ 'g': ['GFiles',   'Git Files'],
      \ 'h': ['History',  'File History'],
      \ ':': ['History:', 'Command History'],
      \ '/': ['History/', 'Search History'],
      \ 'l': ['BLines',   'Buffer Lines'],
      \ }
let g:which_key_map.g = {
      \ 'name': '+git',
      \ 'c': ['Gcommit',              'Commit'],
      \ 'd': ['Gdiff',                'Diff'],
      \ 'p': ['Gpush origin HEAD',    'Push'],
      \ 'P': ['Gpush -f origin HEAD', 'Force Push'],
      \ 'r': ['Gread',                'Read'],
      \ 's': ['Gstatus',              'Status'],
      \ 'v': ['GV',                   'Visual Log'],
      \ 'V': ['GV --all',             'Visual Log (all)'],
      \ 'w': ['Gwrite',               'Write'],
      \ }
let g:which_key_map.t = {
      \ 'name': '+test',
      \ 'l': ['TestLast',     'Last'],
      \ 'n': ['TestNearest',  'Nearest'],
      \ }
let g:which_key_map.u = {
      \ 'name': '+utils',
      \ 'n': ['Note .',         'Open Local Note'],
      \ 'N': ['Note',           'Open Global Note'],
      \ 's': ['set spell!',     'Toggle Spell Check'],
      \ 't': ['terminal',       'Open Terminal'],
      \ 'u': ['UndotreeToggle', 'Undo Tree Toggle'],
      \ }

"
" word switcher settings
"
let g:switch_mapping = ""
let g:switch_custom_definitions = [
\   ['foo', 'bar', 'baz', 'qux', 'quux', 'corge', 'grault', 'garply', 'waldo', 'fred', 'plugh', 'xyzzy', 'thud']
\ ]

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
" Opens note file
"
function! s:Notef(name)
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
      let lastBufnr = currentBufnr
      if &filetype != 'dirvish'
        break
      endif
    endif
    let i += 1
  endwhile
endfunction

