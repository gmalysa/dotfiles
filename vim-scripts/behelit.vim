let g:airline#themes#behelit#palette = {}

let s:fg_hi = '#eeeeee'
let s:bg1 = '#080808'
let s:bg2 = '#1c1c1c'
let s:bg3 = '#262626'

" Normal mode
let s:N1 = [ s:fg_hi, s:bg1, 15, 232  ]
let s:N2 = [ '#0055ff', s:bg1, 69 , 232 ]
let s:N3 = [ '#0055ff', s:bg1, 69 , 232 ]
let g:airline#themes#behelit#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#behelit#palette.normal_modified = {
      \ 'airline_c': [ '#c02f1d', s:bg1, 161, 232, '' ],
      \ }

" Insert mode
let s:I1 = [ s:fg_hi, s:bg1, 15, 232 ]
let s:I2 = [ '#00d75f', s:bg1, 48, 232 ]
let s:I3 = [ '#00d75f', s:bg1, 48, 232 ]
let g:airline#themes#behelit#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#behelit#palette.insert_modified = g:airline#themes#behelit#palette.normal_modified
let g:airline#themes#behelit#palette.insert_paste = {
      \ 'airline_a': [ "#121212", "#5f5faf", 233, 61, '' ],
      \ }

" Replace mode
let s:R1 = [ s:fg_hi, s:bg1, 15, 232 ]
let s:R2 = [ '#c02f1d', s:bg1, 161, 232 ]
let s:R3 = [ '#c02f1d', s:bg1, 161, 232 ]
let g:airline#themes#behelit#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#behelit#palette.replace_modified = g:airline#themes#behelit#palette.insert_modified

" Visual mode
let s:V1 = [ s:fg_hi, s:bg1, 15, 232 ]
let s:V2 = [ s:fg_hi, s:bg1, 208, 232 ]
let s:V3 = [ s:fg_hi, s:bg1, 208, 232 ]
let g:airline#themes#behelit#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#behelit#palette.visual_modified = g:airline#themes#behelit#palette.normal_modified

" Inactive window
let s:IA1 = [ '#4e4e4e', s:bg1, 239, 232, '' ]
let s:IA2 = [ '#4e4e4e', s:bg1, 239, 232, '' ]
let s:IA3 = [ '#4e4e4e', s:bg1, 239, 232, '' ]
let g:airline#themes#behelit#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#behelit#palette.inactive_modified = {
      \ 'airline_c': [ '#5f5f87', s:bg1, 60, 232, '' ],
      \ }

" Accents
let g:airline#themes#behelit#palette.accents = {
      \ 'red': [ '#d7005f', '', 161, '' ]
      \ }

" Warnings
let s:WI = [ '#d7005f', s:bg1, 233, 161 ]
let g:airline#themes#behelit#palette.normal.airline_warning = s:WI
let g:airline#themes#behelit#palette.normal_modified.airline_warning = s:WI
let g:airline#themes#behelit#palette.insert.airline_warning = s:WI
let g:airline#themes#behelit#palette.insert_modified.airline_warning = s:WI
let g:airline#themes#behelit#palette.insert_paste.airline_warning = s:WI
let g:airline#themes#behelit#palette.visual.airline_warning = s:WI
let g:airline#themes#behelit#palette.visual_modified.airline_warning = s:WI
let g:airline#themes#behelit#palette.replace.airline_warning = s:WI
let g:airline#themes#behelit#palette.replace_modified.airline_warning = s:WI
