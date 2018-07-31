""" Settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set foldlevel=99
set encoding=utf-8
set wrap
set linebreak
set number
set relativenumber
set scrolloff=5
set modifiable
set mouse=ar
set lazyredraw
set incsearch
set hls
set exrc
set secure
set nocompatible

""" File type specific settings
au BufNewFile,BufRead *.js, *.html, *.css, *.rb, *.clj, *.scala, *.lua
    \set tabstop=2
    \set softtabstop=2
    \set shiftwidth=2
au BufNewFile,BufRead *.cake set filetype=cs

""" gVim specific settings
"disable screen flash and error bell on error (e.g. gvim esc while in normal mode)
set noeb vb t_vb=
au GUIEnter * set vb t_vb=
au GUIEnter * simalt ~x " Fullscreen gvim

""" Keybindings
let mapleader = ","
nno <silent> <C-h> :wincmd h<CR>
nno <silent> <C-j> :wincmd j<CR>
nno <silent> <C-k> :wincmd k<CR>
nno <silent> <C-l> :wincmd l<CR>
nno - <C-W>-
nno + <C-W>+
nno <M-<> <C-W><
nno <M->> <C-W>>
ino jj <esc>
cno jj <c-c>
vno v <esc>
nno =j :%!python -m json.tool<CR>
ino {<CR> <CR><BS>{<CR>}<C-o>O
nno <leader>v :tabedit $MYVIMRC<CR>
nno <Leader>s :setlocal spell! spelllang=en_gb<CR>
nno <Leader>h :setlocal hls!<CR>

""" Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin('~/.vim/bundle/')
Plugin 'gmarik/Vundle.vim'
call vundle#end()
filetype plugin indent on

Plugin 'airblade/vim-gitgutter.git'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ervandew/supertab.git'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'mhinz/vim-startify.git'
Plugin 'plasticboy/vim-markdown'
Plugin 'reedes/vim-pencil'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-abolish.git'
Plugin 'tpope/vim-dispatch.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic.git'

""" Plugin Configuration
let g:airline_base16_solarized = 1

" nerdtree
let NERDTreeIgnore=['\~$'] "ignore files in NERDTree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeHijackNetrw=1

syntax on
filetype on
