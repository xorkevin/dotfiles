let mapleader = ';'

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
Plug 'zchee/deoplete-jedi'
Plug 'bennyyip/vim-yapf'
Plug 'chriskempson/base16-vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

set nocompatible
filetype plugin on
syntax on
set lazyredraw

set updatetime=500

set relativenumber
set number
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:␣
set list
set tabstop=2
set shiftwidth=2
set expandtab
set conceallevel=2

:autocmd VimResized * wincmd =

"Colours
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

colorscheme base16-tomorrow-night

let g:airline_theme='base16'

"Deoplete
set completeopt+=noinsert
set completeopt+=noselect
set completeopt-=preview

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode-gomod'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#pointer = 1

let g:deoplete#sources#rust#racer_binary='/usr/bin/racer'
let g:deoplete#sources#rust#rust_source_path=$HOME.'.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:deoplete#sources#rust#disable_keymap=1

"Rustfmt
let g:rustfmt_autosave = 1

"Prettier
let g:prettier#autoformat = 0
let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'true'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'false'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#prose_wrap = 'preserve'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql Prettier

"YAPF
autocmd FileType python YapfAutoEnable

"Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"Keybindings
nmap <C-\> :NERDTreeToggle<CR>

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

nmap <C-p> :Files<CR>
nmap <C-o> :Buffers<CR>

inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
imap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
imap <expr> <cr>    pumvisible() ? deoplete#close_popup() : "\<cr>"

nmap <leader>g :Goyo<CR>
nmap <Leader>py <Plug>(Prettier)

nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>s :w<CR>
nnoremap <C-C> <C-A>
