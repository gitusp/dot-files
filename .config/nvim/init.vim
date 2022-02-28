"
" Begin plugin section.
"
call plug#begin()

" Theme
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Load editorconfig.
Plug 'editorconfig/editorconfig-vim'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rbong/vim-flog'
Plug 'skanehira/gh.vim'
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
" Powerful matcher
Plug 'andymass/vim-matchup'
" Async task runner
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" REPL helper
Plug 'jpalardy/vim-slime'
" LSC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Highlight yanked region
Plug 'machakann/vim-highlightedyank'
" Additional text objects
Plug 'wellle/targets.vim'
" Quickfix helper
Plug 'itchyny/vim-qfedit'
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
" test runner
Plug 'vim-test/vim-test'
" Project settings
Plug 'tpope/vim-projectionist'
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Motion helpers
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/vim-edgemotion'
" Prisma
Plug 'pantharshit00/vim-prisma'
" Diff
Plug 'AndrewRadev/linediff.vim'
" Code assistant
Plug 'github/copilot.vim'
" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()
"
" End plugin section.
"

"
" General Settings
"
colorscheme base16-tomorrow-night
let g:airline_theme='tomorrow'
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
" folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

"
" Color settings
"
highlight link CocErrorSign    Error
highlight link CocWarningSign  WarningMsg
highlight link CocInfoSign     Directory
highlight link CocHintSign     Comment
highlight link CocErrorFloat   ErrorMsg
highlight link Sneak           Search

"
" Tree sitter
"
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
  -- vimの選択機能強すぎてincremental_selection一旦設定してない
}
EOF

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
nmap                    ghp        <Plug>(coc-git-chunkinfo)
nmap     <silent>       ghu        :CocCommand git.chunkUndo<CR>
nmap     <silent>       ghs        :CocCommand git.chunkStage<CR>
nnoremap <silent>       gl         :CocList -I grep --hidden -g !.git -smartcase<CR>
nnoremap <silent>       gL         :CocList -I grep --hidden -g !.git -smartcase -word<CR>
nmap                    gs         <Plug>SlimeMotionSend
nmap                    gss        <Plug>SlimeLineSend
nnoremap <silent>       K          :call <SID>ShowDocumentation()<CR>
nmap     <silent>       [c         <Plug>(coc-git-prevchunk)
nmap     <silent>       ]c         <Plug>(coc-git-nextchunk)
nmap     <silent>       [g         <Plug>(coc-diagnostic-prev)
nmap     <silent>       ]g         <Plug>(coc-diagnostic-next)
nmap     <silent>       [x         <Plug>(coc-git-prevconflict)
nmap     <silent>       ]x         <Plug>(coc-git-nextconflict)
nnoremap <silent>       <C-L>      :nohlsearch<Bar>call sneak#util#removehl()<CR><C-L>
nmap     <silent>       <C-N>      <Plug>(coc-rename)
nnoremap <silent>       <C-P>      :CocList files --hidden -g !.git --files<CR>
nmap                    <C-W>Q     <Plug>(yanked-buffer-p)
nnoremap <silent>       <Space>    :w<CR>
nmap     <silent>       <C-Space>  <Plug>(coc-codeaction)
" Alt yank/paste(system clipboard)
nnoremap                ¥          "+y
nnoremap                ¥¥         "+yy
nnoremap                Á          "+y$
nnoremap                π          "+p
nnoremap                ∏          "+P
" NOTE: <BS> = <C-8>
nnoremap <silent>       <BS>       :Rg --hidden -g !.git -smartcase -word <C-R><C-W><CR>
" Visual mode
xmap     <silent>       g=         <Plug>(coc-format-selected)
xmap                    gs         <Plug>SlimeRegionSend
" Alt yank/paste(system clipboard)
xnoremap                ¥          "+y
xnoremap                Á          "+Y
xnoremap                π          "+p
xnoremap                ∏          "+P
" Terminal mode
tnoremap                <Esc>      <C-\><C-N>
" Insert mode
inoremap <silent><expr> <c-space>  coc#refresh()
inoremap <silent><expr> <c-y>      pumvisible() ? coc#_select_confirm() : '<c-y>'
imap     <silent>       <C-x><CR>  <plug>(emmet-expand-abbr)
" Introduce git chunk text object
omap                    ig         <Plug>(coc-git-chunk-inner)
xmap                    ig         <Plug>(coc-git-chunk-inner)
omap                    ag         <Plug>(coc-git-chunk-outer)
xmap                    ag         <Plug>(coc-git-chunk-outer)
" Introduce function text object
omap                    if         <Plug>(coc-funcobj-i)
xmap                    if         <Plug>(coc-funcobj-i)
omap                    af         <Plug>(coc-funcobj-a)
xmap                    af         <Plug>(coc-funcobj-a)
" FZF
imap                    <c-x>l     <plug>(fzf-complete-buffer-line)
inoremap <expr>         <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always --hidden -g !.git',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
" CoC popup window
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

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
command! -nargs=0                              OrganizeImport call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0                              Format         call CocAction('format')
command! -nargs=?                              Fold           call CocAction('fold', <f-args>)
command! -nargs=0                              Tsc            call CocAction('runCommand', 'tsserver.watchBuild') | copen
command! -nargs=0                              Wiki           e ~/wiki/wiki/index.md
command! -nargs=? -complete=custom,s:DiaryArgs Diary          exe 'e ' . s:DiaryPath(<f-args>)
command! -nargs=? -complete=custom,s:JotArgs   Jot            exe 'e ' . s:JotPath(<f-args>)
command! -nargs=+ -complete=custom,s:GrepArgs  Rg             exe 'CocList grep '.<q-args>
command! -nargs=0                              Symbols        CocList symbols
command! -nargs=0                              Mru            CocList mru

function! s:GrepArgs(...)
  let list = ['-smartcase', '-ignorecase', '-literal', '-word', '-regex',
        \ '-skip-vcs-ignores', '-extension', '--hidden']
  return join(list, "\n")
endfunction

function! s:DiaryPath(...)
  return '~/wiki/diary/' . (a:0 > 0 ? a:1 . '/' : 'default/') . strftime('%Y-%m-%d') . '.md'
endfunction

function! s:JotPath(...)
  return '~/wiki/jot/' . (a:0 > 0 ? a:1 . '/' : 'default/') . strftime('%Y-%m-%d %H:%M:%S') . '.md'
endfunction

function! s:DiaryArgs(...)
  return system("ls -d ~/wiki/diary/*/ | awk -F/ '{print $(NF-1)}'")
endfunction

function! s:JotArgs(...)
  return system("ls -d ~/wiki/jot/*/ | awk -F/ '{print $(NF-1)}'")
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
let g:vrc_trigger = '<Plug>'

"
" Table mode settings
"
let g:table_mode_corner='|'

"
" Markdown settings
"
let g:vim_markdown_no_extensions_in_markdown = 1

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
" tcomment
"
let g:tcomment#filetype#guess_typescriptreact = 1
