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
Plug 'iamcco/markdown-preview.vim'
" Fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" auto close
Plug 'jiangmiao/auto-pairs'
" utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Snippets
Plug 'SirVer/ultisnips'
" Better substitution(currently not supporting live preview)
Plug 'tpope/vim-abolish'
" Minimalist's better netrw
Plug 'justinmk/vim-dirvish'
" History util
Plug 'mbbill/undotree'
" Fancy start screen
Plug 'mhinz/vim-startify'
" Dockerfile syntax
Plug 'ekalinin/Dockerfile.vim'
" Terminal command editing in the vim way
Plug 'gitusp/tedit.vim'
" CSV Support
Plug 'mechatroner/rainbow_csv'
" nginx conf file syntax
Plug 'chr4/nginx.vim'
" Unified interface test runner
Plug 'janko-m/vim-test'
" auto save
Plug '907th/vim-auto-save'
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

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme Tomorrow-Night
" Search settings
set ignorecase
set smartcase
set inccommand=nosplit
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
set noshowmode
set lazyredraw
set shortmess+=c
" Other settings
set hidden
set completeopt=noinsert,menuone,noselect

"
" Custom mappings
"
let mapleader = ' '
" Normal mode - normal assignments
nmap              <C-J>         <C-M>
nnoremap          Y             y$
nnoremap          Q             @q
nnoremap          _             @:
nnoremap <silent> [a            :ALEPreviousWrap<CR>
nnoremap <silent> ]a            :ALENextWrap<CR>
nnoremap <silent> [A            :ALEFirst<CR>
nnoremap <silent> ]A            :ALELast<CR>
nnoremap <silent> [b            :bprevious<CR>
nnoremap <silent> ]b            :bnext<CR>
nnoremap <silent> [B            :bfirst<CR>
nnoremap <silent> ]B            :blast<CR>
nnoremap <silent> [q            :cprevious<CR>
nnoremap <silent> ]q            :cnext<CR>
nnoremap <silent> [Q            :cfirst<CR>
nnoremap <silent> ]Q            :clast<CR>
nnoremap <silent> [t            :tabprevious<CR>
nnoremap <silent> ]t            :tabnext<CR>
nnoremap <silent> [T            :tabfirst<CR>
nnoremap <silent> ]T            :tablast<CR>
nnoremap <silent> <C-L>         :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <silent> z<Space>      :call IwhiteToggle()<CR>
" Normal mode - mappings with <Leader>
nnoremap <silent> <Leader>b     :Buffers<CR>
nnoremap <silent> <Leader>c     :Commands<CR>
nnoremap <silent> <Leader>f     :ALEFix<CR>
nnoremap <silent> <Leader>h     :History<CR>
nnoremap <silent> <Leader>gd    :Gdiff<CR>
nnoremap <silent> <Leader>gs    :Gstatus<CR>
nnoremap <silent> <Leader>gv    :GV --all<CR>
nnoremap <silent> <Leader>l     :BLines<CR>
nnoremap <silent> <Leader>tl    :TestLast<CR>
nnoremap <silent> <Leader>tn    :TestNearest<CR>
nnoremap <silent> <Leader>ut    :UndotreeToggle<CR>
nmap              <Leader><Tab> <Plug>(fzf-maps-n)
" Terminal mode
tnoremap          <Esc>         <C-\><C-N>
tnoremap          <C-J>         <C-M>
" Command line mode(excerpt from rsi.vim)
cnoremap          <C-A>         <Home>
cnoremap          <C-B>         <Left>
cnoremap <expr>   <C-D>         getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr>   <C-F>         getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
" Insert mode
imap              <C-J>         <C-M>
imap              <C-X><C-L>    <Plug>(fzf-complete-line)

"
" autocmd
"
augroup vimrc
  autocmd!
  autocmd BufEnter *  call ncm2#enable_for_buffer()
  autocmd TermOpen *  startinsert
  autocmd FileType go nnoremap <silent><buffer> K  :call LanguageClient#textDocument_hover()<CR>
  autocmd FileType go nnoremap <silent><buffer> gd :call LanguageClient#textDocument_definition()<CR>
  autocmd FileType go setlocal noexpandtab
augroup END

"
" Custom commands
"
command! -nargs=? Scratch call Scratchf('<args>')

"
" AutoPairs Settings
"
" Change mapping since it conflicts with paste from `system clipboard`.
let g:AutoPairsShortcutToggle = '<M-q>'

"
" Snips
"
" Completor Integration
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-F>'
let g:UltiSnipsJumpBackwardTrigger = '<C-B>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

"
" ALE settings
"
let g:ale_sign_column_always = 1
let g:ale_sign_warning = '──'
let g:ale_sign_error = '══'

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
" Toggle diffopt
"
function! IwhiteToggle()
 if &diffopt =~ 'iwhite'
   set diffopt-=iwhite
 else
   set diffopt+=iwhite
 endif
endfunction

"
" Opens scratch file
"
function! Scratchf(name)
  if a:name == '.'
    edit .scratch.md
  else
    execute 'e ' . system('scratchf ' . a:name)
  endif
endfunction

"
" Tedit settings
"
let g:tedit_prompt_regex = '^\$ \?'
" NOTE: .zhistory has tricky encoding.
let g:tedit_history_loader = 'cat ~/.zhistory | perl -pe ''s/^.*?;//; s/\x83(.)/chr(ord($1)^32)/eg'''

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

