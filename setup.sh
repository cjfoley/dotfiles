#!/bin/bash

DIR=~/dotfiles

FILES="
    .bashrc 
    .vimrc 
    .screenrc 
    .tmux.conf 
    .psqlrc 
    .ansible.cfg 
    .muttrc 
    .config/nvim/init.vim
"

echo "=> ${DIR}"
cd ${DIR}

for FILE in $FILES; do
    FILE="${HOME}/${FILE}"

    if [ ! -r "${FILE}" ]; then
        tput setaf 1
        echo "${FILE} is unreadable or doesn't exist..."
        tput sgr0
        continue
    fi

    if [ -L "${FILE}" ]; then
        tput setaf 2
        echo "${FILE} is a symlink..."
        tput sgr0
        continue
    fi

    echo "moving ${FILE}..."
    mkdir -p $(dirname "${FILE}")
    mv "${FILE}" "${DIR}"
    echo "symlinking ${FILE}..."
    ln -s "${DIR}/$(basename ${FILE})" "${FILE}"
done
