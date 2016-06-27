nnoremap [unite] <Nop>
nmap , [unite]

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#profile('default', 'context', {
\	'start_insert' : 1,
\	'prompt' : "> ",
\	'prompt-visible' : 1,
\	'direction' : "botright",
\	'winheight' : 10
\})

nnoremap <silent> [unite]c :<C-u>UniteClose<CR>
nnoremap <silent> [unite]r :<C-u>UniteResume<CR>

nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]F :<C-u>Unite file<CR>
nnoremap <silent> [unite]f :<C-u>Unite file_rec<CR>
nnoremap <silent> [unite]s :<C-u>Unite source<CR>

nnoremap <silent> [unite]t :<C-u>Unite tag<CR>
nnoremap <silent> [unite]T :<C-u>UniteWithCursorWord tag<CR>
inoremap <silent> <C-t> :<C-u>UniteWithCursorWord tag<CR>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
	" imap <buffer> <ESC> <Plug>(unite_exit)
	imap <buffer> <c-j> <Plug>(unite_insert_leave)
	imap <buffer> <c-k> <Plug>(unite_insert_leave)
	nmap <buffer> <c-j> <Plug>(unite_loop_cursor_down)
	nmap <buffer> <c-k> <Plug>(unite_loop_cursor_up)
	nmap <buffer> <Tab> <Plug>(unite_loop_cursor_down)
	nmap <buffer> <S-Tab> <Plug>(unite_loop_cursor_up)
endfunction
