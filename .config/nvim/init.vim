call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nsf/gocode'
Plug 'fatih/vim-go'
Plug 'chriskempson/base16-vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()

set updatetime=250

set relativenumber
set number

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

colorscheme base16-tomorrow-night

let g:airline_theme='base16'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

map <C-\> :NERDTreeToggle<CR>

nmap <C-p> :Files<CR>
nmap <C-o> :Buffers<CR>

nmap <C-g> :Goyo<CR>
