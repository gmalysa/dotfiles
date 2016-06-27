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

	autocmd FileType tex map <F5> :Tex<CR>
	autocmd FileType tex map! <F5> :Tex<CR>
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

function! s:TexCompile()
  exec ":silent !pdflatex " . expand('%:p')
endfunction

function! s:BibtexCompile()
  exec ":silent !bibtex " . substitute(expand('%:t'), '\..*$', '', 'g')
endfunction

function! s:PdfView()
  exec ":silent !start \"C:\\Program Files (x86)\\Adobe\\Acrobat Reader DC\\Reader\\AcroRd32.exe\" " . substitute(expand('%:t'), '\..*$', '.pdf', 'g')
endfunction
