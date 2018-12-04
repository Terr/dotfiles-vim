" For use with ripgrep output and FZF
function EditFileAtLine(item)
    let l:file_pos = stridx(a:item, ':')
    let l:file_path = a:item[0:file_pos-1]
    let l:line_pos = stridx(a:item, ':', file_pos+1)
    let l:linenum = a:item[file_pos+1:line_pos-1]
    execute 'silent e +'.l:linenum.' '.fnameescape(l:file_path)
endfunction
