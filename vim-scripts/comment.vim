function! s:CommentLines(mode, uncomment)
	let prefix = ""
	if a:mode == 'v'
		let prefix = "'<,'>"
	endif

	let sym = nr2char(getchar())
	if sym == "/"
		let sym = "\\/\\/"
	endif

	if a:uncomment == 1
		exe ":" . prefix . "s/^\\(\\s\\+\\)\\?" . sym . "/\\1"
	else
		exe ":" . prefix . "s/^/" . sym
	endif
	exe ":let @/=\"\""
endfunction

nnoremap <C-k> :<C-U>call s:CommentLines('n', 0)<CR>
vnoremap <C-k> :<C-U>call s:CommentLines('v', 0)<CR>
nnoremap <C-j> :<C-U>call s:CommentLines('n', 1)<CR>
vnoremap <C-j> :<C-U>call s:CommentLines('v', 1)<CR>
