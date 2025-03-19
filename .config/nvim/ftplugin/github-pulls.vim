nmap <buffer><silent> <cr> :call <SID>Open()<CR>
nmap <buffer><silent> . :call <SID>Cmd()<CR>

function! s:Open()
  if (line('.') - 1) % 3 == 0
    let l:line = getline(".")
    let l:col = col(".")
    let l:num = matchstr(l:line, '^#\zs\d\+\ze \[')
    if l:num != '' && l:col < len(l:num) + 2
      call system('gh pr view ' .. shellescape(l:num) .. ' -w')
      return
    endif
  endif

  execute "norm! \<cr>"
endfunction

function! s:Cmd()
  if (line('.') - 1) % 3 == 0
    let l:line = getline(".")
    let l:col = col(".")
    let l:elms = split(l:line, "] <- [")

    if len(l:elms) == 2
      let l:front_elms = split(l:elms[0], '[')
      let l:col = l:col - len(l:front_elms[0])

      if l:col > 0
        let l:col = l:col - len('[') - len(front_elms[1])

        if l:col <= 1
          call feedkeys(': origin/' .. l:front_elms[1] .. "\<c-b>", 'n')
          return
        endif

        let l:col = l:col - len("] <- ")

        if l:col > 0
          let l:back_elms = split(l:elms[1], ']')
          call feedkeys(': origin/' .. l:back_elms[0] .. "\<c-b>", 'n')
        endif
      endif
    endif
  endif

  execute "norm! ."
endfunction
