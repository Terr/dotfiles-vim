setlocal textwidth=119
" Do not auto-wrap text using textwidth
setlocal formatoptions-=t

" Format file on save
function! s:outlaw_format()
    if executable('outlaw-format') == 0
        return
    endif

    let l:view = winsaveview()
    keepjumps execute '%!outlaw-format'
    call winrestview(l:view)
endfunction
autocmd! BufWritePre <buffer> :call s:outlaw_format()

setlocal commentstring=\|\ %s
" Continue * lists on newline
setlocal comments-=fb:*
setlocal comments+=b:*
" Continue to-do lists on newline
setlocal comments+=b:[\ ]

" Disable auto-pairs as Outlaw documents are not about typing code
let b:autopairs_enabled=0

" 'This fold level'
nnoremap <buffer> <silent> gl :<c-u>let &l:fdl=foldlevel(OutlawTopicLine())<cr>
" 'Body text mode'
nnoremap <buffer> <silent> gy :<c-u>let b:outlaw_note_fold_level=b:outlaw_note_fold_level=='='?20:'='<cr>zx
" 'Previous topic'
"nnoremap <buffer> <silent> <C-p> :<c-u>call OutlawAutoClose()<cr>:call OutlawTopicJump('besW')<cr>zv
" 'Next topic'
"nnoremap <buffer> <silent> <C-n> :<c-u>call OutlawAutoClose()<cr>:call OutlawTopicJump('esW')<cr>zv
" 'Parent'
nnoremap <buffer> <silent> _ :<c-u>call OutlawAutoClose()<cr>:call OutlawUp('b')<cr>zv
" 'Uncle'
nnoremap <buffer> <silent> + :<c-u>call OutlawAutoClose()<cr>:call OutlawUp('')<cr>zv
" 'Previous topic'
nnoremap <buffer> <silent> <Up> :<c-u>call OutlawAutoClose()<cr>:call OutlawTopicJump('besW')<cr>zv
" 'Next topic'
nnoremap <buffer> <silent> <Down> :<c-u>call OutlawAutoClose()<cr>:call OutlawTopicJump('esW')<cr>zv
" 'Add sibling above'
nnoremap <buffer> <silent> <c-k> :<c-u>call OutlawAddSibling(0)<cr>
" 'Add sibling below'
nnoremap <buffer> <silent> <c-j> :<c-u>call OutlawAddSibling(1)<cr>
" 'Add child'
nnoremap <buffer> <silent> <c-l> :<c-u>call OutlawAddSibling(1)<cr><c-t><c-o>zv
" 'Toggle auto-close'
nnoremap <buffer> <silent> gA :<c-u>call OutlawAddSibling(1)<cr><c-t><c-o>zv
vnoremap <buffer> <silent> gq :call OutlawFormat()<cr>

"call s:map('n', 'PrevSibling',     '<left>',  ":<c-u>call OutlawAutoClose()<cr>:call OutlawSibling('b')<cr>zv")
"call s:map('n', 'NextSibling',     '<right>', ":<c-u>call OutlawAutoClose()<cr>:call OutlawSibling('')<cr>zv")
"call s:map('v', 'MoveUp',          '<up>',    ":call OutlawMoveUp(v:count1)<cr>gv=:call OutlawAlignNote()<cr>gv")
"call s:map('v', 'MoveDown',        '<down>',  ":call OutlawMoveDown(v:count1)<cr>gv=:call OutlawAlignNote()<cr>gv")
"call s:map('v', 'MoveLeft',        '<left>',  "<zvgv")
"call s:map('v', 'MoveRight',       '<right>', ">zvgv")
