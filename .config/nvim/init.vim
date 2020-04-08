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
" CSS in JS syntax highlight
" NOTE: Disabled since this plugin conflicts with other plugin.
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
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
" Motion helper
Plug 'unblevable/quick-scope'
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
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
" Display colors in code
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Snippets definitions
Plug 'honza/vim-snippets'
" Rest client
Plug 'diepm/vim-rest-console'
" Table mode
Plug 'dhruvasagar/vim-table-mode'

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

"
" Color settings
"
highlight! link CocErrorSign ALEErrorSign
highlight! link CocInfoSign ALEWarningSign
highlight! Sneak guifg=#fdf6e3 guibg=#d33682

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
nnoremap <silent>       gl         :BLines<CR>
nnoremap <silent>       gL         :R<CR>
nmap                    gs         <Plug>SlimeMotionSend
nmap                    gss        <Plug>SlimeLineSend
nmap     <silent>       ycc        <Plug>(coc-codeaction)
nmap     <silent>       ycf        <Plug>(coc-fix-current)
nmap     <silent>       ycr        <Plug>(coc-rename)
nnoremap <silent>       yob        :Buffers<CR>
nnoremap <silent>       yod        :e ~/wiki/diary/<C-R>=strftime("%Y-%m-%d")<CR>.md<CR>
nnoremap <silent>       yof        :GFiles<CR>
nnoremap <silent>       yoF        :Files<CR>
nnoremap <silent>       yoh        :History<CR>
nnoremap <silent>       yow        :e ~/wiki/index.md<CR>
nnoremap <silent>       K          :call <SID>ShowDocumentation()<CR>
nmap     <silent>       [d         <Plug>(coc-diagnostic-prev)
nmap     <silent>       ]d         <Plug>(coc-diagnostic-next)
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
nnoremap <silent>       <C-L>      :nohlsearch<Bar>call sneak#util#removehl()<CR><C-L>
nnoremap <silent>       <Space>    :Commands<CR>
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
imap                    <c-x><c-l> <plug>(fzf-complete-line)

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
  autocmd FileType javascript,typescript,json,scss setl formatexpr=CocAction('formatSelected')
  autocmd BufWritePre *.js,*.jsx,*.json,*.ts,*.tsx,*.scss try | undojoin | catch | endtry | Format
  " code highlight
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " custom events
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " CSS in JS Syntax Highlight
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
augroup END

"
" Custom commands
"
command! -nargs=0 ToggleDiffoptIwhite       call <SID>ToggleDiffoptIwhite()
command! -nargs=0 OrganizeImport            call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Format                    call CocAction('format')
command! -nargs=? Fold                      call CocAction('fold', <f-args>)
command! -nargs=0 Tsc                       call CocAction('runCommand', 'tsserver.watchBuild')
command! -nargs=0 OpenCurlWindow            new | set ft=rest

"
" Sandwich settings
"
runtime macros/sandwich/keymap/surround.vim

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
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_extensions_in_markdown = 1

"
" FZF settings
"
" Add --hidden to the default `Rg` command.
command! -bang -nargs=* R  call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden ".shellescape(<q-args>), 1, <bang>0)
" Add --word-regexp to the customized version.
command! -bang -nargs=* Rw call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --word-regexp ".shellescape(<q-args>), 1, <bang>0)
" floating window
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.4 } }
" Color settings
let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

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
function! s:ToggleDiffoptIwhite()
 if &diffopt =~ 'iwhite'
   set diffopt-=iwhite
 else
   set diffopt+=iwhite
 endif
endfunction

