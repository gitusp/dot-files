nmap <buffer><silent> <cr> :call markdown#toggleCheckbox()<CR>
vmap <buffer><silent> <cr> :call markdown#toggleCheckbox()<CR>
nmap <buffer><silent> <localleader>t :TableModeRealign<CR>

nmap <buffer><silent> o :call markdown#addLineBelow()<CR>
nmap <buffer><silent> O :call markdown#addLineAbove()<CR>
