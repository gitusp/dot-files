nmap <buffer><silent> <localleader>c :call <SID>ToggleCheckbox()<CR>
vmap <buffer><silent> <localleader>c :call <SID>ToggleCheckbox()<CR>
nmap <buffer><silent> <localleader>t :TableModeRealign<CR>

function! s:ToggleCheckbox() range
  let l:regex = '^\s*- \[\zs[ xX]\ze\]'
  let l:pos = winsaveview()
  let l:dest = ''

  for line_num in range(a:firstline, a:lastline)
    let l:line = getline(line_num)
    let l:checkbox = matchstr(l:line, regex)

    if l:checkbox == ''
      continue
    endif

    if l:dest == ''
      let l:dest = l:checkbox == ' ' ? 'x' : ' '
    endif

    execute line_num . 's/' . l:regex . '/' . l:dest . '/'
  endfor

  call winrestview(l:pos)
endfunction


" test
