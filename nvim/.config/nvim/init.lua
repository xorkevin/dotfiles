-- leader
vim.g.mapleader = ';'

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
local resize_window_equal_group = vim.api.nvim_create_augroup('k_resize_window_equal', { clear = true })
vim.api.nvim_create_autocmd('VimResized', {
  group = resize_window_equal_group,
  pattern = '*',
  command = 'wincmd =',
})

-- filetype
vim.filetype.add({
  extension = {
    tmpl = 'gotmpl',
  },
})

-- packer
require('packer').startup(function(use)
  use {
    'wbthomason/packer.nvim',
    config = function()
      vim.keymap.set('n', '<leader>z', '<cmd>source $MYVIMRC<CR><cmd>PackerCompile<CR>')
    end,
  }

  -- syntax
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'c',
          'comment',
          'commonlisp',
          'cpp',
          'css',
          'diff',
          'dockerfile',
          'dot',
          'gitattributes',
          'gitcommit',
          'gitignore',
          'git_rebase',
          'go',
          'gomod',
          'gosum',
          'gowork',
          'hcl',
          'help',
          'html',
          'ini',
          'java',
          'javascript',
          'json',
          'jsonnet',
          'latex',
          'lua',
          'make',
          'markdown',
          'markdown_inline',
          'ocaml',
          'ocaml_interface',
          'ocamllex',
          'perl',
          'proto',
          'python',
          'regex',
          'rust',
          'scheme',
          'scss',
          'sql',
          'terraform',
          'tlaplus',
          'toml',
          'tsx',
          'typescript',
          'vhs',
          'vim',
          'yaml',
        },
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
        },
      })
    end,
  }

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
    config = function()
      require('lualine').setup({
        options = { theme = 'base16' },
      })
    end,
  }

  -- text editing
  use {
    'echasnovski/mini.align',
    config = function()
      require('mini.align').setup()
    end,
  }

  use {
    'echasnovski/mini.surround',
    config = function()
      require('mini.surround').setup()
    end,
  }

  use 'bronson/vim-visual-star-search'

  -- file management
  use {
    'ibhagwan/fzf-lua',
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
  use {
    'neovim/nvim-lspconfig',
    requires = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require('lspconfig')
      local fzf = require('fzf-lua')

      local lsp_menu_options = {
        {
          label = 'List references',
          capability = 'referencesProvider',
          action = function()
            fzf.lsp_references()
          end,
        },
        {
          label = 'Go to definition',
          capability = 'definitionProvider',
          action = function()
            vim.lsp.buf.definition()
          end,
        },
        {
          label = 'List definitions',
          capability = 'definitionProvider',
          action = function()
            fzf.lsp_definitions()
          end,
        },
        {
          label = 'Go to typedefinition',
          capability = 'typeDefinitionProvider',
          action = function()
            vim.lsp.buf.type_definition()
          end,
        },
        {
          label = 'List typedefinitions',
          capability = 'typeDefinitionProvider',
          action = function()
            fzf.lsp_typedefs()
          end,
        },
        {
          label = 'Go to declaration',
          capability = 'declarationProvider',
          action = function()
            vim.lsp.buf.declaration()
          end,
        },
        {
          label = 'List implementations',
          capability = 'implementationProvider',
          action = function()
            fzf.lsp_implementations()
          end,
        },
        {
          label = 'Incoming calls',
          capability = 'callHierarchyProvider',
          action = function()
            fzf.lsp_incoming_calls()
          end,
        },
        {
          label = 'Outgoing calls',
          capability = 'callHierarchyProvider',
          action = function()
            fzf.lsp_outgoing_calls()
          end,
        },
        {
          label = 'List document symbols',
          capability = 'documentSymbolProvider',
          action = function()
            fzf.lsp_document_symbols()
          end,
        },
        {
          label = 'List workspace symbols',
          capability = 'workspaceSymbolProvider',
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
          capability = 'codeActionProvider',
          action = function()
            fzf.lsp_code_actions()
          end,
        },
        {
          label = 'Rename',
          capability = 'renameProvider',
          action = function()
            vim.lsp.buf.rename()
          end,
        },
        {
          label = 'Run codelens',
          capability = 'codeLensProvider',
          action = function()
            vim.lsp.codelens.run()
          end,
        },
        {
          label = 'Format document',
          capability = 'documentFormattingProvider',
          action = function()
            vim.lsp.buf.format()
          end,
        },
        {
          label = 'List workspace folders',
          action = function()
            vim.notify('LSP workspaces: ' .. vim.inspect({ workspace_folders = vim.lsp.buf.list_workspace_folders() }),
              vim.log.levels.INFO)
          end,
        },
        {
          label = 'Show server capabilities',
          action = function(client)
            vim.notify(
              'Server ' ..
              client.name ..
              ' capabilities (id ' .. client.id .. '): ' .. vim.inspect({ capabilities = client.server_capabilities }),
              vim.log.levels.INFO)
          end,
        },
      }

      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentHighlightProvider then
          local lsp_doc_hl_group = vim.api.nvim_create_augroup('k_lsp_document_highlight', { clear = false })
          vim.api.nvim_clear_autocmds({
            group = lsp_doc_hl_group,
            buffer = 0,
          })
          vim.api.nvim_create_autocmd('CursorHold', {
            group = lsp_doc_hl_group,
            buffer = 0,
            callback = function()
              vim.lsp.buf.document_highlight()
            end,
          })
          vim.api.nvim_create_autocmd('CursorMoved', {
            group = lsp_doc_hl_group,
            buffer = 0,
            callback = function()
              vim.lsp.buf.clear_references()
            end,
          })
        end

        if client.server_capabilities.codeLensProvider then
          local lsp_codelens = vim.api.nvim_create_augroup('k_lsp_codelens', { clear = false })
          vim.api.nvim_clear_autocmds({
            group = lsp_codelens,
            buffer = 0,
          })
          vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            group = lsp_codelens,
            buffer = 0,
            callback = function()
              vim.lsp.codelens.refresh()
            end,
          })
        end

        if client.server_capabilities.documentFormattingProvider then
          local lsp_doc_format = vim.api.nvim_create_augroup('k_lsp_document_formatting', { clear = false })
          vim.api.nvim_clear_autocmds({
            group = lsp_doc_format,
            buffer = 0,
          })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = lsp_doc_format,
            buffer = 0,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end

        if client.server_capabilities.hoverProvider then
          vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover()
          end, { buffer = true })
        end

        local lsp_menu_choices = {}
        local lsp_menu_actions = {}
        for _, choice in ipairs(lsp_menu_options) do
          if not choice.capability or client.server_capabilities[choice.capability] then
            table.insert(lsp_menu_choices, choice.label)
            lsp_menu_actions[choice.label] = choice.action
          end
        end

        vim.keymap.set('n', '<leader>r', function()
          fzf.fzf_exec(lsp_menu_choices, {
            prompt = 'LSP> ',
            actions = {
              ['default'] = function(selected)
                if not selected or #selected ~= 1 or not selected[1] then
                  return
                end
                local action = lsp_menu_actions[selected[1]]
                if action then
                  action(client, bufnr)
                end
              end,
              ['ctrl-y'] = function(selected)
                vim.notify('LSP menu: ' .. vim.inspect({ selected = selected }), vim.log.levels.INFO)
              end,
            },
            fzf_opts = { ['--layout'] = 'reverse' },
            winopts_fn = function()
              local winopts = {
                width = 0.5,
                height = 0.5,
              }
              if vim.o.columns > 120 then
                winopts.width = 0.25
              end
              return winopts
            end,
          })
        end, { buffer = true })
      end

      local servers = {
        {
          name = 'gopls',
          settings = {
            gopls = {
              gofumpt = true,
              templateExtensions = { 'tmpl' },
            },
          },
        },
        { name = 'rust_analyzer' },
        { name = 'tsserver' },
        {
          name = 'pylsp',
          settings = {
            pylsp = {
              plugins = {
                black = {
                  enabled = true,
                },
              },
            },
          },
        },
        {
          name = 'lua_ls',
          -- settings = {
          --   Lua = {
          --     workspace = {
          --       library = vim.api.nvim_list_runtime_paths(),
          --     },
          --   },
          -- },
          --
          -- :put = execute('lua =vim.api.nvim_list_runtime_paths()')
        },
        { name = 'clangd' },
        { name = 'bashls' },
        { name = 'html' },
        { name = 'cssls' },
        { name = 'jsonls' },
        { name = 'yamlls' },
        { name = 'texlab' },
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp.name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = lsp.settings or {},
        })
      end

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'rounded',
      })
      vim.diagnostic.config({
        float = { border = 'rounded' },
      })

      vim.keymap.set('n', '<leader>e', function()
        vim.diagnostic.open_float()
      end)
    end,
  }

  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup()
    end,
  }

  -- autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
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
            i = cmp.mapping.scroll_docs( -4),
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
            if luasnip.jumpable( -1) then
              luasnip.jump( -1)
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
