function! Init()
    set filetype=todo
    setlocal tabstop=2
    setlocal shiftwidth=2 expandtab
    setlocal cursorline
    setlocal noautoindent
    nno <leader>ts :StartItem()<CR>
    nno <leader>tc :CancelItem()<CR>
    nno <leader>td :CompleteItem()<CR>
    nno <leader>tN :CreateItemAbove()<CR>
    nno <leader>tn :CreateItemBelow()<CR>
endfunction

function! AppendDate()
    let l:date = strftime("%d-%m-%y %H:%M")
    execute "s/$/(" . l:date . ")"
endfunction

function! TodoCreateItemAbove()
    normal! O☐ 
    startinsert!
endfunction

function! TodoCreateItemBelow()
    normal! o☐ 
    startinsert!
endfunction

function! TodoStartItem()
    execute "s/$/ @started"
    call AppendDate()
    let l:lineno = line('.')
    let l:line = getline(l:lineno)
    call setline(l:lineno, substitute(l:line, '\(✘|✔\)', '☐', ''))
endfunction

function! TodoCompleteItem()
    execute "s/$/ @done"
    call AppendDate()
    let l:lineno = line('.')
    let l:line = getline(l:lineno)
    call setline(l:lineno, substitute(l:line, '\(☐|✘\)', '✔', ''))
endfunction

function! TodoCancelItem()
    execute "s/$/ @cancelled"
    call AppendDate()
    execute "s/\[☐✔\]/✘"
endfunction

augroup auto_commands
    autocmd!
    autocmd BufRead,BufNewFile *.todo call Init()
augroup end

command! TodoCreateItemAbove silent call TodoCreateItemAbove()
command! TodoCreateItemBelow silent call TodoCreateItemBelow()
command! -range TodoStartItem silent <line1>,<line2>call TodoStartItem()
command! -range TodoCompleteItem silent <line1>,<line2>call TodoCompleteItem()
command! -range TodoCancelItem silent <line1>,<line2>call TodoCancelItem()
