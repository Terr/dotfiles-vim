compiler rustc

set makeprg=cd\ %:h\ &&\ cargo\ build
let b:start='-wait=always -dir=%:h cargo run'

"" vim-lsp / async.vim
setlocal omnifunc=lsp#complete
nmap <Leader>d :LspDefinition<CR>
nmap <Leader>r :LspReferences<CR>
nmap <Leader>g :LspHover<CR>
nmap <Leader>s :LspWorkspaceSymbol<CR>
nmap <F2> :LspRename<CR>
