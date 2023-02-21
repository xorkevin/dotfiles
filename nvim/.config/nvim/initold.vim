" "Autoformat
" "JS
" Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'yaml'] }
" "Python
" Plug 'psf/black', { 'for': ['python'] }

" "Language client
" let g:LanguageClient_serverCommands = {
"   \ 'cpp': ['clangd'],
"   \ 'c': ['clangd'],
"   \ 'python': ['pylsp'],
"   \ 'elixir': ['elixir-ls'],
"   \ 'tex': ['texlab'],
"   \ }
"
" let g:prettier#autoformat = 0
" let g:prettier#config#config_precedence = 'prefer-file'
" let g:prettier#config#arrow_parens = 'always'
" let g:prettier#config#bracket_spacing = 'false'
" let g:prettier#config#end_of_line = 'lf'
" let g:prettier#config#html_whitespace_sensitivity = 'css'
" let g:prettier#config#jsx_bracket_same_line = 'false'
" let g:prettier#config#print_width = 80
" let g:prettier#config#prose_wrap = 'preserve'
" let g:prettier#config#require_pragma = 'false'
" let g:prettier#config#semi = 'true'
" let g:prettier#config#single_quote = 'true'
" let g:prettier#config#tab_width = 2
" let g:prettier#config#trailing_comma = 'all'
" let g:prettier#config#use_tabs = 'false'
" augroup filetype_js
"   autocmd!
"   "Prettier
"   autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.gql,*.vue,*.yml,*.yaml,*.html noautocmd call prettier#Autoformat()
" augroup END
"
" "Python
" augroup filetype_python
"   autocmd!
"   "Black
"   autocmd BufWritePre *.py Black
" augroup END
