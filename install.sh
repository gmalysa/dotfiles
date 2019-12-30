#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
CYAN="\e[36m"
CLEAR="\e[0m"

INFO="${CYAN}[ INFO ]${CLEAR}"
SUCCESS="${GREEN}[ GOOD ]${CLEAR}"
FAILURE="${RED}[ BAD  ]${CLEAR}"
UPDATE="${BLUE}[UPDATE]${CLEAR}"
ECHO="echo -e"

function show_usage() {
	echo
	echo "Usage:"
	echo
	echo "    install.sh [-u]"
	echo
	echo "If -u is specified, attempt to upgrade existing files. Otherwise, do nothing."
	echo
	exit 1
}

PATHOGEN_DEST=~/.vim/autoload/pathogen.vim
function install_pathogen() {
	mkdir -p ~/.vim/autoload
	cp ./vim-plugins/vim-pathogen/autoload/pathogen.vim ${PATHOGEN_DEST}
	if [ -a ${PATHOGEN_DEST} ]; then
		${ECHO} "${SUCCESS} Pathogen installed."
	else
		${ECHO} "${FAILURE} Pathogen install failed."
	fi
}

DO_UPDATE=0

if [ "$#" -gt "0" ]; then
	if [ "$1" != "-u" ]; then
		show_usage;
	else
		DO_UPDATE=1
		${ECHO} "${UPDATE} Update mode selected."
	fi
fi

SELFDIR=$(dirname $0)
SRCDIR=$(readlink -m ${SELFDIR})

# Jump to script directory for relative paths to files we need
pushd $(dirname $0) > /dev/null

# First, install pathogen if it hasn't been already
if [ -a ${PATHOGEN_DEST} ]; then
	${ECHO} "${INFO} pathogen already installed."
	if [ "${DO_UPDATE}" -eq "1" ]; then
		${ECHO} "${UPDATE} Updating pathogen anyway"
		install_pathogen;
	fi
else
	install_pathogen;
fi

# Next, install vimrc
if [ -a ~/.vimrc ]; then
	${ECHO} "${INFO} A .vimrc already exists. You should manually merge .vimrc files."
else
	${ECHO} "${INFO} Installing .vimrc."
	cp ${SRCDIR}/vimrc ~/.vimrc
	if [ -a ~/.vimrc ]; then
		${ECHO} "${SUCCESS} .vimrc installed."
	else
		${ECHO} "${FAILURE} .vimrc could not be created."
	fi
fi

# Next, add link to plugins for .vim
if [ -L ~/.vim/vim-plugins ]; then
	${ECHO} "${INFO} vim-plugins already linked."
else
	${ECHO} "${INFO} Setting up vim-plugins symlink."
	ln -s ${SRCDIR}/vim-plugins ~/.vim/vim-plugins
	if [ -L ~/.vim/vim-plugins ]; then
		${ECHO} "${SUCCESS} vim-plugins linked."
	else
		${ECHO} "${FAILURE} vim-plugins could not be linked."
	fi
fi

# Next, add link to personal scripts for .vim
if [ -L ~/.vim/vim-scripts ]; then
	${ECHO} "${INFO} vim-scripts already linked."
else
	${ECHO} "${INFO} Setting up vim-scripts symlink."
	ln -s ${SRCDIR}/vim-scripts ~/.vim/vim-scripts
	if [ -L ~/.vim/vim-scripts ]; then
		${ECHO} "${SUCCESS} vim-scripts linked."
	else
		${ECHO} "${FAILURE} vim-scripts could not be linked."
	fi
fi

# Add screenrc
if [ -a ~/.screenrc ]; then
	${ECHO} "${INFO} A .screenrc already exists. You should manually merge .screenrc files."
else
	${ECHO} "${INFO} Installing .screenrc."
	cp ${SRCDIR}/screenrc ~/.screenrc
	if [ -a ~/.screenrc ]; then
		${ECHO} "${SUCCESS} .screenrc installed."
	else
		${ECHO} "${FAILURE} .screenrc could not be created."
	fi
fi

# Add gitconfig
if [ -a ~/.gitconfig ]; then
	${ECHO} "${INFO} A .gitconfig already exists. You should manually merge .gitconfig files."
else
	${ECHO} "${INFO} Installing .gitconfig."
	cp ${SRCDIR}/_gitconfig ~/.gitconfig
	if [ -a ~/.gitconfig ]; then
		${ECHO} "${SUCCESS} .gitconfig installed."
	else
		${ECHO} "${FAILURE} .gitconfig could not be created."
	fi

	cp ${SRCDIR}/git-credential-helper-pass /usr/libexec/git-core
fi

# Add prompt instructions
$ECHO "${INFO} Add these lines to bashrc in order to set up color prompt:"
${ECHO} "	if [[ \${EUID} == 0 ]] ; then"
${ECHO} "		PS1+='\\[\\033[01;31m\\][\\u@\\h\\[\\033[01;34m\\] \\w\\[\\033[01;31m\\]]\\\$\\[\\033[00m\\] '"
${ECHO} "	else"
${ECHO} "		PS1+='\\[\\033[01;32m\\][\\u@\\h\\[\\033[01;34m\\] \\w\\[\\033[01;32m\\]]\\\$\\[\\033[00m\\] '"
${ECHO}	"	fi"

# Go back to whereever we were called from
popd > /dev/null
