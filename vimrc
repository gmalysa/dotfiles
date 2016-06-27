" Add plugin paths
execute pathogen#infect('~/.vim/vim-plugins/{}')
execute pathogen#infect('~/.vim/vim-scripts/{}')

" Source all of my scripts normally
for file in split(glob('~/.vim/vim-scripts/*.vim'), '\n')
	exe 'source' file
endfor
