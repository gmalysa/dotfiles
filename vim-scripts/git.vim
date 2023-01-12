
" Not all just the ones i'm likely to come across
let s:gitwords = "\\(pick\\|reword\\|edit\\|squash\\)"

function! s:GitPick()
	exec ":s/^" . s:gitwords . "/pick/"
endfunction

function! s:GitSquash()
	exec ":s/^" . s:gitwords . "/squash/"
endfunction

" todo make this show up in a single reusable window instead of always
" splitting so that it's easier to just scan them
function! s:GitShow()
	let lwords = split(getline('.'))
	if (len(lwords) > 2)
		let tbuf = term_start(['git', '--no-pager', 'show', lwords[1]],
			\ #{hidden: 1})

		let pwin = popup_create(tbuf, #{
			\ line: "cursor+1",
			\ col: "cursor",
			\ minwidth: winwidth(0)/2,
			\ maxwidth: winwidth(0)/2,
			\ minheight: winheight(0)/2,
			\ maxheight: winheight(0)/2,
			\ wrap: 0,
			\ highlight: 'terminal',
			\ border: [1, 1, 1, 1],
			\ padding: [1, 1, 1, 1],
			\ title: "git show " . lwords[1],
			\ scrollbar: 0
			\ })
	else
		echo "not on a line that looks like a git commit"
	end
endfunction

autocmd FileType gitrebase nmap ,g :call <SID>GitShow()<CR>
autocmd FileType gitrebase nmap ,p :call <SID>GitPick()<CR>
autocmd FileType gitrebase nmap ,s :call <SID>GitSquash()<CR>
