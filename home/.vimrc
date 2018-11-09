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
"" Vimwiki
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
"" Better Python indentation
Plug 'Vimjas/vim-python-pep8-indent'
"" Go development plugin
Plug 'fatih/vim-go'
""" Visual debugger for multiple langauges
Plug 'markkimsal/vdebug', { 'branch': 'python3' }
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
colorscheme solarized

" Backup settings
set nobackup
set nowb
set noswapfile

" Buffer settings
set hidden  " Allow switching to other buffers from an unsaved one
set splitbelow
set splitright

" Search settings
set incsearch
set hlsearch
set ignorecase
set smartcase

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
autocmd FileType c,cpp,java,php,python,javascript,html,ruby autocmd BufWritePre <buffer> :call setline(1,map(getline(1 ,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Plugin related settings
"" YouCompleteMe
nnoremap <Leader>d :YcmCompleter GoToDefinition<CR>
let g:ycm_goto_buffer_command = 'split-or-existing-window'
let g:ycm_rust_src_path = '~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

"" fzf
nnoremap ` :FZF<CR>
nnoremap <C-P> :Ag<CR>
nnoremap <Leader>b :Buffers<CR>
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
let g:AutoPairsShortcutFastWrap = '<C-e>'
""" Extra settings added in 'optroot' fork
let g:AutoPairsMultilineClose = 0
let g:AutoPairsBalanceImmediately = 1
let g:AutoPairsNeverJumpLines = 1
let g:AutoPairsOnlyBeforeClose = 1

"" vim-go
let g:go_template_autocreate = 0

"" ALE
let g:ale_php_phpmd_ruleset = ''
let g:ale_lint_delay = 1000

" vim-dispatch
let g:nremap = {"`": "\""}

"" vimwiki
nmap <Leader>vw <Plug>VimwikiIndex
nmap <Leader>vt <Plug>VimwikiTabIndex
nmap <Leader>vs <Plug>VimwikiUISelect
nmap <Leader>vi <Plug>VimwikiDiaryIndex
nmap <Leader>v<Leader>w <Plug>VimwikiMakeDiaryNote
nmap <Leader>v<Leader>t <Plug>VimwikiTabMakeDiaryNote
nmap <Leader>v<Leader>y <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>v<Leader>m <Plug>VimwikiMakeTomorrowDiaryNote
nmap <Leader>v<Leader>i <Plug>VimwikiDiaryGenerateLinks
let g:vimwiki_list = [{'path': '~/vimwiki/',
                     \ 'syntax': 'markdown', 'ext': '.md'}]

"" nerdcommenter
nmap  <Plug>NERDCommenterToggle<CR>
vmap  <Plug>NERDCommenterToggle<CR>
