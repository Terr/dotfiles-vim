set nocompatible

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Default to UTF-8 text encoding
set encoding=utf-8

" Plugins
call plug#begin('~/.vim/plugged')
"" Fuzzy file finder
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
"" Tmux navigator
Plug 'christoomey/vim-tmux-navigator'
"" Solarized color scheme
Plug 'lifepillar/vim-solarized8'
"" Auto-close brackets/quotes/etc.
Plug 'LunarWatcher/auto-pairs'
"" vim-surround
Plug 'tpope/vim-surround'
"" netrw improvements
Plug 'tpope/vim-vinegar'
"" File tree viewer
Plug 'lambdalisue/fern.vim', { 'branch': 'main' }
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/vim-fern-renderer-nerdfont'
"" Various mappings, such as line bubbling, URL encoding, etc.
Plug 'tpope/vim-unimpaired'
"" UNIX shell commands in Vim (move, mkdir, chmod etc)
Plug 'tpope/vim-eunuch'
"" Git wrapper
Plug 'tpope/vim-fugitive'
"" Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'
"" Line/block comments
Plug 'scrooloose/nerdcommenter'
"" Language server client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-basedpyright', {'do': 'yarn install --frozen-lockfile'}
"" Visual debugger for multiple langauges
Plug 'markkimsal/vdebug'
"" (c)tags navigation within file
Plug 'preservim/tagbar'
" Align text in table format
Plug 'godlygeek/tabular'
"" Notes
Plug 'Terr/vim-outlaw', { 'branch': 'indent-based-text-width' }
"" Better Python indentation
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
"" Go development plugin
Plug 'fatih/vim-go', { 'for': 'go' }
"" Rust file detection, syntax highlighting, etc.
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
"" PHP syntax highlighting
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
"" TypeScript syntax highlighting
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
"" Improved C++ syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
"" Vimscript testing framework
Plug 'junegunn/vader.vim', { 'for': 'vim' }
call plug#end()

" Setup for tmux environments
set t_ut=
if &term =~ '^screen' || &term =~ '^tmux'
    " Make Vim recognize xterm escape sequences for Page and Arrow
    " keys combined with modifiers such as Shift, Control, and Alt.
    " See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
    " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
    execute "set t_kP=\e[5;*~"
    execute "set t_kN=\e[6;*~"

    " Arrow keys http://unix.stackexchange.com/a/34723
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Increase redrawing speed
set ttyfast

" Syntax highlighting
syntax enable
"" Don't syntax highlight lines longer than this many columns wide
set synmaxcol=300

" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set formatoptions-=t  " don't automatically wrap text when typing

" Indenting
filetype plugin indent on
set smartindent
set autoindent
set shiftround

" Make backspace behave as 'usual'
set backspace=indent,eol,start

" Reduce delay of using 'O' after having used Esc to exit Insert mode
" See: http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set timeoutlen=300

" Show number of selected characters/lines and commands as they're being typed
set showcmd

" Statusline
"" Always show a status line
set laststatus=2

set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#StatusLine#           " colour
set statusline+=\ %n\                   " buffer number
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=\ %f                    " relative file path
set statusline+=\ %y                    " file type
set statusline+=%r                      " readonly flag
set statusline+=%m                      " modified [+] flag
set statusline+=%{tagbar#currenttag('[%s]\ ','')}  " show current ctag
set statusline+=%=                      " right align
set statusline+=%#StatusLineNC#         " colour
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %3l:%-2c              " line + column
set statusline+=\ [0x%02B]              " byte value of char. under cursor
set statusline+=\ %3p%%\                " percentage

set shortmess+=c

" Theme / colors

if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
set background=light
colorscheme solarized8_custom

" Backup settings
set nobackup
set nowritebackup
set noswapfile
set updatetime=300  " Also used for the CursorHold event

" Buffer settings
set hidden  " Allow switching to other buffers from an unsaved one
set splitbelow
set splitright

" Enforce shell (instead of the current user's one) to give consistent
" results. 'sh' should be available on all systems.
set shell=sh

" Search settings
set incsearch
set hlsearch
set ignorecase
set smartcase
set grepprg=rg\ --vimgrep

" Wild file selection menu
set wildmode=list:longest
set wildmenu
set wildignorecase
set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.jpg,*.jpeg,*.gif,*.png,*/.svn/*,*/.hg/*
set wildignore+=*/.cache/*,*/cache/*

" Line numbering
set number
set relativenumber
set signcolumn=number

" Scroll settings
set ruler
"" Keep X lines above/below the cursor when scrolling
set scrolloff=7
set sidescrolloff=7
set sidescroll=1

" netrw settings
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_altv = 1
let g:netrw_sort_options = "i"

" Rebind <Leader> key
let mapleader = ','

" Shortcut to (force) save buffer
nmap \ :w!<CR>

" Clear search highlights
noremap <silent><Leader>/ :nohls<CR>

" Sort selection
vmap s :sort<CR>

" Switch to previous buffer with backspace
nmap <BS> <C-^>

" Pre-fill find/replace with text under cursor
nnoremap <F2> :%s#<C-r>=expand("<cword>")<CR>##g<Left><Left>
vnoremap <F2> :<C-u>%s#<C-r>*#

" Toggle for "paste"-mode
set pastetoggle=<F5>

" Bubble single line
nmap <C-S-Up> [e
nmap <C-S-Down> ]e
" Bubble multiple lines
vmap <C-S-Up> [egv
vmap <C-S-Down> ]egv

" Binding to copy the current relative path name of the current buffer to xclipboard
nmap <silent> <Leader>yf :let @+=expand("%")<CR>
nmap <silent> <Leader>yl :let @+=expand("%").":".line(".")<CR>
" Binding to copy the full path name of the current buffer to xclipboard
nmap <silent> <Leader>yF :let @+=expand("%:p")<CR>
" Copy selection to xclipboard
map <Leader>y "+yy
vmap <Leader>y "+y
" Paste selection from xclipboard
map <Leader>p "+p
map <Leader>P "+P

" Open a new tmux pane that starts in the directory of the current file
"" A horizontal pane in tmux is what we call a vertical split in vim
nnoremap <silent> <Leader>gv :call system('tmux split-window -h -c "'.expand('%:p:h').'" &')<CR>
"" Vertical pane in tmux
nnoremap <silent> <Leader>gs :call system('tmux split-window -v -c "'.expand('%:p:h').'" &')<CR>

" Remove trailing whitespace on save
function! <SID>StripTrailingWhitespace()
    let l:current_cursor_pos = getpos(".")
    keeppatterns %s/\s\+$//e
    call setpos('.', l:current_cursor_pos)
endfunction

autocmd FileType c,cpp,go,html,java,javascript,lua,php,python,ruby,yaml autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespace()

" Plugin related settings

"" fzf
let g:fzf_history_dir='~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '~40%' }
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap <silent> ` :FZF<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>w :Windows<CR>
nnoremap <silent> <C-B> :BLines<CR>
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <F3> :Rg <C-r>=expand("<cword>")<CR><CR>
vnoremap <silent> <F3> :<C-u>Rg <C-r>*<CR>
" Toggle showing/hiding in-line type hints (as they can be very long sometimes)
noremap <silent> <F4> :CocCommand document.toggleInlayHint<CR>

if executable('spacegrep')
    command! -bang -nargs=* Sg call fzf#run(fzf#wrap(
        \ {
            \ 'source': 'spacegrep --color=always -d . '.shellescape(<q-args>).' 2>/dev/null|grep -v -E "^$"|sed -E "s/:\s+/: /"',
            \ 'dir': getcwd(),
            \ 'sink': function('EditFile'),
            \ 'options': ['--ansi', '--delimiter=:', '--nth', '2..', '--tiebreak=index', '--multi', '--prompt', 'Spacegrep> ']
        \ },
        \ <bang>0,
    \ ))
    nnoremap <C-G> :Sg
endif

""" Add function & keybind for building a quickfix list out of the search results. Use with <C-A> <C-Q>
"""" An action can be a reference to a function that processes selected lines.
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction
let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_COMMAND = 'fd --hidden --follow --type file --type symlink --exclude .git'
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
if executable('bat')
    command! -bang -nargs=* Rg call fzf#run(fzf#wrap(
        \ {
            \ 'source': 'rg --fixed-strings --follow --no-heading --line-number --trim --color "always" '.shellescape(<q-args>).'| tr -d "\017"',
            \ 'dir': getcwd(),
            \ 'sink': function('EditFileAtLine'),
            \ 'options': ['--ansi', '--nth', '2..', '--delimiter', ':', '--tiebreak=index', '--multi', '--prompt', 'Rg> ', '--preview', 'sh -c "echo {1} && bat --theme=\"Monokai Extended Light\" --style=numbers,changes --color=always $(echo {1..-1}|cut -f1 -d:) $(LINENUM=$(($(echo {1..-1}|cut -f2 -d:) - 2)); if [ $LINENUM -lt 0 ]; then echo --line-range=1: --highlight-line=1; else echo --line-range=$LINENUM: --highlight-line=$(($LINENUM + 2)); fi) | head -'.&lines.'"']
        \ },
        \ <bang>0,
    \ ))
endif
nnoremap <C-P> :Rg<CR>

""" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"" tmux-navigator
""" Window switching, combined with 'stepping'
""" over into tmux panes
nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <C-BS> :TmuxNavigatePrevious<cr>

"" auto-pairs
let g:AutoPairsPrefix = "<C-e>"
let g:AutoPairsMultilineClose = 0
let g:AutoPairsCompleteOnlyOnSpace = 1

"" vim-go
let g:go_template_autocreate = 0

"" coc.nvim
""" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"""" Also bind it to Ctrl-@ for Alacritty, since for some reason it doesn't
"""" trigger there even though it does seem to pass the correct character to
"""" the terminal (0x00). See:
"""" * https://github.com/neoclide/coc.nvim/issues/2718#issuecomment-791436930
"""" * https://github.com/alacritty/alacritty/issues/4575#issuecomment-770359544
inoremap <silent><expr> <c-@> coc#refresh()

""" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

""" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

""" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

""" Remap keys for gotos
nmap <silent> <Leader>d <Plug>(coc-definition)
nmap <silent> <Leader>e <Plug>(coc-type-definition)
nmap <silent> <Leader>i <Plug>(coc-implementation)
nmap <silent> <Leader>r <Plug>(coc-references)
nmap <silent> <Leader>h <Plug>(coc-diagnostic-info)
nmap <Leader>s :CocSearch <C-r>=expand("<cword>")<CR><CR>

""" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

"" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

""" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

""" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

""" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

""" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
""" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

""" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

""" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

"" vim-dispatch
let g:nremap = {"`": "\""}

"" nerdcommenter
nmap  <Plug>NERDCommenterToggle<CR>
vmap  <Plug>NERDCommenterToggle<CR>

"" UltiSnips
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsListSnippets  = "<C-Tab>"
"let g:UltiSnipsJumpForwardTrigger = "<Tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

"" Tagbar
nmap <silent> <F8> :TagbarOpen fjc<CR>

"" fern.vim
let g:fern#renderer = "nerdfont"

function! s:init_fern() abort
    nnoremap <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>
    " Close the drawer after opening a file
    nmap <buffer> <silent> <Plug>(fern-custom-open-and-close)
                \ <Plug>(fern-action-open)
                \ <Plug>(fern-close-drawer)

    nmap <buffer> <silent> <expr>
                \ <Plug>(fern-custom-open-close-expand-collapse)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-custom-open-and-close)",
                \   "\<Plug>(fern-action-expand)",
                \   "\<Plug>(fern-action-collapse)",
                \ )

    nmap <buffer> <silent> <expr>
                \ <Plug>(fern-custom-open-expand-collapse)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open)",
                \   "\<Plug>(fern-action-expand)",
                \   "\<Plug>(fern-action-collapse)",
                \ )

    nmap <buffer> <silent> <Right> <Plug>(fern-action-expand)
    nmap <buffer> <silent> <Left> <Plug>(fern-action-collapse)
    " Open the selected file and close the drawer, or expand/collapse the
    " selected directory
    nmap <buffer> <silent> <C-m> <Plug>(fern-custom-open-close-expand-collapse)
    " Open the file without closing the drawer
    nmap <buffer> <silent> o <Plug>(fern-custom-open-expand-collapse)
    nmap <buffer> <silent> s <Plug>(fern-action-open:split)
    nmap <buffer> <silent> v <Plug>(fern-action-open:vsplit)
    " Create new file
    nmap <buffer> <silent> N <Plug>(fern-action-new-path=)
    nmap <buffer> <silent> R <Plug>(fern-action-rename:bottom)
    nmap <buffer> <silent> <F5> <Plug>(fern-action-reload)
    " Open in a background tab
    nmap <buffer> <silent> T <Plug>(fern-action-open:tab)gT
    nmap <buffer> <silent> X <Plug>(fern-action-open:system)
    nmap <buffer> <silent> <F7> :<C-u>quit<CR>
    nmap <buffer> <silent> q :<C-u>quit<CR>
endfunction

augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

nnoremap <silent> <F7> :Fern . -reveal=% -drawer -width=40<CR>

"" vim-outlaw
""" Custom keybinds are set in after/ftplugin/outlaw.vim
let g:no_outlaw_maps = 1
"let g:outlaw_fenced_filetypes = ['python', 'rust', 'sql']

"" rust.vim
let g:rustfmt_autosave = 0

"" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
