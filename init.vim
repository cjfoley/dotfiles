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

"keymappings
imap jj <Esc>
nmap <C-t> :TagbarToggle<Esc>
nmap <C-f> :Files<Esc>

let X = getline(1)
    let y = match(X, "#!/bin/bash" )
    if (y != -1)
        so ~/Dropbox/Work/bash.vim
    endif
unlet X
unlet y

"vimplug:
call plug#begin()
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
" fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" java autocomplete
Plug 'artur-shaik/vim-javacomplete2'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

" airline
" turns on the fancy arrow separators
let g:airline_powerline_fonts = 1

" Find command using rg and fzf
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" javacomplete2
" also had to manually compile included javavi lib with mvn
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" deoplete
" required pip3 install neovim
let g:deoplete#enable_at_startup = 1
