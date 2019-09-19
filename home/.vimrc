set nocompatible

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Plugins
call plug#begin('~/.vim/plugged')
"" Autocompletion
Plug 'Valloric/YouCompleteMe'
"" Fuzzy file finder
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
"" Tmux navigator
Plug 'christoomey/vim-tmux-navigator'
"" Solarized color scheme
Plug 'altercation/vim-colors-solarized'
"" Auto-close brackets/quotes/etc.
Plug 'optroot/auto-pairs'
"" vim-surround
Plug 'tpope/vim-surround'
"" newrw improvements
Plug 'tpope/vim-vinegar'
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
"" Asynchronous linting
Plug 'w0rp/ale'
"" Automatically builds tag files
Plug 'ludovicchabant/vim-gutentags'
"" Snippets
Plug 'SirVer/ultisnips'
"" Better Python indentation
Plug 'Vimjas/vim-python-pep8-indent'
"" Go development plugin
Plug 'fatih/vim-go'
"" Visual debugger for multiple langauges
Plug 'markkimsal/vdebug'
"" More clever tab completions
Plug 'ervandew/supertab'
"" Rust file detection, syntax highlighting, etc.
Plug 'rust-lang/rust.vim'
"" PHP syntax highlighting
Plug 'StanAngeloff/php.vim'
"" TypeScript syntax highlighting
Plug 'leafgarland/typescript-vim'
call plug#end()

" Setup for tmux environments
set t_ut=
if &term =~ '^screen'
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

" Syntax highlighting
syntax enable

" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set fo-=t  " don't automatically wrap text when typing

" Indenting
filetype indent plugin on
set cindent
set smartindent
set autoindent
set shiftround

" Make backspace behave as 'usual'
set backspace=indent,eol,start

" Theme / colors
set t_Co=256
let g:solarized_termcolors=256
set background=light
colorscheme solarized-custom

" Backup settings
set nobackup
set nowb
set noswapfile

" Buffer settings
set hidden  " Allow switching to other buffers from an unsaved one
set splitbelow
set splitright

" Enforce shell (instead of the current user's one) to give consistent
" results. 'sh' should be available on all systems.
set shell=/bin/sh

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

" Bubble single line
nmap <C-S-Up> [e
nmap <C-S-Down> ]e
" Bubble multiple lines
vmap <C-S-Up> [egv
vmap <C-S-Down> ]egv

" Default to UTF-8 text encoding
set encoding=utf-8
set fileencoding=utf-8

"" Remove trailing whitespace on save
autocmd FileType c,cpp,java,rust,php,python,javascript,html,ruby autocmd BufWritePre <buffer> :call setline(1,map(getline(1 ,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Plugin related settings
"" YouCompleteMe
nmap <Leader>d :YcmCompleter GoToDefinition<CR>
nmap <Leader>g :YcmCompleter GetDoc<CR>
let g:ycm_goto_buffer_command = 'split-or-existing-window'
let g:ycm_rust_src_path = '~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
""" Make YCM compatible with UltiSnips (using SuperTab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
""" Language blacklist (including defaults)
let g:ycm_filetype_blacklist = {
    \ 'rust': 1,
    \ 'typescript': 1,
    \ 'tagbar': 1,
    \ 'qf': 1,
    \ 'notes': 1,
    \ 'markdown': 1,
    \ 'unite': 1,
    \ 'text': 1,
    \ 'vimwiki': 1,
    \ 'pandoc': 1,
    \ 'infolog': 1,
    \ 'mail': 1
    \}

"" fzf
let g:fzf_history_dir='~/.local/share/fzf-history'
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap ` :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <F3> :Rg <C-r>=expand("<cword>")<CR><CR>
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
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
if executable('bat')
    command! -bang -nargs=* RgPreview call fzf#run(fzf#wrap(
        \ {
            \ 'source': 'rg --fixed-strings --follow --no-heading --line-number --trim --color "always" '.shellescape(<q-args>).'| tr -d "\017"',
            \ 'dir': getcwd(),
            \ 'sink': function('EditFileAtLine'),
            \ 'options': ['--ansi', '--nth', '2..', '--delimiter', ':', '--tiebreak=index', '--multi', '--prompt', 'Rg> ', '--preview', 'sh -c "bat --theme=\"Monokai Extended Light\" --style=numbers,changes --color=always $(echo {1..-1}|cut -f1 -d:) $(LINENUM=$(($(echo {1..-1}|cut -f2 -d:) - 2)); if [ $LINENUM -lt 0 ]; then echo --line-range=1: --highlight-line=1; else echo --line-range=$LINENUM: --highlight-line=$(($LINENUM + 2)); fi) | head -'.&lines.'"']
        \ },
        \ <bang>0,
    \ ))
    nnoremap <C-P> :RgPreview<CR>
else
    nnoremap <C-P> :Rg<CR>
endif
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
""" Extra settings added in 'optroot' fork
let g:AutoPairsMultilineClose = 0
let g:AutoPairsBalanceImmediately = 1
let g:AutoPairsNeverJumpLines = 1
let g:AutoPairsOnlyBeforeClose = 1

"" vim-go
let g:go_template_autocreate = 0

"" ALE
let g:ale_completion_enabled = 0
let g:ale_lint_delay = 125
let g:ale_lint_on_text_changed = 'always'
let g:ale_fix_on_save = 1
let g:ale_sign_info = '^^'
let g:ale_sign_style_error = '}}'
let g:ale_linters = {
    \ 'php': ['phpmd'],
    \ 'rust': ['cargo'], 
\ }
let g:ale_fixers = {
    \ 'rust': ['rustfmt'],
    \ 'typescript': ['tslint']
\ }
""" Language specific settings
let g:ale_php_phpmd_ruleset = 'unusedcode'
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_check_tests = 1

" vim-dispatch
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

"" Gutentags
let g:gutentags_cache_dir = "~/.ctags"
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
let g:gutentags_file_list_command = "fd --no-ignore"
""" 'etags' is the only format that is supported by YouCompleteMe
""" Ignore PHP 'use' aliases when building tags
let g:gutentags_ctags_extra_args = [
    \ "--output-format=etags", 
    \ "--kinds-PHP=-a",
    \ "--languages=-CSS,JSON"
\ ]
