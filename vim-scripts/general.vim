" Force 256 color mode
set t_Co=256

" Usability options and behavior
set nu
set ai
set ts=4
set sw=4
set nobackup
set autoread
set mouse=a
set incsearch
set ignorecase
set smartcase
set noexpandtab
color torte
syntax on
map  :noh<CR>
set formatoptions-=cro

" Cursor line highlighting
set cursorline
highlight CursorLine guibg=Grey10
highlight CursorLine ctermbg=234
highlight CursorLine cterm=none
set colorcolumn=100
highlight ColorColumn guibg=#330000
highlight ColorColumn ctermbg=52

" Completion menu colors options
highlight Pmenu ctermfg=38 ctermbg=235
highlight PmenuSel ctermfg=0 ctermbg=31
