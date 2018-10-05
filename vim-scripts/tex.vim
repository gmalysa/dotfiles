" TeX-specific macros and settings that are different from editing code
augroup texsettings
	au!
	autocmd FileType tex set tw=100
	autocmd FileType tex set nohlsearch

	" From a stackexchange answer, define gqlp to reflow paragraphs while
	" respecting certain latex keywords
	autocmd FileType tex map \gq ?^$\\|^\s*\(\\begin\\|\\end\\|\\section\\|\\subsection\\|\\label\)?1<CR>gq//-1<CR>
	autocmd FileType tex omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\section\\|\\subsection\\|\\label\)?1<CR>//-1<CR>.<CR>

	autocmd FileType tex command! -nargs=1 Begin call s:TexBegin(<q-args>)
	autocmd FileType tex command! -nargs=0 Tex call s:TexCompile()
	autocmd FileType tex command! -nargs=0 Bib call s:BibtexCompile()
	autocmd FileType tex command! -nargs=0 Pdf call s:PdfView()
	autocmd FileType tex command! -nargs=0 Idx call s:MakeindexCompile()
	autocmd FileType tex command! -nargs=0 TexRebuild call s:TexRebuild()

	autocmd FileType tex map <F5> :TexRebuild<CR>
	autocmd FileType tex map! <F5> :TexRebuild<CR>
	autocmd FileType tex map <F6> :Bib<CR>
	autocmd FileType tex map! <F6> :Bib<CR>
	autocmd FileType tex map <F4> :Pdf<CR>
	autocmd FileType tex map! <F4> :Pdf<CR>
augroup END

function! s:TexBegin(body)
	let body = a:body
	call append(line('.')-1, ["\\begin{" . body . "}", "\\end{" . body ."}"])
	echo line('.')
	exec "normal! ".(line('.')-1)."G"
	exec "normal! O"
	exec "startinsert"
endfunction

" Search for a given latex command by doing a string search on the document
function! s:CheckForCommand(cmd)
	let prev_position = getpos(".")
	call cursor(0,0)
	let result = search(a:cmd, "c")
	call setpos('.', prev_position)
	return result ? 1 : 0
endfunction

function! s:TexCompile()
  exec ":silent !pdflatex " . expand('%:p')
  exec ":redraw!"
endfunction

function! s:BibtexCompile()
  exec ":silent !bibtex " . substitute(expand('%:t'), '\..*$', '', 'g')
  exec ":redraw!"
endfunction

function! s:MakeindexCompile()
  exec ":silent !makeindex " . expand('%:t:r')
  exec ":redraw!"
endfunction

function! s:PdfView()
  exec ":silent !qpdfview " . substitute(expand('%:t'), '\..*$', '.pdf', 'g')
  exec ":redraw!"
endfunction

" Master function to try rebuilding everything if necessary
function! s:TexRebuild()
	let build_again = 0
	call s:TexCompile()

	if s:CheckForCommand('\printindex')
		call s:MakeindexCompile()
		let build_again = 1
	end

	if s:CheckForCommand('\bibliography')
		call s:BibtexCompile()
		let build_again = 1
	end

	if build_again
		call s:TexCompile()
	end
endfunction

