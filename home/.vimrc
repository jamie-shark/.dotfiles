set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin('~/.vim/bundle/')
Plugin 'gmarik/Vundle.vim'
call vundle#end()
filetype plugin indent on

Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'diepm/vim-rest-console'
Plugin 'itchyny/lightline.vim'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround.git'
Plugin 'mattn/emmet-vim'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'vim-scripts/loremipsum.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'vim-syntastic/syntastic.git'
Plugin 'junegunn/goyo.vim.git'
Plugin 'junegunn/limelight.vim.git'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'reedes/vim-pencil'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'ervandew/supertab.git'

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

if &diff
    colorscheme evening
endif

call togglebg#map("<F5>")

au GUIEnter * simalt ~x

set tabstop=4
set softtabstop=4
set shiftwidth=4
"set textwidth=79
set expandtab
set autoindent
set fileformat=unix
set foldmethod=indent
set foldlevel=99
set encoding=utf-8
"soft wrap. only insert linebreaks when <CR> pressed
set wrap
set linebreak
"show line numbers
set nu
"show relative line numbers around the cursor
set rnu
"keep rows visible above and below the cursor
set so=5
"set spell check language and disable. Enable for certain file types
set spell spelllang=en_gb
set nospell
au BufNewFile,BufRead *.txt, *.md set spell
"make buffer modifiable
set ma
"set cursorcolumn
set mouse=a
"enable lazy redraw
set lz
"search while typing
set incsearch
"highlight searches. nohls to stop highlighting
set hls
"highlight the current cursor line
set cul
"search for project specific vimrc files in the working dir
set exrc
"don't allow unsafe commands to run from these files
set secure

function! Hashbang(portable, permission, RemExt)
    let shells = {
            \    'awk': "awk",
            \     'sh': "bash",
            \     'hs': "runhaskell",
            \     'jl': "julia",
            \    'lua': "lua",
            \    'mak': "make",
            \     'js': "node",
            \      'm': "octave",
            \     'pl': "perl",
            \    'php': "php",
            \      'r': "Rscript",
            \     'rb': "ruby",
            \  'scala': "scala",
            \    'tcl': "tclsh",
            \     'tk': "wish",
            \     'hy': "hy"
            \    }
    let extension = expand("%:e")
    if has_key(shells,extension)
        let fileshell = shells[extension]
        if a:portable
            let line =  "#!/usr/bin/env " . fileshell
        else
            let line = "#!" . system("which " . fileshell)
        endif
        0put = line
        if a:permission
            :autocmd BufWritePost * :autocmd VimLeave * :!chmod u+x %
        endif
        if a:RemExt
            :autocmd BufWritePost * :autocmd VimLeave * :!mv % "%:p:r"
        endif
    endif
endfunction

au BufNewFile,BufRead *.js, *.html, *.css, *.rb, *.clj
    \:set tabstop=2
    \:set softtabstop=2
    \:set shiftwidth=2

au BufNewFile,BufRead *.cake set filetype=cs

au BufNewFile *.* :call Hashbang(1,1,0)

"shift focus in direction
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

"exit insert/visual mode
ino jj <esc>
cno jj <c-c>
vno v <esc>

"resize splits
nmap - <C-W>-
nmap + <C-W>+
nmap <M-<> <C-W><
nmap <M->> <C-W>>

"open vimrc
let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>

"vim-rest-console
let g:vrc_trigger = '<C-J>'
let g:vrc_curl_opts = {
      \ '--connect-timeout' : 10,
      \ '-L': '',
      \ '-i': '',
      \ '--max-time': 60,
      \ '--ipv4': '',
      \ '-k': '',
\}

"vim-markdown-preview
let vim_markdown_preview_hotkey='<C-m>'

"fullscreen preview
map <F11> :Goyo<CR>:GitGutterEnable<CR>

nnoremap <silent><C-Left> :<C-u>call search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent><C-Right> :<C-u>call search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent><C-Left> <C-o>:call search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent><C-Right> <C-o>:call search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%$','W')<CR>

" NERDTree config
let NERDTreeIgnore=['\~$'] "ignore files in NERDTree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

syntax on
filetype on
