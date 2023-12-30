"Plugins"
call plug#begin('~/.vim/plugged')
Plug 'rose-pine/vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"Base configuration"
set history=100
set undolevels=50

set termguicolors
syntax enable
set background=dark
colorscheme rosepine
let g:airline_theme='zenburn'

set backup
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/temp
set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set nowrap

"Terminal configuration"
set scrolloff=8
set signcolumn=yes
set colorcolumn=120
highlight ColorColumn ctermbg=0*
