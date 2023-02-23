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
        options = {
          theme = 'base16',
        },
        sections = {
          lualine_c = {
            {
              'filename',
              path = 1,
            },
          }
        }
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

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'rounded',
      })
      vim.diagnostic.config({
        float = { border = 'rounded' },
      })

      local base_on_attach_overrides_defaults = {
        autoDocumentFormatDisable = nil
      }

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
        {
          name = 'tsserver',
          overrides = {
            autoDocumentFormatDisable = true,
          },
        },
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
      local server_overrides = {}
      for _, lsp in ipairs(servers) do
        server_overrides[lsp.name] = vim.tbl_deep_extend('force', base_on_attach_overrides_defaults,
          server_overrides[lsp.name] or {}, lsp.overrides or {})
        lspconfig[lsp.name].setup({
          capabilities = capabilities,
          settings = lsp.settings or {},
        })
      end

      local buf_has_lsp_capability = function(bufnr, capability, filter_fn)
        for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
          if client.server_capabilities[capability] and (not filter_fn or filter_fn(client)) then
            return true
          end
        end
        return false
      end

      local lsp_doc_hl_group = vim.api.nvim_create_augroup('k_lsp_document_highlight', { clear = true })
      vim.api.nvim_create_autocmd('CursorHold', {
        group = lsp_doc_hl_group,
        pattern = '*',
        callback = function()
          if buf_has_lsp_capability(0, 'documentHighlightProvider') then
            vim.lsp.buf.document_highlight()
          end
        end,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = lsp_doc_hl_group,
        pattern = '*',
        callback = function()
          if buf_has_lsp_capability(0, 'documentHighlightProvider') then
            vim.lsp.buf.clear_references()
          end
        end,
      })

      local lsp_codelens_group = vim.api.nvim_create_augroup('k_lsp_codelens', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        group = lsp_codelens_group,
        pattern = '*',
        callback = function()
          if buf_has_lsp_capability(0, 'codeLensProvider') then
            vim.lsp.codelens.refresh()
          end
        end,
      })

      local lsp_doc_format_group = vim.api.nvim_create_augroup('k_lsp_document_formatting', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = lsp_doc_format_group,
        pattern = '*',
        callback = function()
          if buf_has_lsp_capability(0, 'documentFormattingProvider', function(client)
                return not server_overrides[client.name].autoDocumentFormatDisable
              end) then
            vim.lsp.buf.format()
          end
        end,
      })

      vim.keymap.set('n', 'K', function()
        if buf_has_lsp_capability(0, 'hoverProvider') then
          vim.lsp.buf.hover()
        else
          vim.cmd('normal! K')
        end
      end)

      vim.keymap.set('n', '<leader>e', function()
        vim.diagnostic.open_float()
      end)

      local menu_winopts_fn = function()
        local winopts = {
          width = 0.5,
          height = 0.5,
        }
        if vim.o.columns > 120 then
          winopts.width = 0.25
        end
        return winopts
      end

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
            vim.notify(
              string.format('LSP workspaces: %s',
                vim.inspect({ workspace_folders = vim.lsp.buf.list_workspace_folders() })),
              vim.log.levels.INFO)
          end,
        },
        {
          label = 'Show server capabilities',
          action = function()
            local clients = {}
            fzf.fzf_exec(function(fzf_cb)
              for _, client in ipairs(vim.lsp.get_active_clients()) do
                local label = string.format('%s (id: %d)', client.name, client.id)
                clients[label] = client
                fzf_cb(label)
              end
              fzf_cb(nil)
            end, {
              prompt = 'Clients>',
              actions = {
                ['default'] = function(selected)
                  if not selected or #selected ~= 1 or not selected[1] then
                    return
                  end
                  local client = clients[selected[1]]
                  if client then
                    vim.notify(
                      string.format('Server %s (id: %d): %s', client.name, client.id,
                        vim.inspect({
                          capabilities = client.server_capabilities,
                          overrides = server_overrides[client.name]
                        })),
                      vim.log.levels.INFO)
                  else
                    vim.notify('No client ' .. selected[1], vim.log.levels.INFO)
                  end
                end,
              },
              fzf_opts = { ['--layout'] = 'reverse' },
              winopts_fn = menu_winopts_fn,
            })
          end,
        },
      }
      local lsp_menu_actions = {}
      for _, choice in ipairs(lsp_menu_options) do
        lsp_menu_actions[choice.label] = choice.action
      end

      vim.keymap.set('n', '<leader>r', function()
        local bufnr = vim.api.nvim_get_current_buf()
        fzf.fzf_exec(function(fzf_cb)
          for _, choice in ipairs(lsp_menu_options) do
            if choice.label and (not choice.capability or buf_has_lsp_capability(bufnr, choice.capability)) then
              fzf_cb(choice.label)
            end
          end
          fzf_cb(nil)
        end, {
          prompt = 'LSP> ',
          actions = {
            ['default'] = function(selected)
              if not selected or #selected ~= 1 or not selected[1] then
                return
              end
              local action = lsp_menu_actions[selected[1]]
              if action then
                action()
              end
            end,
            ['ctrl-y'] = function(selected)
              vim.notify('LSP menu: ' .. vim.inspect({ selected = selected }), vim.log.levels.INFO)
            end,
          },
          fzf_opts = { ['--layout'] = 'reverse' },
          winopts_fn = menu_winopts_fn,
        })
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
            i = cmp.mapping.complete({}),
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
