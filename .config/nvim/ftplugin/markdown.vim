nmap     <buffer><silent> <CR>     :call <SID>ToggleCheckbox()<CR>
nmap     <buffer><silent> ge       yi(:e <C-R>=@"=~'^\(/\\|\~/\)'?'':expand('%:p:h').'/'<CR><C-R>"<CR>
nnoremap <buffer><silent> g<Space> :silent exec "Gw<Bar>G commit -q -m Snapshot<Bar>CocCommand git.refresh"<CR>

function! s:ToggleCheckbox()
  let line = getline('.')
  let dest = ''

  if match(line, '^\s*- \[ ]') != -1
    let dest = 'x'
  elseif match(line, '^\s*- \[x]') != -1
    let dest = ' '
  endif

  if dest != ''
    exe 's/^\s*- \[\zs.\ze]/' . dest . '/'
  endif
endfunction

command! -buffer CreateSpreadsheet silent !open https://docs.google.com/spreadsheets/create

