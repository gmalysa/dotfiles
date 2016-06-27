" Only when we're inside a screen session, add specific options
if &term == "screen" || &term == "screen-256color"
	" Update the title for screen status line
	let &titleold=fnamemodify($SHELL,":t")
	set t_ts=k
	set t_fs=\
	set title
	autocmd BufEnter * let &titlestring = "vim ".expand("%:t")

	" When we find an existing file, try to switch to that process in screen
	function! HandleExisting()
		let ownerPID = system("lsof ".v:swapname." | grep vim | awk '{printf \"%d\",$2}'")
		if ownerPID > 0
			let windowID = system("cat /proc/".ownerPID."/environ | tr '\\0' '\\n' | grep WINDOW= | tail -c +8")
			exe ":!screen -X select " . windowID
			let v:swapchoice = "q"
		else
			echo "No running vim owner found."
			let v:swapchoice = "d"
		end
	endfunction

	autocmd SwapExists * call HandleExisting()
endif
