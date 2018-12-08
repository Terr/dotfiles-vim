compiler rustc

set makeprg=cd\ %:h\ &&\ cargo\ build
let b:start='-wait=always -dir=%:h cargo run'

"nmap <Leader>d :split<CR>:ALEGoToDefinition<CR>
nmap <Leader>d :ALEGoToDefinitionInTab<CR>
nmap <Leader>r :ALEFindReferences<CR>
nmap <Leader>g :ALEHover<CR>
nmap <Leader>s :ALESymbolSearch 
