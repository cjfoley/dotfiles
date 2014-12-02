set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'ervandew/supertab'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
"
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" Put your non-Plugin stuff after this line

let g:lightline = {'colorscheme': 'Tomorrow_Night'}

syntax enable

set hidden
set number 

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

set laststatus=2 "for lightline
set cursorline
set backspace=indent,eol,start "allow backspacing over everything in insert mode
set nowrap
    
"vim stahp
set nobackup 
set noswapfile
