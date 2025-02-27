nmap <buffer><silent> <localleader>c :call <SID>ToggleCheckbox()<CR>

function! s:ToggleCheckbox()
  let line = getline('.')
  let dest = ''

  if match(line, '^\s*- \[ ]') != -1
    let dest = 'x'
  elseif match(line, '^\s*- \[x]') != -1
    let dest = ' '
  endif

  if dest != ''
    let l:pos = winsaveview()
    exe 's/^\s*- \[\zs.\ze]/' . dest . '/'
    call winrestview(l:pos)
  endif
endfunction

