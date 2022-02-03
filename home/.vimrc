let mapleader = " "

""" Plugins
call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-signify'
Plug 'gregsexton/gitv'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-startify'
Plug 'reedes/vim-pencil'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
" Plug 'universal-ctags/ctags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'bitc/vim-bad-whitespace'
Plug 'qpkorr/vim-renamer'
Plug 'terryma/vim-multiple-cursors'
Plug 'osyo-manga/vim-over'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'godlygeek/tabular'
"Plug 'PProvost/vim-ps1', { 'for': 'ps1' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'jsx', 'erb', 'cshtml'] }
Plug 'pangloss/vim-javascript', { 'for': ['js', 'jsx'] }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'leafgarland/typescript-vim', { 'for': ['ts', 'tsx'] }
Plug 'OmniSharp/omnisharp-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'juliosueiras/cakebuild.vim', { 'for' : 'cake' }
Plug 'mtth/scratch.vim'
Plug 'mechatroner/rainbow_csv'
Plug 'editorconfig/editorconfig-vim'
Plug 'posva/vim-vue'
Plug 'mfukar/robotframework-vim', { 'for': 'robot' }
Plug 'sophacles/vim-processing', { 'for': 'pde' }
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'davidhalter/jedi'
Plug 'arcticicestudio/nord-vim'

call plug#end()

""" Plugin Configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" CtrlP
let g:ctrlp_map = '<c-p>'

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
nno <C-n> :NERDTreeToggle<CR>
nno ,n :NERDTreeFind<CR>
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
let g:ale_completion_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
nno <F12> :ALEGoToDefinition<CR>
nno <leader><F12> :ALEFindReferences<CR>
let g:ale_linters = {
            \ 'javascript': ['eslint'],
            \ 'cs': ['OmniSharp'],
            \ 'python': ['flake8', 'pylint'],
            \}
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'javascript': ['eslint'],
            \ 'python': ['yapf'],
            \}

" Over
nno <C-h> :OverCommandLine<CR>:%s/
vno <C-h> :OverCommandLine<CR>s/

" Goyo
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  Pencil
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  NoPencil
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nno <silent> <leader>f :Goyo<CR>

" fzf
let g:fzf_preview_window = 'right:60%'
" let g:fzf_tags_command = 'ctags -R'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=*  All
  \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*}"', 'down': '40%', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi' }))

nmap <silent> <leader>o :All<cr>

" Omnisharp
let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_prefer_global_sln = 1
let g:OmniSharp_timeout = 5
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_highlight_types = 1
augroup omnisharp_commands
    autocmd!
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
    autocmd InsertLeave *.cs call OmniSharp#HighlightBuffer()
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
nnoremap <Leader>cf :OmniSharpCodeFormat<CR>
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

let g:scratch_persistence_file = '~/.scratch'
let g:scratch_autohide = 1

" Tagbar
nnoremap <silent> <F9> :TagbarToggle<CR>

let g:tagbar_type_cake = {
    \ 'ctagstype' : 'cakebuild',
    \ 'kinds' : [
        \ 't:Task'
    \ ]
\ }

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

let g:tagbar_type_xsd = {
    \ 'ctagstype' : 'XSD',
    \ 'kinds'     : [
        \ 'e:elements',
        \ 'c:complexTypes',
        \ 's:simpleTypes'
    \ ]
\ }

let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

if executable('ripper-tags')
  let g:tagbar_type_ruby = {
      \ 'kinds'      : ['m:modules',
                      \ 'c:classes',
                      \ 'C:constants',
                      \ 'F:singleton methods',
                      \ 'f:methods',
                      \ 'a:aliases'],
      \ 'kind2scope' : { 'c' : 'class',
                       \ 'm' : 'class' },
      \ 'scope2kind' : { 'class' : 'c' },
      \ 'ctagsbin'   : 'ripper-tags',
      \ 'ctagsargs'  : ['-f', '-']
      \ }
endif

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>: :History:<CR>
nmap <Leader>/ :History/<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>c :Commits<CR>
nmap <Leader>C :Commands<CR>
nmap <Leader>M :Maps<CR>
nmap <Leader>s :Filetypes<CR>

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "!**/{.git,node_modules,vendor,bin,obj,packages,.vs,lib}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

let g:user_emmet_leader_key='<C-E>'

let g:signify_sign_show_text = 0
highlight SignifySignAdd                  ctermbg=green                guibg=#00ff00
highlight SignifySignDelete ctermfg=black ctermbg=red    guifg=#ffffff guibg=#ff0000
highlight SignifySignChange ctermfg=black ctermbg=yellow guifg=#000000 guibg=#ffff00
highlight SignColumn        ctermbg=NONE  cterm=NONE     guibg=NONE    gui=NONE

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
set completeopt=menu,menuone,preview,noselect,noinsert
set cursorline
set tw=0
set listchars=tab:>~,nbsp:_,trail:.
set list
set wildignore+=*/.git/*,*/.vs/*,*/node_modules/*,*/bin/*,*/obj/*,*/packages/*,*/vendor/*,*/tags,*/*.min.js,*.log,*.xml
set hidden
set title
set titleold=
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set splitbelow
set splitright
set bg=dark
set cmdheight=2
set updatetime=100
set shortmess+=c
set signcolumn=yes
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
colorscheme nord

""" CoC Settings
let g:coc_global_extensions=[
            \ 'coc-json',
            \ 'coc-tsserver',
            \ 'coc-react-refactor',
            \ 'coc-prettier',
            \ 'coc-powershell',
            \ 'coc-angular',
            \ 'coc-fsharp',
            \ 'coc-yaml',
            \ 'coc-xml',
            \ 'coc-yank',
            \ 'coc-jedi'
            \ ]
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-@> coc#refresh()

if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
command! -nargs=0 Prettier :CocCommand prettier.formatFile

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
if has('nvim-0.4.3') || has('patch-8.2.0750')
    nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
endif

nno <F4> :Clap grep ++query=<cword><CR>
ino <F4> :Clap grep ++query=<cword><CR>
vno <F4> :Clap grep ++query=@visual<CR>

""" File type specific settings
au BufNewFile,BufRead *.js,*.html,*.css,*.vue,*.scss,*.hbs,*.jsx,*.ts,*.tsx,*.rb,*.clj,*.scala,*.lua,*.yaml,*.yml setlocal tabstop=2
au BufNewFile,BufRead *.ps1,*.psd1,*.psm1,*.bat,*.cmd setlocal ft=ps1
au BufNewFile,BufRead *.jsx setlocal ft=javascriptreact
au BufNewFile,BufRead *.tsx setlocal ft=typescriptreact
au BufNewFile,BufRead *.pde setlocal ft=java | let g:airline#extensions#tagbar#enabled = 0
if &diff
    highlight! link DiffText MatchParen
endif
au FileType gitcommit setlocal spell

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
endif

" diff specific settings
if &diff
    syntax off
endif

""" Keybindings
nno <C-J> <C-W><C-J>
nno <C-K> <C-W><C-K>
nno <C-L> <C-W><C-L>
nno <C-H> <C-W><C-H>
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
nno <M-L> <C-L>:!clear<CR><CR>
vno <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| xclip <CR><CR>

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

aug AutoCloseWhenQuickFixIsOnlyWindow
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

fun! InstallPlugins()
    PlugInstall
endf
nno <leader>p :w<Bar>so %<Bar>call InstallPlugins()<CR>

if executable('rg')
  set grepprg=rg\ --color=never\ -g "!**/{.git,node_modules,vendor,bin,obj,packages,.vs}/*"
  let g:ctrlp_user_command = 'rg %s --files --color=never -g "!**/{.git,node_modules,vendor,bin,obj,packages,.vs}/*" '
  let g:ctrlp_use_caching = 0

  command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \ <bang>0)
  nnoremap <C-g> :Rg!<Cr>
endif

" Preserve undo history in single file
if has('persistent_undo')
    set undodir=$HOME/.vim_undo_files
    set undolevels=5000
    set undofile
endif

"Goto last location in non-empty files
autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
                   \|     exe "normal! g`\""
                   \|  endif
