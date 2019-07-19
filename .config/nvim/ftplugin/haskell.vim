nmap <buffer>         K     <Plug>InteroGenericType
nmap <buffer>         <C-K> <Plug>InteroType
nmap <buffer><silent> gd    :InteroGoToDef<CR>

let g:neoformat_enabled_haskell = ['stylishhaskell']

augroup haskell
  autocmd!
  autocmd BufWritePre   *.hs try | undojoin | catch | endtry | Neoformat
  autocmd BufWritePost  *.hs InteroReload
augroup END
