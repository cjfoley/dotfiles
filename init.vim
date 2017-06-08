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
nmap ∫∫ :b#<Return>

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
Plug 'scrooloose/syntastic'
Plug 'kien/rainbow_parentheses.vim'
" fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

" airline
" turns on the fancy arrow separators
let g:airline_powerline_fonts = 0
let g:airline_section_c = airline#section#create(['%F'])
let g:airline_section_x = airline#section#create(['%r'])
let g:airline_section_y = airline#section#create(['%{getcwd()}'])
let g:airline_section_z = airline#section#create(['%n'])

" Find command using rg and fzf
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

let g:syntastic_javascript_checkers = ['jshint']

" always on rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
