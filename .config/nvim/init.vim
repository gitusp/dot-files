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
" NOTE: `q` stands for 'quickfix'
nnoremap <silent> [q            :cprevious<CR>
nnoremap <silent> ]q            :cnext<CR>
nnoremap <silent> [Q            :cfirst<CR>
nnoremap <silent> ]Q            :clast<CR>
nnoremap <silent> [t            :tabprevious<CR>
nnoremap <silent> ]t            :tabnext<CR>
nnoremap <silent> [T            :tabfirst<CR>
nnoremap <silent> ]T            :tablast<CR>
nnoremap <silent> <C-L>         :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <silent> z<Space>      :call <SID>IwhiteToggle()<CR>
" Normal mode - mappings with <Leader>
nmap              <Leader><Tab> <Plug>(fzf-maps-n)
nnoremap <silent> <Leader>af    :ALEFix<CR>
nnoremap <silent> <Leader>gc    :Gcommit<CR>
nnoremap <silent> <Leader>gd    :Gdiff<CR>
nnoremap <silent> <Leader>gr    :Gread<CR>
nnoremap <silent> <Leader>gs    :Gstatus<CR>
nnoremap <silent> <Leader>gv    :GV<CR>
nnoremap <silent> <Leader>gw    :Gwrite<CR>
nnoremap <silent> <Leader>fb    :Buffers<CR>
nnoremap <silent> <Leader>fc    :Commands<CR>
nnoremap <silent> <Leader>ff    :Files<CR>
nnoremap <silent> <Leader>fh    :History<CR>
nnoremap <silent> <Leader>f:    :History:<CR>
nnoremap <silent> <Leader>f/    :History/<CR>
nnoremap <silent> <Leader>fl    :BLines<CR>
nnoremap <silent> <Leader>tl    :TestLast<CR>
nnoremap <silent> <Leader>tn    :TestNearest<CR>
nnoremap <silent> <Leader>ut    :UndotreeToggle<CR>
" Normal mode - mappings with <Meta>
nnoremap <silent> <M-a>         :Switch<CR>
nnoremap <silent> <M-x>         :SwitchReverse<CR>
nnoremap <silent> <M-i>         :call <SID>SuperJump("1\<C-I>")<CR>
nnoremap <silent> <M-o>         :call <SID>SuperJump("\<C-O>")<CR>
" Terminal mode
tnoremap          <Esc>         <C-\><C-N>

"
" autocmd
"
augroup vimrc
  autocmd!
  autocmd BufEnter *              call ncm2#enable_for_buffer()
  autocmd TermOpen *              startinsert
  autocmd BufEnter COMMIT_EDITMSG startinsert
  autocmd FileType go             setlocal noexpandtab
  autocmd FileType go             nnoremap <silent><buffer> K  :call LanguageClient#textDocument_hover()<CR>
  autocmd FileType go             nnoremap <silent><buffer> gd :call LanguageClient#textDocument_definition()<CR>
  autocmd FileType help           nnoremap <silent><buffer> q  :q<CR>
augroup END

"
" Custom commands
"
command! -nargs=? Scratch call <SID>Scratchf('<args>')

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
" word switcher settings
"
let g:switch_mapping = ""
let g:switch_custom_definitions = [
\   ['foo', 'bar', 'baz', 'qux', 'quux', 'corge', 'grault', 'garply', 'waldo', 'fred', 'plugh', 'xyzzy', 'thud']
\ ]

"
" Toggle diffopt
"
function! s:IwhiteToggle()
 if &diffopt =~ 'iwhite'
   set diffopt-=iwhite
 else
   set diffopt+=iwhite
 endif
endfunction

"
" Opens scratch file
"
function! s:Scratchf(name)
  if a:name == '.'
    edit .scratch.md
  else
    execute 'e ' . system('scratchf ' . a:name)
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

