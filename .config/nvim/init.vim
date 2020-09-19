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
Plug 'junegunn/gv.vim'
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
" Stylus syntax highlight
Plug 'iloginow/vim-stylus'
" Async task runner
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" REPL helper
Plug 'jpalardy/vim-slime'
" LSC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
" Movement helper
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/vim-edgemotion'
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
" DB client
Plug 'tpope/vim-dadbod'
" Dotenv support
Plug 'tpope/vim-dotenv'
" emmet
Plug 'mattn/emmet-vim'
" various helpers
Plug 'tpope/vim-unimpaired'
" yanked buffer
Plug 'gitusp/yanked-buffer'
" elm syntax
Plug 'andys8/vim-elm-syntax'
" test runner
Plug 'vim-test/vim-test'
" Project settings
Plug 'tpope/vim-projectionist'

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
" Search settings
set ignorecase
set smartcase
set inccommand=nosplit
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
set cursorline
set cursorcolumn

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
" edgemotion
map                     <C-J>      <Plug>(edgemotion-j)
map                     <C-K>      <Plug>(edgemotion-k)
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
nnoremap <silent>       gl         :CocList -I grep --hidden -g !.git -smartcase<CR>
nnoremap <silent>       gL         :CocList -I grep --hidden -g !.git -smartcase -word<CR>
nmap                    gs         <Plug>SlimeMotionSend
nmap                    gss        <Plug>SlimeLineSend
nnoremap <silent>       K          :call <SID>ShowDocumentation()<CR>
nmap     <silent>       [g         <Plug>(coc-diagnostic-prev)
nmap     <silent>       ]g         <Plug>(coc-diagnostic-next)
nnoremap <silent>       <C-L>      :nohlsearch<Bar>call sneak#util#removehl()<CR><C-L>
nmap     <silent>       <C-N>      <Plug>(coc-rename)
nnoremap <silent>       <C-P>      :CocList files --hidden -g !.git --files<CR>
nmap                    <C-W>Q     <Plug>(yanked-buffer-p)
nmap     <silent>       <Space>    <Plug>(coc-codeaction)
" NOTE: <BS> = <C-8>
nnoremap <silent>       <BS>       :Rg --hidden -g !.git -smartcase -word <C-R><C-W><CR>
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
imap     <silent>       <C-x><CR>  <plug>(emmet-expand-abbr)

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
  " code formatting
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,json,scss setl formatexpr=CocAction('formatSelected')
  " HACK: for that coc.preferences.formatOnSaveFiletypes does not work on json
  autocmd BufWritePre *.json try | undojoin | catch | endtry | Format
  " code highlight
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " custom events
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " try to load local dotenv
  autocmd VimEnter * try | Dotenv .env.local | catch | endtry
augroup END

"
" Custom commands
"
command! -nargs=0                             OrganizeImport call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0                             Format         call CocAction('format')
command! -nargs=?                             Fold           call CocAction('fold', <f-args>)
command! -nargs=0                             Tsc            call CocAction('runCommand', 'tsserver.watchBuild') | copen
command! -nargs=0                             Wiki           e ~/wiki/index.md
command! -nargs=0                             Diary          exe 'e ~/wiki/diary/' . strftime('%Y-%m-%d') . '.md'
command! -nargs=0                             Mru            CocList mru
command! -nargs=+ -complete=custom,s:GrepArgs Rg             exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-smartcase', '-ignorecase', '-literal', '-word', '-regex',
        \ '-skip-vcs-ignores', '-extension', '--hidden']
  return join(list, "\n")
endfunction

"
" cabbrev
"
cabbrev D  <C-R>=<SID>IsFirstCharOfColonCmd() ? 'Diary'                           : 'D'<CR>
cabbrev M  <C-R>=<SID>IsFirstCharOfColonCmd() ? 'Mru'                             : 'M'<CR>
cabbrev R  <C-R>=<SID>IsFirstCharOfColonCmd() ? 'Rg --hidden -g !.git -smartcase' : 'R'<CR>
cabbrev Rg <C-R>=<SID>IsFirstCharOfColonCmd() ? 'Rg --hidden -g !.git -smartcase' : 'Rg'<CR>

function! s:IsFirstCharOfColonCmd()
 return getcmdtype() == ':' && getcmdpos() == 1
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

"
" Emmet settings
"
let g:user_emmet_leader_key = '<Plug>'

"
" test runner
"
let test#strategy = "neovim"
