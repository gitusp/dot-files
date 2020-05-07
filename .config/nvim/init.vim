"
" Begin plugin section.
"
call plug#begin()

" Theme
Plug 'romainl/flattened'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Python syntax highlight
Plug 'vim-python/python-syntax'
" JavaScript syntax highlight
Plug 'yuezk/vim-js'
" TypeScript syntax highlight
Plug 'HerringtonDarkholme/yats.vim'
" JSX/TSX syntax highlight
Plug 'maxmellon/vim-jsx-pretty'
" Pug syntax highlight
Plug 'digitaltoad/vim-pug'
" Load editorconfig.
Plug 'editorconfig/editorconfig-vim'
" Open required files by `gf`.
Plug 'moll/vim-node'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'
" Text alignment - e.g. TableFormat
Plug 'godlygeek/tabular'
" Markdown support
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/vim-xmark', { 'do': 'make' }
" Comment out/in
Plug 'tomtom/tcomment_vim'
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
" Highlight trailing spaces
Plug 'ntpeters/vim-better-whitespace'
" Powerful matcher
Plug 'andymass/vim-matchup'
" Local vimrc
Plug 'embear/vim-localvimrc'
" Stylus syntax highlight
Plug 'iloginow/vim-stylus'
" Async task runner
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" REPL helper
Plug 'jpalardy/vim-slime'
" LSC
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Highlight yanked region
Plug 'machakann/vim-highlightedyank'
" Interactive scratch pad
Plug 'metakirby5/codi.vim'
" Additional text objects
Plug 'wellle/targets.vim'
" Quickfix helper
Plug 'itchyny/vim-qfedit'
" Haskell dev env
Plug 'parsonsmatt/intero-neovim'
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
" peek register
Plug 'junegunn/vim-peekaboo'
" Movement helper
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/vim-edgemotion'
" Display colors in code
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Snippets definitions
Plug 'honza/vim-snippets'
" Rest client
Plug 'diepm/vim-rest-console'
" Table mode
Plug 'dhruvasagar/vim-table-mode'
" exchange operator
Plug 'tommcdo/vim-exchange'
" repeat helper
Plug 'tpope/vim-repeat'

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme flattened_light
let g:airline_theme='solarized'
set updatetime=300
set hidden
set clipboard=unnamedplus
" Search settings
set ignorecase
set smartcase
set inccommand=split
set wildignorecase
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
set dictionary+=/usr/share/dict/words
set showtabline=0
set diffopt+=iwhite

"
" Color settings
"
highlight CocErrorSign    guifg=#dc322f
highlight CocWarningSign  guifg=#b58900
highlight CocInfoSign     guifg=#268bd2
highlight CocHintSign     guifg=#859900
highlight Sneak           guifg=#fdf6e3 guibg=#d33682
highlight ExtraWhitespace guibg=#dc322f

"
" Custom mappings
"
" Normal mode - normal assignments
nnoremap                Y          y$
nnoremap                Q          @q
nnoremap                _          @:
nmap     <silent>       g=         <Plug>(coc-format-selected)
nmap     <silent>       g==        V<Plug>(coc-format-selected)
nmap     <silent>       gd         <Plug>(coc-definition)
nmap     <silent>       gi         <Plug>(coc-implementation)
nmap     <silent>       gr         <Plug>(coc-references)
nmap     <silent>       gy         <Plug>(coc-type-definition)
nmap                    ghp        <Plug>(GitGutterPreviewHunk)
nmap                    ghs        <Plug>(GitGutterStageHunk)
nmap                    ghu        <Plug>(GitGutterUndoHunk)
nnoremap <silent>       gG         :tab Gstatus<CR>
nnoremap <silent>       gl         :CocList -I --ignore-case lines<CR>
nnoremap <silent>       gL         :CocList -I grep --hidden -g !.git -smartcase<CR>
nmap                    gs         <Plug>SlimeMotionSend
nmap                    gss        <Plug>SlimeLineSend
nnoremap <silent>       yod        :set diffopt<C-R>=&diffopt =~ 'iwhite' ? '-' : '+'<CR>=iwhite<CR>
nnoremap <silent>       yos        :<C-R>=&spell ? 'setlocal nospell' : 'setlocal spell spelllang=en_us'<CR><CR>
nnoremap <silent>       yow        :<C-R>=&wrap ? 'setlocal nowrap' : 'setlocal wrap'<CR><CR>
nnoremap <silent>       K          :call <SID>ShowDocumentation()<CR>
nmap     <silent>       [d         <Plug>(coc-diagnostic-prev)
nmap     <silent>       ]d         <Plug>(coc-diagnostic-next)
nmap     <silent>       [f         -k<CR>
nmap     <silent>       ]f         -j<CR>
nnoremap <silent>       [q         :cprevious<CR>
nnoremap <silent>       ]q         :cnext<CR>
nnoremap <silent>       [Q         :cfirst<CR>
nnoremap <silent>       ]Q         :clast<CR>
nnoremap <silent>       [<C-Q>     :colder<CR>
nnoremap <silent>       ]<C-Q>     :cnewer<CR>
nnoremap <silent>       [l         :lprevious<CR>
nnoremap <silent>       ]l         :lnext<CR>
nnoremap <silent>       [L         :lfirst<CR>
nnoremap <silent>       ]L         :llast<CR>
nnoremap <silent>       [<C-L>     :lolder<CR>
nnoremap <silent>       ]<C-L>     :lnewer<CR>
nmap     <silent>       [<Space>   <Plug>unimpairedBlankUp
nmap     <silent>       ]<Space>   <Plug>unimpairedBlankDown
nnoremap <silent>       <C-H>      :CocList mru<CR>
map                     <C-J>      <Plug>(edgemotion-j)
map                     <C-K>      <Plug>(edgemotion-k)
nnoremap <silent>       <C-L>      :nohlsearch<Bar>call sneak#util#removehl()<CR><C-L>
nmap     <silent>       <C-N>      <Plug>(coc-rename)
nnoremap <silent>       <C-P>      :CocList files --hidden -g !.git --files<CR>
nnoremap <silent>       <C-Q>      <C-W><C-Q>
nnoremap <silent>       <Space>    :w<CR>
" NOTE: <BS> = <C-8>
nnoremap <silent>       <BS>       :Rg --hidden -g !.git -smartcase -word <C-R><C-W><CR>
nmap     <silent><expr> <CR>       <SID>ShouldThroughCR() ? '<CR>' : '<Plug>(coc-codeaction)'
" selections ranges.
nmap     <silent>       +          <Plug>(coc-range-select)
" Visual mode
xmap     <silent>       g=         <Plug>(coc-format-selected)
xmap                    gs         <Plug>SlimeRegionSend
" Introduce function text object
xmap                    if         <Plug>(coc-funcobj-i)
xmap                    af         <Plug>(coc-funcobj-a)
" selections ranges.
xmap     <silent>       +          <Plug>(coc-range-select)
" Operator pending mappings
omap                    if         <Plug>(coc-funcobj-i)
omap                    af         <Plug>(coc-funcobj-a)
" Terminal mode
tnoremap                <Esc>      <C-\><C-N>
" Insert mode
inoremap <silent><expr> <c-space>  coc#refresh()
inoremap <silent><expr> <c-y>      pumvisible() ? coc#_select_confirm() : '<c-y>'

function! s:ShouldThroughCR()
  if &buftype ==# 'quickfix'
    return 1
  endif

  if bufname('%') ==# '[Command Line]'
    return 1
  endif

  return 0
endfunction

function! s:ShowDocumentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"
" Thanks for https://github.com/tpope/vim-unimpaired
"
function! s:BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>unimpairedBlankUp", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>unimpairedBlankDown", a:count)
endfunction

nnoremap <silent> <Plug>unimpairedBlankUp   :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> <Plug>unimpairedBlankDown :<C-U>call <SID>BlankDown(v:count1)<CR>

"
" autocmd
"
augroup vimrc
  autocmd!
  " code formatting
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,json,scss setl formatexpr=CocAction('formatSelected')
  " HACK: for that coc.preferences.formatOnSaveFiletypes does not work on json
  autocmd BufWritePre *.json try | undojoin | catch | endtry | Format
  " code highlight
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " custom events
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

"
" Custom commands
"
command! -nargs=0                             OrganizeImport      call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0                             Format              call CocAction('format')
command! -nargs=?                             Fold                call CocAction('fold', <f-args>)
command! -nargs=0                             Tsc                 call CocAction('runCommand', 'tsserver.watchBuild')
command! -nargs=0                             Wiki                e ~/wiki/index.md
command! -nargs=0                             Diary               exe 'e ~/wiki/diary/' . strftime('%Y-%m-%d') . '.md'
command! -nargs=1 -complete=custom,s:EditArgs Edit                call <SID>Edit(<f-args>)
command! -nargs=+ -complete=custom,s:GrepArgs Rg                  exe 'CocList grep '.<q-args>

function! s:EditArgs(...)
  let list = ['component', 'container', 'styles']
  return join(list, "\n")
endfunction

function! s:GrepArgs(...)
  let list = ['-smartcase', '-ignorecase', '-literal', '-word', '-regex',
        \ '-skip-vcs-ignores', '-extension', '--hidden']
  return join(list, "\n")
endfunction

"
" cabbrev
"
cabbrev D <C-R>=<SID>IsFirstCharOfColonCmd() ? 'Diary'                           : 'D'<CR>
cabbrev E <C-R>=<SID>IsFirstCharOfColonCmd() ? 'Edit'                            : 'E'<CR>
cabbrev F <C-R>=<SID>IsFirstCharOfColonCmd() ? 'Flog'                            : 'F'<CR>
cabbrev R <C-R>=<SID>IsFirstCharOfColonCmd() ? 'Rg --hidden -g !.git -smartcase' : 'R'<CR>
cabbrev W <C-R>=<SID>IsFirstCharOfColonCmd() ? 'Wiki'                            : 'W'<CR>

function! s:IsFirstCharOfColonCmd()
 return getcmdtype() == ':' && getcmdpos() == 1
endfunction

function! s:Edit(type)
  let l:path = expand('%:p')
  let l:dir = 'component\|container'
  let l:ext = '.module.scss$\|.tsx$'

  if l:path =~ l:dir && l:path =~ l:ext
    if a:type ==# 'component'
      exe 'e ' . substitute(substitute(l:path, l:dir, 'component', ''), l:ext, '.tsx', '')
    elseif a:type ==# 'container'
      exe 'e ' . substitute(substitute(l:path, l:dir, 'container', ''), l:ext, '.tsx', '')
    elseif a:type ==# 'styles'
      exe 'e ' . substitute(substitute(l:path, l:dir, 'component', ''), l:ext, '.module.scss', '')
    else
      echoerr 'invalid argument'
    endif
  else
    echoerr 'invalid path'
  endif
endfunction

"
" Sandwich settings
"
runtime macros/sandwich/keymap/surround.vim

"
" Sneak settings
"
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

"
" Slime settings
"
let g:slime_target = "neovim"
let g:slime_no_mappings = 1

" Rest Console Settings
let g:vrc_curl_opts = {
      \ '-sS': '',
      \ '-i': '',
    \}

"
" matchup settings
"
let g:matchup_matchparen_offscreen = {}

"
" Table mode settings
"
let g:table_mode_corner='|'

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
" Markdown settings
"
let g:vim_markdown_no_extensions_in_markdown = 1

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
" Dirvish settings
"
let g:dirvish_relative_paths = 1
