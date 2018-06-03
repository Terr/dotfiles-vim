compiler rustc
" let b:dispatch = 'rustc --out-dir %:h %'
set makeprg=cd\ %:h\ &&\ cargo\ build
