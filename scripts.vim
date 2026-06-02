" Created 2/23/04 by D. Gathright
"
if did_filetype()	" filetype already set..
  finish		" ..don't do these checks
endif
if getline(1) =~ '^proc'
  setfiletype cstol
endif
