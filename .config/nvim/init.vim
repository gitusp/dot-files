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
" LSC
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/completion-nvim'
" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
" Startup window
Plug 'mhinz/vim-startify'

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme flattened_light
let g:airline_theme='solarized'
set updatetime=100
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
" https://github.com/nvim-lua/completion-nvim
set completeopt=menuone,noinsert,noselect

"
" Color settings
"
highlight LspDiagnosticsError               guifg=#dc322f
highlight LspDiagnosticsErrorSign           guifg=#dc322f
highlight LspDiagnosticsErrorFloating       guifg=#dc322f

highlight LspDiagnosticsWarning             guifg=#b58900
highlight LspDiagnosticsWarningSign         guifg=#b58900
highlight LspDiagnosticsWarningFloating     guifg=#b58900

highlight LspDiagnosticsInformation         guifg=#268bd2
highlight LspDiagnosticsInformationSign     guifg=#268bd2
highlight LspDiagnosticsInformationFloating guifg=#268bd2

highlight LspDiagnosticsHint                guifg=#859900
highlight LspDiagnosticsHintSign            guifg=#859900
highlight LspDiagnosticsHintFloating        guifg=#859900

highlight Sneak                             guifg=#fdf6e3 guibg=#d33682
highlight ExtraWhitespace                   guibg=#dc322f

"
" Custom mappings
"
" Normal mode - normal assignments
nnoremap                Y          y$
nnoremap                Q          @q
nnoremap                _          @:
nmap                    ghp        <Plug>(GitGutterPreviewHunk)
nmap                    ghs        <Plug>(GitGutterStageHunk)
nmap                    ghu        <Plug>(GitGutterUndoHunk)
nnoremap <silent>       gl         <cmd>lua require('telescope.builtin').live_grep()<CR>
nmap                    gs         <Plug>SlimeMotionSend
nmap                    gss        <Plug>SlimeLineSend
nmap     <silent>       [g         :PrevDiagnosticCycle<CR>
nmap     <silent>       ]g         :NextDiagnosticCycle<CR>
nnoremap <silent>       <C-L>      :nohlsearch<Bar>call sneak#util#removehl()<CR><C-L>
nmap     <silent>       <C-N>      <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent>       <C-P>      <cmd>lua require'telescope.builtin'.find_files{find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" }}<CR>
nmap                    <C-W>Q     <Plug>(yanked-buffer-p)
nmap     <silent>       <Space>    <cmd>lua vim.lsp.buf.code_action()<CR>
" NOTE: <BS> = <C-8>
nnoremap <silent>       <BS>       <cmd>lua require'telescope.builtin'.grep_string{}<CR>
" LSC mappings
nnoremap <silent>       <c-]>      <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>       K          <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent>       gD         <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent>       <c-k>      <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>       1gD        <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent>       gr         <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent>       g0         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent>       gW         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent>       gd         <cmd>lua vim.lsp.buf.declaration()<CR>
" Visual mode
xmap                    gs         <Plug>SlimeRegionSend
" Terminal mode
tnoremap                <Esc>      <C-\><C-N>
imap     <silent>       <C-x><CR>  <plug>(emmet-expand-abbr)

"
" autocmd
"
augroup vimrc
  autocmd!
  autocmd BufWritePre *.ts,*.tsx,*.scss,*.json Neoformat
  " try to load local dotenv
  autocmd VimEnter * try | Dotenv .env.local | catch | endtry
  " wiki settings - gq to quit / auto save
  autocmd BufRead,BufNewFile */wiki/*.md
        \ nnoremap <buffer><silent> gq :q<CR> |
        \ autocmd InsertLeave,TextChanged <buffer> silent write |
        \ setlocal noswapfile
augroup END

"
" Custom commands
"
" command! -nargs=0                             Tsc            call CocAction('runCommand', 'tsserver.watchBuild') | copen
command! -nargs=0                             Wiki           sp ~/wiki/index.md
command! -nargs=0                             Diary          exe 'sp ~/wiki/diary/' . strftime('%Y-%m-%d') . '.md'

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

"
" LSC settings
"
lua <<EOF
local on_attach = function(client)
  require'diagnostic'.on_attach(client)
  require'completion'.on_attach(client)
end

require'nvim_lsp'.tsserver.setup{ on_attach=on_attach }
require'nvim_lsp'.pyls_ms.setup{ on_attach=on_attach }
EOF

"
" Neoformat
"
let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_typescript = ['eslint_d', 'prettier']
let g:neoformat_enabled_typescriptreact = ['eslint_d', 'prettier']
let g:neoformat_enabled_scss = ['stylelint']
let g:neoformat_enabled_json = ['prettier']

"
" Completion plugin
"
let g:completion_confirm_key = "\<C-y>"
