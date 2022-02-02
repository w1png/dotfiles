set number
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'lithammer/nvim-pylance'
Plug 'scrooloose/nerdtree'

call plug#end()

nnoremap <C-t> :NERDTreeToggle<CR>

