set nocompatible
filetype plugin indent on
syntax enable
set hidden
set wildmenu

"python
set tabstop=4   
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent
set copyindent

"search
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

set number
set cursorline
set backspace=indent,eol,start "allow backspacing over everything in insert mode
set nowrap
    
"vim stahp
set nobackup 
set noswapfile

"when crontab files are recognized, edit in place
autocmd filetype crontab setlocal nobackup nowritebackup

let X = getline(1)
    let y = match(X, "#!/bin/bash" )
    if (y != -1)
        so ~/Dropbox/Work/bash.vim
    endif
unlet X
unlet y
