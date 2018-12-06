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
Plugin 'w0rp/ale'
Plugin 'PProvost/vim-ps1.git'
Plugin 'bitc/vim-bad-whitespace.git'
Plugin 'pangloss/vim-javascript.git'
Plugin 'mxw/vim-jsx'
Plugin 'qpkorr/vim-renamer.git'
Plugin 'gregsexton/gitv'
Plugin 'terryma/vim-multiple-cursors.git'
Plugin 'cohama/lexima.vim'
" Load devicons last!
Plugin 'ryanoasis/vim-devicons'

""" Plugin Configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_skip_empty_sections = 1
let g:airline_enable_syntatic = 1

" nerdtree
let NERDTreeIgnore=['\~$'] "ignore files in NERDTree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeHijackNetrw=1

" multiple cursors
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<A-d>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<A-d>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" javascript
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" ALE
let g:ale_completion_enabled = 1
nno <F12> :ALEGoToDefinition<CR>
nno <leader><F12> :ALEFindReferences<CR>

syntax on
filetype on

""" Settings
set shiftwidth=0
set softtabstop=-1
set tabstop=4
set expandtab
set fileformat=unix
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1
set encoding=utf-8
set nowrap
set linebreak
set number
set relativenumber
set scrolloff=5
set nofixeol
set modifiable
set mouse=ar
set lazyredraw
set incsearch
set hls
set ignorecase
set smartcase
set exrc
set secure
set nocompatible
set laststatus=2
set backupdir=$TEMP//
set directory=$TEMP//
set wildmode=longest,list,full
set wildmenu
set clipboard^=unnamed,unnamedplus
set viewoptions=folds,options,cursor,unix,slash

""" File type specific settings
au BufNewFile,BufRead *.js,*.html,*.css,*.rb,*.clj,*.scala,*.lua,*.yaml setlocal tabstop=2
au BufNewFile,BufRead *.cake set filetype=cs
au BufNewFile,BufRead *.ps1,*.psd1,*.psm1,*.bat,*.cmd setlocal ft=ps1
if &diff
    highlight! link DiffText MatchParen
endif

""" gVim specific settings
"disable screen flash and error bell on error (e.g. gvim esc while in normal mode)
set noeb vb t_vb=
au GUIEnter * set vb t_vb=
au GUIEnter * simalt ~x " Fullscreen gvim

""" ConEmu specific settings
if has('win32') && !has('gui_running') && !empty($CONEMUBUILD)
    set termencoding=utf8
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    let g:gitgutter_realtime = 0
endif

" diff specific settings
if &diff
    syntax off
endif

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
ino {<CR> <CR>{<CR>}<C-o>O
ino <Space>{<CR> <Space>{<CR>}<C-o>O
nno <leader>v :tabedit $MYVIMRC<CR>
nno <Leader>s :setlocal spell! spelllang=en_gb<CR>
nno <Leader>h :setlocal hls!<CR>
nno <Leader>w :setlocal wrap!<CR>
nno <M-LEFT> <C-O>
nno <M-RIGHT> <C-I>
xno <LeftMouse> m'<LeftMouse>
vno // y/\V<C-r>=escape(@",'/\')<CR><CR>
vno <C-C> "+y
ino <C-V> <ESC>"+pa

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nno <silent> <leader>mw :call MarkWindowSwap()<CR>
nno <silent> <leader>pw :call DoWindowSwap()<CR>

fun! CountWordFunction()
    try
        let l:win_view = winsaveview()
        let l:old_query = getreg('/')
        let var = expand("<cword>")
        exec "%s/" . var . "//gn"
    finally
        call winrestview(l:win_view)
        call setreg('/', l:old_query)
    endtry
endf
" Bellow we set a command "CountWord" and a mapping to count word
" change as you like it
command! -nargs=0 CountWord :call CountWordFunction()
nnoremap <f3> :CountWord<CR>
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>:CountWord<cr>
