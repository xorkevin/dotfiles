-- leader
vim.g.mapleader = ';'

-- packer
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- theme
  use {
    'RRethy/nvim-base16',
    config = function()
      vim.cmd('colorscheme base16-tomorrow-night')
    end,
  }

  use 'nvim-tree/nvim-web-devicons'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', 'RRethy/nvim-base16' },
    config = function()
      require('lualine').setup({
        options = { theme = 'base16' },
      })
    end,
  }

  -- text editing
  use {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.align').setup()
      require('mini.surround').setup()
    end,
  }

  use 'bronson/vim-visual-star-search'

  -- file management
  use {
    'ibhagwan/fzf-lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local fzf = require('fzf-lua')
      local fzf_opts = { fzf_opts = { ['--layout'] = 'default' } }
      vim.keymap.set('n', '<leader>f', function()
        fzf.files(fzf_opts)
      end)
      vim.keymap.set('n', '<leader>b', function()
        fzf.buffers(fzf_opts)
      end)
    end,
  }

  use 'tpope/vim-vinegar'

  -- git
  use 'tpope/vim-fugitive'

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '|' },
          change       = { text = '|' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
      })
    end,
  }

  -- autocomplete
  use 'neovim/nvim-lspconfig'
  use 'L3MON4D3/LuaSnip'
  use {
    'saadparwaiz1/cmp_luasnip',
    requires = { 'L3MON4D3/LuaSnip' },
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use {
    'hrsh7th/nvim-cmp',
    requires = {
     'neovim/nvim-lspconfig',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require('lspconfig')

      local servers = { 'gopls', 'rust_analyzer' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      local luasnip = require('luasnip')

      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
      })
    end,
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
vim.keymap.set('n', '<leader>e', '<cmd>edit .<CR>')
vim.keymap.set('n', '<leader>d', '<cmd>bd<CR>')
vim.keymap.set('n', '<leader>s', '<cmd>w<CR>')
vim.keymap.set('n', '<leader>l', '<cmd>nohlsearch<CR>')

-- base autocmds
local resize_window_equal_group = vim.api.nvim_create_augroup('resize_window_equal', { clear = true })
vim.api.nvim_create_autocmd('VimResized', {
  group = resize_window_equal_group,
  pattern = '*',
  command = 'wincmd =',
})
