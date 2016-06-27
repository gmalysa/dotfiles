set laststatus=2
set nosmd

function! s:AirlineInit()
	let spc = g:airline_symbols.space
	exe ":AirlineTheme behelit"

	" Set up sections
	let g:airline_section_a = airline#section#create(['mode'])
	let g:airline_section_c = airline#section#create(['%<', 'file', spc, 'readonly'])
	let g:airline_section_x = airline#section#create_right(['filetype'])
	let g:airline_section_y = airline#section#create(['ffenc'])
	let g:airline_section_z = airline#section#create(['%-4l/%4L'.spc, ':%5(%c%V%)'])

	" Reconfigure some extensions
	let g:airline#extensions#whitespace#checks = ['trailing']

	" Fix some keywords
	let g:airline_mode_map['R'] = "RPLACE"
	let g:airline_mode_map['r'] = "RPLACE"
endfunction

autocmd VimEnter * call s:AirlineInit()

" @todo: set up airline theme here instead of separate file?
