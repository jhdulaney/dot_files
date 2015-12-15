
"execute pathogen#infect()


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

set background=dark
syntax enable
set encoding=utf8
set ffs=unix,dos,mac

syn on se title

filetype plugin indent on

set expandtab
set shiftwidth=4
set tabstop=4

set laststatus=1

noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

set incsearch
set nohls

set nu

set ignorecase
set smartcase

set scrolloff=2

set wildmode=longest,list
set wildignore=*.o,*~,*.pyc

filetype plugin on
filetype indent on

set autoread

set so=7

set backspace=eol,start,indent

set magic

set noerrorbells
set novisualbell

map <silent> <C-h> :wincmd h<CR>
map <silent> <C-j> :wincmd j<CR>
map <silent> <C-k> :wincmd k<CR>
map <silent> <C-l> :wincmd l<CR>

"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

