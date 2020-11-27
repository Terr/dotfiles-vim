" Continue * lists on newline
setlocal comments-=fb:*
setlocal comments+=b:*

" 'This fold level'
nmap <silent> gl :<c-u>let &l:fdl=foldlevel(OutlawTopicLine())<cr>
" 'Body text mode'
nmap <silent> gy :<c-u>let b:outlaw_note_fold_level=b:outlaw_note_fold_level=='='?20:'='<cr>zx
" 'Previous topic'
nmap <silent> <C-p> :<c-u>call OutlawAutoClose()<cr>:call OutlawTopicJump('besW')<cr>zv
" 'Next topic'
nmap <silent> <C-n> :<c-u>call OutlawAutoClose()<cr>:call OutlawTopicJump('esW')<cr>zv
" 'Parent'
nmap <silent> - :<c-u>call OutlawAutoClose()<cr>:call OutlawUp('b')<cr>zv
" 'Uncle'
nmap <silent> = :<c-u>call OutlawAutoClose()<cr>:call OutlawUp('')<cr>zv
" 'Add sibling below'
nmap <silent> <cr> :<c-u>call OutlawAddSibling(1)<cr>
" 'Add sibling above'
nmap <silent> <c-k> :<c-u>call OutlawAddSibling(0)<cr>
" 'Add child'
nmap <silent> <c-j> :<c-u>call OutlawAddSibling(1)<cr><c-t><c-o>zv
" 'Toggle auto-close'
nmap <silent> gA :<c-u>call OutlawAddSibling(1)<cr><c-t><c-o>zv
"call s:map('n', 'PrevSibling',     '<left>',  ":<c-u>call OutlawAutoClose()<cr>:call OutlawSibling('b')<cr>zv")
"call s:map('n', 'NextSibling',     '<right>', ":<c-u>call OutlawAutoClose()<cr>:call OutlawSibling('')<cr>zv")
"call s:map('v', 'MoveUp',          '<up>',    ":call OutlawMoveUp(v:count1)<cr>gv=:call OutlawAlignNote()<cr>gv")
"call s:map('v', 'MoveDown',        '<down>',  ":call OutlawMoveDown(v:count1)<cr>gv=:call OutlawAlignNote()<cr>gv")
"call s:map('v', 'MoveLeft',        '<left>',  "<zvgv")
"call s:map('v', 'MoveRight',       '<right>', ">zvgv")
