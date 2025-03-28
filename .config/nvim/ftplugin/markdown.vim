nmap <buffer><silent> <localleader>c :call markdown#toggleCheckbox()<CR>
vmap <buffer><silent> <localleader>c :call markdown#toggleCheckbox()<CR>
nmap <buffer><silent> <localleader>t :TableModeRealign<CR>
nmap <buffer><silent> <localleader>j :call markdown#journal()<CR>
vmap <buffer><silent> <localleader>j :call markdown#journalize()<CR>

nmap <buffer><silent> o :call markdown#addLineBelow()<CR>
nmap <buffer><silent> O :call markdown#addLineAbove()<CR>
