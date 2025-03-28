function! markdown#addLineBelow()
  let l:line = getline(".")
  execute "norm A \<CR>\<esc>m`k"
  call setline(".", l:line)
  norm! ``
  startinsert!
endfunction

function! markdown#addLineAbove()
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

function! markdown#toggleCheckbox() range
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

function! markdown#journal()
  let l:buf_name = substitute(expand('%'), "[^/]*$", "", "") .. strftime("%Y%m%d%H%M%S") .. '.md'
  execute 'vnew ' .. l:buf_name
endfunction

function! markdown#journalize() range
  let l:lines = getline(a:firstline, a:lastline)
  execute a:firstline .. ',' .. a:lastline .. 'delete _'
  call markdown#journal()
  call setline(1, l:lines)
  write
endfunction
