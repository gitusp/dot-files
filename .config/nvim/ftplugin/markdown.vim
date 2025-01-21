nmap <buffer><silent> <CR> :call <SID>ToggleCheckbox()<CR>

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

