nmap <buffer><silent> <cr> :call <SID>Open()<CR>

function! s:Open()
  let l:line = getline(".")
  let l:col = col(".")
  let l:num = matchstr(l:line, '^#\zs\d\+\ze \[')
  if l:num != '' && l:col < len(l:num) + 2
    call system('gh pr view ' .. shellescape(l:num) .. ' -w')
    return
  endif
  execute "norm! \<cr>"
endfunction
