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
" CSV Support
Plug 'mechatroner/rainbow_csv'
" Unified interface test runner
Plug 'janko-m/vim-test'
" word switcher
Plug 'AndrewRadev/switch.vim'
" Auto pairing
Plug 'cohama/lexima.vim'
" Highlight trailing spaces
Plug 'ntpeters/vim-better-whitespace'
" Powerful matcher
Plug 'andymass/vim-matchup'
" Local vimrc
Plug 'embear/vim-localvimrc'
" Grep helper
Plug 'mhinz/vim-grepper'
Plug 'wsdjeg/FlyGrep.vim'
" Stylus syntax highlight
Plug 'iloginow/vim-stylus'
" Async task runner
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" Readline style bindings
Plug 'tpope/vim-rsi'
" Motion helper
Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak'
" REPL helper
Plug 'jpalardy/vim-slime'
" LSC
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Highlight yanked region
Plug 'machakann/vim-highlightedyank'
" Interactive scratch pad
Plug 'metakirby5/codi.vim'
" Very personal WiKi
Plug 'vimwiki/vimwiki'
" Additional text objects
Plug 'wellle/targets.vim'
" FZF
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Quickfix helper
Plug 'itchyny/vim-qfedit'

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
nnoremap <silent>       g?        :Gstatus<CR>
nmap                    gd        <Plug>(coc-definition)
nmap                    ghp       <Plug>GitGutterPreviewHunk
nmap                    ghs       <Plug>GitGutterStageHunk
nmap                    ghu       <Plug>GitGutterUndoHunk
nnoremap <silent>       gl        :BLines<CR>
nnoremap <silent>       gL        :Lines<CR>
nmap                    gs        <plug>(GrepperOperator)
nmap                    yca       <Plug>(coc-codeaction)
nmap                    ycf       <Plug>(coc-fix-current)
nmap                    yci       <Plug>(coc-implementation)
nmap                    ycr       <Plug>(coc-rename)
nmap                    ycR       <Plug>(coc-references)
nmap                    yct       <Plug>(coc-type-definition)
nnoremap <silent>       yob       :Buffers<CR>
nnoremap <silent>       yof       :GFiles<CR>
nnoremap <silent>       yoF       :Files<CR>
nnoremap <silent>       yqi       :VimwikiIndex<CR>
nnoremap <silent>       yqd       :VimwikiMakeDiaryNote<CR>
nnoremap <silent>       yrl       :TestLast<CR>
nnoremap <silent>       yrn       :TestNearest<CR>
nnoremap <silent>       K         :call <SID>ShowDocumentation()<CR>
nmap                    [d        <Plug>(coc-diagnostic-prev)
nmap                    ]d        <Plug>(coc-diagnostic-next)
nnoremap <silent>       [q        :cprevious<CR>
nnoremap <silent>       ]q        :cnext<CR>
nnoremap <silent>       [Q        :cfirst<CR>
nnoremap <silent>       ]Q        :clast<CR>
nnoremap <silent>       [l        :lprevious<CR>
nnoremap <silent>       ]l        :lnext<CR>
nnoremap <silent>       [L        :lfirst<CR>
nnoremap <silent>       ]L        :llast<CR>
nnoremap <silent>       <C-L>     :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <silent>       <Space>   :Commands<CR>
" Normal mode - mappings with <Meta>
nnoremap <silent>       <M-a>     :Switch<CR>
nnoremap <silent>       <M-x>     :SwitchReverse<CR>
nnoremap <silent>       <M-i>     :call <SID>SuperJump("1\<C-I>")<CR>
nnoremap <silent>       <M-o>     :call <SID>SuperJump("\<C-O>")<CR>
nmap                    <M-s>     <Plug>SlimeParagraphSend
" Visual mode
xmap                    gs        <plug>(GrepperOperator)
xmap                    <M-s>     <Plug>SlimeRegionSend
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
  " convenient shortcuts
  autocmd FileType help,qf nnoremap <silent><buffer> q :q<CR>
  " code formatting
  autocmd FileType haskell,javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd BufWritePre *.hs,*.js,*.jsx,*.json,*.ts,*.tsx try | undojoin | catch | endtry | Format
  " code highlight
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " custom events
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

"
" Custom commands
"
command! -nargs=0 ToggleIwhite call <SID>ToggleIwhite()
command! -nargs=0 Format       call CocAction('format')
command! -nargs=? Fold         call CocAction('fold', <f-args>)

"
" Sandwich settings
"
runtime macros/sandwich/keymap/surround.vim

"
" Slime settings
"
let g:slime_target = "neovim"
let g:slime_no_mappings = 1

"
" sneak settings
"
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

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
" FZF settings
"
" Add --hidden to the default `Rg` command.
command! -bang -nargs=* Rg  call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden ".shellescape(<q-args>), 1, <bang>0)
" Add --word-regexp to the customized version.
command! -bang -nargs=* Rgw call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --word-regexp ".shellescape(<q-args>), 1, <bang>0)

"
" lexima settings
"
let g:lexima_ctrlh_as_backspace	= 1

"
" Javascript settings
"
let g:javascript_plugin_jsdoc = 1

"
" JSX settings
"
let g:jsx_ext_required = 1

"
" Markdown settings
"
" NOTE: To avoid conflicting
map <Plug>Markdown_MoveToCurHeader <Plug>Markdown_MoveToCurHeader

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
      \ }

"
" FlyGrep
"
let g:spacevim_debug_level = 3

"
" Vimwiki
"
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
" Disable header level mappings
nmap <Plug>VimwikiRemoveHeaderLevel <Plug>VimwikiRemoveHeaderLevel
nmap <Plug>VimwikiAddHeaderLevel <Plug>VimwikiAddHeaderLevel

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

