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

set listchars=tab:»-,extends:›,precedes:‹,nbsp:·,trail:·,space:·

" Racket-specific stuff
au filetype scheme set expandtab
au filetype scheme set ts=2
au filetype scheme set sw=2
set lispwords+=define/contract,syntax-case
imap <C-l> λ

" Cursor line highlighting
set cursorline
highlight CursorLine guibg=Grey10
highlight CursorLine ctermbg=234
highlight CursorLine cterm=none
hi CursorLineNr ctermbg=234
set colorcolumn=90
highlight ColorColumn guibg=#330000
highlight ColorColumn ctermbg=52
hi Search ctermfg=172
hi IncSearch ctermfg=172

" Completion menu colors options
highlight Pmenu ctermfg=38 ctermbg=235
highlight PmenuSel ctermfg=0 ctermbg=31
