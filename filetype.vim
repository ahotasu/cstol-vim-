" Created 2/23/04 by D. Gathright
"
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.prc      setfiletype cstol
  au! BufRead,BufNewFile *.disasm   setfiletype asm
augroup END
