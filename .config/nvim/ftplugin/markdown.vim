nmap <buffer><silent> <localleader>c :call <SID>ToggleCheckbox()<CR>
vmap <buffer><silent> <localleader>c :call <SID>ToggleCheckbox()<CR>
nmap <buffer><silent> <localleader>t :TableModeRealign<CR>

nmap <buffer><silent> o :call <SID>AddLineBelow()<CR>
nmap <buffer><silent> O :call <SID>AddLineAbove()<CR>

function! s:AddLineBelow()
  let l:line = getline(".")
  execute "norm A \<CR>\<esc>m`k"
  call setline(".", l:line)
  norm! ``
  startinsert!
endfunction

function! s:AddLineAbove()
  norm m`o
  let l:line = getline(".")
  norm! "_dd``O
  call setline(".", l:line)

  let l:num = matchstr(l:line, '^\s*\zs\d\+\ze')
  if l:num != ''
    let l:dest_num = l:num - 2
    execute 's/' . l:num . '/' . max([l:dest_num, 1]) . '/'
  endif

  startinsert!
endfunction

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

