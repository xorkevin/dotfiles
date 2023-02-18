-- leader
vim.g.mapleader = ';'

-- packer
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- file management
  use 'junegunn/fzf.vim'

  -- theme
  use 'chriskempson/base16-vim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end)

-- core options
vim.opt.lazyredraw = true
vim.opt.updatetime = 500

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = 'yes'

vim.opt.listchars = { tab = '| ', trail = '.', extends = '>', precedes = '<', nbsp = '␣' }
vim.opt.list = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.conceallevel = 2

vim.opt.showmode = false

vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
vim.opt.shortmess:append('c')

vim.opt.diffopt:append('algorithm:histogram')

-- base keybinds
vim.keymap.set('n', '<leader>e', ':edit .<CR>')
vim.keymap.set('n', '<leader>d', ':bd<CR>')
vim.keymap.set('n', '<leader>s', ':w<CR>')
vim.keymap.set('n', '<leader>l', ':nohlsearch<CR>')

-- base autocmds
local resize_window_equal_group = vim.api.nvim_create_augroup('resize_window_equal', { clear = true })
vim.api.nvim_create_autocmd('VimResized', {
  group = resize_window_equal_group,
  pattern = '*',
  command = 'wincmd =',
})

-- plugins

-- fzf
vim.g.fzf_files_options = "--layout default --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --color=always -r :$FZF_PREVIEW_LINES {} || head -$FZF_PREVIEW_LINES {}) 2> /dev/null'"
vim.keymap.set('n', '<leader>f', ':Files<CR>')
vim.keymap.set('n', '<leader>b', ':Buffers<CR>')

-- base16 theme
vim.g.base16colorspace = 256
vim.cmd('colorscheme base16-tomorrow-night')

-- lualine
require('lualine').setup({
  options = { theme = 'base16' }
})
