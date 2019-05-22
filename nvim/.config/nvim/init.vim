let mapleader = ';'

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins
call plug#begin('~/.local/share/nvim/plugged')

"Text manipulation
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

"File management
Plug 'junegunn/fzf.vim'

"Autocomplete
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'

"Autoformat
"Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
"Rust
Plug 'rust-lang/rust.vim'
"JS
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
"Python
Plug 'ambv/black'

"Writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

"Visual
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'

call plug#end()

set nocompatible
filetype plugin on
syntax on
set lazyredraw
set hidden

set updatetime=500

set relativenumber
set number
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:␣
set list
set tabstop=2
set shiftwidth=2
set expandtab
set conceallevel=2
set noshowmode
set signcolumn=yes

autocmd VimResized * wincmd =

"Visual
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

colorscheme base16-tomorrow-night

let g:airline_theme='base16'

"Language client
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rls'],
  \ 'go': ['gopls'],
  \ 'python': ['pyls'],
  \ }

nnoremap <leader>r :call LanguageClient_contextMenu()<CR>

"Deoplete
set completeopt+=noinsert
set completeopt+=noselect
set completeopt-=preview

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1

inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
imap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
imap <expr> <cr>    pumvisible() ? deoplete#close_popup() : "\<cr>"

"Echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

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
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml Prettier

"Black
autocmd BufWritePre *.py execute ':Black'

"Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
nnoremap <leader>g :Goyo<CR>

"Keybindings
nnoremap <leader>t :NERDTreeToggle<CR>

nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>d :bd<CR>

nnoremap <leader>s :w<CR>
nnoremap <leader>l :nohlsearch<CR>
nnoremap <C-C> <C-A>

xmap ga <Plug>(EasyAlign)
