" Automatic reloading of init.vim
autocmd! bufwritepost init.vim source %

" Plugins
call plug#begin()
"" Tmux navigator
Plug 'christoomey/vim-tmux-navigator'
" Fuzzy finder for (file) lists
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
"" Automatic delimiter balancing
Plug 'windwp/nvim-autopairs'
" Improved navigation via %
Plug 'andymass/vim-matchup'
"" Line/block comments
Plug 'scrooloose/nerdcommenter'
"" Various mappings, such as line bubbling, URL encoding, etc.
Plug 'tpope/vim-unimpaired'
"" Mappings for adding and removing character pairs around text
Plug 'tpope/vim-surround'
"" netrw improvements
Plug 'tpope/vim-vinegar'
"" UNIX shell commands in Vim (move, mkdir, chmod etc)
Plug 'tpope/vim-eunuch'
"" Supplies syntax highlighting for various languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
"" Keeps (function) context visible
Plug 'nvim-treesitter/nvim-treesitter-context'
" Cursor movement, swaps, selection motions based on tree-sitter nodes
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
"" Language server client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"" Rust file detection, syntax highlighting, etc.
"Plug 'rust-lang/rust.vim', { 'for': 'rust' }
"" Terraform file syntax
Plug 'hashivim/vim-terraform'
call plug#end()

" Theme / colors
set termguicolors
set background=light
colorscheme solarized-custom

" Backup settings
set updatetime=300  " Also used for the CursorHold event

" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Indenting
filetype indent plugin on
set smartindent
set autoindent
set shiftround

" Splits
set splitbelow
set splitright

" Line numbering
set number
set relativenumber
set signcolumn=no

" Scroll settings
"" Keep X lines above/below the cursor when scrolling
set scrolloff=7
set sidescrolloff=7

" Wild file selection menu
set wildmode=list:longest
set wildmenu
set wildignorecase
set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.jpg,*.jpeg,*.gif,*.png,*/.svn/*,*/.hg/*
set wildignore+=*/.cache/*,*/cache/*

" Rebind <Leader> key
let mapleader = ','

" Shortcut to (force) save buffer
nmap \ :w!<CR>

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
"" Clear search highlights
noremap <silent><Leader>/ :nohls<CR>
"" Sort selection
vmap s :sort<CR>

" Switch to previous buffer with backspace
nmap <BS> <C-^>

" Pre-fill find/replace with text under cursor
nnoremap <F2> :%s#<C-r>=expand("<cword>")<CR>##g<Left><Left>
vnoremap <F2> :<C-u>%s#<C-r>*#

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

"
" Plugin related settings
" 

"" nerdcommenter
"" The <CR> is intentional: it allows you to quickly comment a few lines in a
"" row by just tapping C-/
nmap  <Plug>NERDCommenterToggle<CR>
vmap  <Plug>NERDCommenterToggle<CR>

" Syntax highlighting via tree-sitter
source ${HOME}/.config/nvim/tree-sitter.lua

" Configuration for coc.nvim LSP client
source ${HOME}/.config/nvim/coc.vim

" autopairs configuration
source ${HOME}/.config/nvim/autopairs.lua

"" tmux-navigator
""" Window switching, combined with 'stepping'
""" over into tmux panes
nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <C-BS> :TmuxNavigatePrevious<cr>

"" Telescope
nnoremap <silent> ` :Telescope find_files<CR>
nnoremap <silent> <C-p> :Telescope live_grep<CR>
nnoremap <silent> <Leader>b :Telescope buffers sort_lastused=true<CR>
nnoremap <silent> <Leader>t :Telescope lsp_type_definitions<CR>
nnoremap <silent> <F3> :Telescope grep_string prompt_title=Find\ word<CR>
vnoremap <silent> <F3> "zy:exec 'Telescope grep_string default_text='.escape(@z, ' ').' prompt_title=Find\ visual\ selection'<cr>
