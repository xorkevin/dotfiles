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
      local opts = { fzf_opts = { ['--layout'] = 'default' } }
      vim.keymap.set('n', '<leader>f', function()
        fzf.files(opts)
      end)
      vim.keymap.set('n', '<leader>b', function()
        fzf.buffers(opts)
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

  -- lsp
  use 'hrsh7th/cmp-nvim-lsp'
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup()
    end
  }
  use {
    'neovim/nvim-lspconfig',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'ray-x/lsp_signature.nvim', 'ibhagwan/fzf-lua' },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require('lspconfig')

      local on_attach = function(client, bufnr)
        -- :lua =vim.lsp.get_active_clients()[1].server_capabilities

        if client.server_capabilities.documentHighlightProvider then
          vim.cmd([[
            augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
          ]])
        end

        if client.server_capabilities.hoverProvider then
          vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover()
          end, { buffer = true })
        end
      end

      local servers = { 'gopls', 'rust_analyzer' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
      })
      vim.diagnostic.config({
        float = { border = 'rounded' },
      })

      vim.keymap.set('n', '<leader>e', function()
        vim.diagnostic.open_float()
      end)

      local fzf = require('fzf-lua')

      local refactor_options = {
        {
          label = 'List references',
          action = function()
            fzf.lsp_references()
          end,
        },
        {
          label = 'Go to definition',
          action = function()
            vim.lsp.buf.definition()
          end,
        },
        {
          label = 'List definitions',
          action = function()
            fzf.lsp_definitions()
          end,
        },
        {
          label = 'Go to typedefinition',
          action = function()
            vim.lsp.buf.type_definition()
          end,
        },
        {
          label = 'List typedefinitions',
          action = function()
            fzf.lsp_typedefs()
          end,
        },
        {
          label = 'Go to declaration',
          action = function()
            vim.lsp.buf.declaration()
          end,
        },
        {
          label = 'List implementations',
          action = function()
            fzf.lsp_implementations()
          end,
        },
        {
          label = 'Incoming calls',
          action = function()
            fzf.lsp_incoming_calls()
          end,
        },
        {
          label = 'Outgoing calls',
          action = function()
            fzf.lsp_outgoing_calls()
          end,
        },
        {
          label = 'List document symbols',
          action = function()
            fzf.lsp_document_symbols()
          end,
        },
        {
          label = 'List workspace symbols',
          action = function()
            fzf.lsp_workspace_symbols()
          end,
        },
        {
          label = 'List document diagnostics',
          action = function()
            fzf.diagnostics_document()
          end,
        },
        {
          label = 'List workspace diagnostics',
          action = function()
            fzf.diagnostics_workspace()
          end,
        },
        {
          label = 'Code actions',
          action = function()
            fzf.lsp_code_actions()
          end,
        },
        {
          label = 'Rename',
          action = function()
            vim.lsp.buf.rename()
          end,
        },
        {
          label = 'List workspace folders',
          action = function()
            vim.notify('LSP workspaces: ' .. vim.inspect({ workspace_folders = vim.lsp.buf.list_workspace_folders() }),  vim.log.levels.INFO)
          end,
        },
        -- TODO format
      }
      local refactor_choices = {}
      local refactor_actions = {}
      for _, choice in ipairs(refactor_options) do
        table.insert(refactor_choices, choice.label)
        refactor_actions[choice.label] = choice.action
      end

      vim.keymap.set('n', '<leader>r', function()
        fzf.fzf_exec(refactor_choices, {
          prompt = 'LSP> ',
          actions = {
            ['default'] = function(selected)
              if not selected or not selected[1] then
                return
              end
              local action = refactor_actions[selected[1]]
              if action then
                action()
              end
            end,
            ['ctrl-y'] = function(selected, opts)
              vim.notify('LSP menu: ' .. vim.inspect({ selected = selected }), vim.log.levels.INFO)
            end,
          },
          fzf_opts = { ['--layout'] = 'reverse' },
        })
      end)
    end
  }

  -- autocomplete
  use 'L3MON4D3/LuaSnip'
  use {
    'saadparwaiz1/cmp_luasnip',
    requires = { 'L3MON4D3/LuaSnip' },
  }
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
      local luasnip = require('luasnip')

      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
        mapping = {
          ['<C-n>'] = {
            i = cmp.mapping.select_next_item({
              behavior = cmp.SelectBehavior.Insert,
            }),
          },
          ['<C-p>'] = {
            i = cmp.mapping.select_prev_item({
              behavior = cmp.SelectBehavior.Insert,
            }),
          },
          ['<C-f>'] = {
            i = cmp.mapping.scroll_docs(4),
          },
          ['<C-b>'] = {
            i = cmp.mapping.scroll_docs(-4),
          },
          ['<C-Space>'] = {
            i = cmp.mapping.complete(),
          },
          ['<CR>'] = {
            i = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            }),
          },
          ['<C-y>'] = {
            i = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = false,
            }),
          },
          ['<C-e>'] = {
            i = cmp.mapping.abort(),
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
        window = {
          documentation = cmp.config.window.bordered(),
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
vim.keymap.set('n', '<leader>z', '<cmd>source $MYVIMRC<CR><cmd>PackerCompile<CR>')

-- base autocmds
local resize_window_equal_group = vim.api.nvim_create_augroup('resize_window_equal', { clear = true })
vim.api.nvim_create_autocmd('VimResized', {
  group = resize_window_equal_group,
  pattern = '*',
  command = 'wincmd =',
})
