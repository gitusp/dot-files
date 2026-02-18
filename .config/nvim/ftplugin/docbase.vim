if getline(1) =~# '^metarw'
  finish
endif

runtime! ftplugin/markdown.vim
