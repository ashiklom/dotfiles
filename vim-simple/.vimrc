call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

call plug#end()

let mapleader=" "
let localleader="\\"

set noswapfile
set ignorecase
set smartcase
set wildmenu

set tabstop=4
set shiftwidth=4
set expandtab

inoremap jk <ESC>
nnoremap S :w!<CR>

nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
vnoremap <expr> j v:count == 0 ? 'gj' : 'j'
vnoremap <expr> k v:count == 0 ? 'gk' : 'k'

nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

map Q <Nop>
map K <Nop>

nmap <leader>; <plug>NERDCommenterToggle
nmap <silent> <leader>gs :Gstatus<CR>
