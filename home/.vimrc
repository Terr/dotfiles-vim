set nocompatible

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

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
Plug 'dense-analysis/ale'
"" Language server client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"" Automatically builds tag files
Plug 'ludovicchabant/vim-gutentags'
"" Snippets
Plug 'SirVer/ultisnips'
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
set fo-=t  " don't automatically wrap text when typing

" Indenting
filetype indent plugin on
set smartindent
set autoindent
set shiftround

" Make backspace behave as 'usual'
set backspace=indent,eol,start

" Reduce delay of using 'O' after having used Esc to exit Insert mode
" See: http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set timeoutlen=300

" Statusline
"" Always show a status line
set laststatus=2

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
set nowb
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
set signcolumn=yes

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

" Default to UTF-8 text encoding
set encoding=utf-8
set fileencoding=utf-8

" Remove trailing whitespace on save
autocmd FileType c,cpp,java,rust,php,python,javascript,html,ruby,yaml autocmd BufWritePre <buffer> :keepjumps call setline(1,map(getline(1 ,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Plugin related settings

"" fzf
let g:fzf_history_dir='~/.local/share/fzf-history'
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap ` :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>w :Windows<CR>
nnoremap <C-B> :BLines<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <F3> :Rg <C-r>=expand("<cword>")<CR><CR>
vnoremap <F3> :<C-u>Rg <C-r>*<CR>
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
let g:ale_linters_explicit = 1
let g:ale_linters = {
    \ 'php': ['phpmd'],
    \ 'rust': [],
    \ 'cpp': [],
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

"" coc.nvim
""" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

""" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
""" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
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
nmap <silent> <Leader>y <Plug>(coc-type-definition)
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

"" Gutentags
let g:gutentags_cache_dir = "~/.tags"
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
let g:gutentags_file_list_command = "fd --no-ignore"
""" Ignore PHP 'use' aliases when building tags
let g:gutentags_ctags_extra_args = [
    \ "--kinds-PHP=-a",
    \ "--languages=-CSS,JSON"
\ ]

"" Tagbar
nmap <F8> :TagbarToggle<CR>

"" vim-outlaw
""" Custom keybinds are set in after/ftplugin/outlaw.vim
let g:no_outlaw_maps = 1

"" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
