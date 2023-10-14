local deps = require('deps').singleton
deps:add_reqs({ 'fzf' })

local winfloat = require('winfloat')

-- utils
local function string_split(str, delimiter, fn)
  local from                 = 1
  local delim_from, delim_to = string.find(str, delimiter, from)
  while delim_from do
    fn(string.sub(str, from, delim_from - 1))
    from                 = delim_to + 1
    delim_from, delim_to = string.find(str, delimiter, from)
  end
  fn(string.sub(str, from))
end

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

vim.opt.termguicolors = true

vim.opt.mouse = ''

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

-- lsp
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})
vim.diagnostic.config({
  float = { border = 'rounded' },
})

local lsp_servers = require('lspservers').singleton
lsp_servers:add_servers({
  {
    name = 'null-ls',
    cfg_reader = 'null-ls',
  },
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
})

local function buf_has_lsp_capability(bufnr, capability, filter_fn)
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
    if client.server_capabilities[capability] and (not filter_fn or filter_fn(client)) then
      return true
    end
  end
  return false
end

local function buf_prio_client_lsp_capability(bufnr, capability, filter_fn)
  local name = nil
  local priority = lsp_servers.max_prio + 1
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
    if client.server_capabilities[capability] and (not filter_fn or filter_fn(client)) then
      local prio = lsp_servers.priority[client.name]
      if prio < priority then
        name = client.name
        priority = prio
      end
    end
  end
  return name
end

do
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
      local name = buf_prio_client_lsp_capability(0, 'documentFormattingProvider', function(client)
        return not lsp_servers.overrides[client.name].autoDocumentFormatDisable
      end)
      if not name then
        return
      end
      vim.lsp.buf.format({
        name = name,
      })
    end,
  })
end

vim.keymap.set('n', 'K', function()
  if buf_has_lsp_capability(0, 'hoverProvider') then
    vim.lsp.buf.hover()
  else
    vim.cmd('normal! K')
  end
end)

vim.keymap.set('n', '<leader>k', function()
  vim.diagnostic.open_float()
end)

vim.keymap.set('n', '<leader>j', function()
  vim.diagnostic.goto_next()
end)

vim.keymap.set('n', '<leader>a', function()
  vim.lsp.buf.code_action()
end)

local lsp_menu_options = {
  {
    label = 'Go to definition',
    capability = 'definitionProvider',
    action = function()
      vim.lsp.buf.definition()
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
    label = 'Go to declaration',
    capability = 'declarationProvider',
    action = function()
      vim.lsp.buf.declaration()
    end,
  },
  {
    label = 'List references',
    capability = 'referencesProvider',
    action = function()
      if deps.loaded then
        deps.m.fzf.lsp_references()
      else
        vim.lsp.buf.references({})
      end
    end,
  },
  {
    label = 'List implementations',
    capability = 'implementationProvider',
    action = function()
      if deps.loaded then
        deps.m.fzf.lsp_implementations()
      else
        vim.lsp.buf.implementation()
      end
    end,
  },
  {
    label = 'Incoming calls',
    capability = 'callHierarchyProvider',
    action = function()
      if deps.loaded then
        deps.m.fzf.lsp_incoming_calls()
      else
        vim.lsp.buf.incoming_calls()
      end
    end,
  },
  {
    label = 'Outgoing calls',
    capability = 'callHierarchyProvider',
    action = function()
      if deps.loaded then
        deps.m.fzf.lsp_outgoing_calls()
      else
        vim.lsp.buf.outgoing_calls()
      end
    end,
  },
  {
    label = 'List document symbols',
    capability = 'documentSymbolProvider',
    action = function()
      if deps.loaded then
        deps.m.fzf.lsp_document_symbols()
      else
        vim.lsp.buf.document_symbol()
      end
    end,
  },
  {
    label = 'List workspace symbols',
    capability = 'workspaceSymbolProvider',
    action = function()
      if deps.loaded then
        deps.m.fzf.lsp_workspace_symbols()
      else
        vim.lsp.buf.workspace_symbol('')
      end
    end,
  },
  {
    label = 'List document diagnostics',
    action = function()
      if deps.loaded then
        deps.m.fzf.diagnostics_document()
      end
    end,
  },
  {
    label = 'List workspace diagnostics',
    action = function()
      if deps.loaded then
        deps.m.fzf.diagnostics_workspace()
      end
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
    action = function(bufnr)
      vim.ui.select(vim.lsp.get_active_clients({ bufnr = bufnr }), {
        prompt = 'Clients:',
        format_item = function(item)
          return string.format('%s (id: %d)', item.name, item.id)
        end,
      }, function(choice)
        if not choice then
          return
        end
        vim.lsp.buf.format({ bufnr = bufnr, name = choice.name })
      end)
    end,
  },
  {
    label = 'List workspace folders',
    action = function()
      local text_lines = { 'LSP workspaces', '', 'workspace_folders:', '' }
      for _, v in ipairs(vim.lsp.buf.list_workspace_folders()) do
        table.insert(text_lines, v)
      end
      winfloat.text_window(text_lines)
    end,
  },
  {
    label = 'Show server capabilities',
    action = function()
      vim.ui.select(vim.lsp.get_active_clients(), {
        prompt = 'Clients:',
        format_item = function(item)
          return string.format('%s (id: %d)', item.name, item.id)
        end,
      }, function(choice)
        if not choice then
          return
        end

        local text_lines = { string.format('Server %s (id: %d)', choice.name, choice.id), '' }
        string_split(vim.inspect({
          capabilities = choice.server_capabilities,
          overrides = lsp_servers.overrides[choice.name],
          priority = lsp_servers.priority[choice.name],
        }), '\n', function(line)
          table.insert(text_lines, line)
        end)
        winfloat.text_window(text_lines)
      end)
    end,
  },
}

vim.keymap.set('n', '<leader>r', function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.ui.select(lsp_menu_options, {
    prompt = 'LSP:',
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if not choice then
      return
    end
    choice.action(bufnr)
  end)
end)

-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- syntax
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'awk',
          'bash',
          'bibtex',
          'c',
          'capnp',
          'comment',
          'commonlisp',
          'cpp',
          'css',
          'csv',
          'cuda',
          'cue',
          'd',
          'dart',
          'dhall',
          'diff',
          'dockerfile',
          'dot',
          'eex',
          'elixir',
          'embedded_template',
          'erlang',
          'forth',
          'fortran',
          'gdscript',
          'git_config',
          'git_rebase',
          'gitattributes',
          'gitcommit',
          'gitignore',
          'glsl',
          'go',
          'godot_resource',
          'gomod',
          'gosum',
          'gowork',
          'gpg',
          'graphql',
          'hack',
          'haskell',
          'haskell_persistent',
          'hcl',
          'heex',
          'hjson',
          'hlsl',
          'html',
          'http',
          'ini',
          'java',
          'javascript',
          'jq',
          'jsdoc',
          'json',
          'jsonnet',
          'kotlin',
          'latex',
          'ledger',
          'llvm',
          'lua',
          'luadoc',
          'luap',
          'make',
          'markdown',
          'markdown_inline',
          'mermaid',
          'ninja',
          'nix',
          'ocaml',
          'ocaml_interface',
          'ocamllex',
          'org',
          'passwd',
          'pem',
          'perl',
          'php',
          'phpdoc',
          'promql',
          'proto',
          'psv',
          'puppet',
          'pymanifest',
          'python',
          'r',
          'racket',
          'regex',
          'requirements',
          'ron',
          'rst',
          'ruby',
          'rust',
          'scala',
          'scheme',
          'scss',
          'sql',
          'ssh_config',
          'starlark',
          'strace',
          'svelte',
          'swift',
          'terraform',
          'textproto',
          'thrift',
          'tlaplus',
          'toml',
          'tsv',
          'tsx',
          'typescript',
          'verilog',
          'vhs',
          'vim',
          'vimdoc',
          'vue',
          'wgsl',
          'wgsl_bevy',
          'xml',
          'yaml',
          'zig',
        },
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
        },
      })
    end,
  },
  -- theme
  {
    'RRethy/nvim-base16',
    config = function()
      vim.cmd('colorscheme base16-tomorrow-night')
    end,
  },
  { 'nvim-tree/nvim-web-devicons' },
  {
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
  },
  -- ui
  {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup({
        input = { enabled = true },
        select = { enabled = false },
      })
    end,
  },
  {
    'ibhagwan/fzf-lua',
    config = function()
      local g_deps = require('deps').singleton
      local fzf = require('fzf-lua')
      g_deps:provide('fzf', fzf)

      fzf.register_ui_select({
        winopts_fn = function()
          local winopts = {
            width = 0.5,
            height = 0.5,
          }
          if vim.o.columns > 120 then
            winopts.width = 0.25
          end
          return winopts
        end
      }, true)

      local opts = { fzf_opts = { ['--layout'] = 'default' } }
      vim.keymap.set('n', '<leader>f', function()
        fzf.files(opts)
      end)
      vim.keymap.set('n', '<leader>b', function()
        fzf.buffers(opts)
      end)
    end,
  },
  { 'tpope/vim-vinegar' },
  -- text editing
  {
    'echasnovski/mini.align',
    config = function()
      require('mini.align').setup()
    end,
  },
  {
    'echasnovski/mini.surround',
    config = function()
      require('mini.surround').setup()
    end,
  },
  { 'bronson/vim-visual-star-search' },
  -- git
  { 'tpope/vim-fugitive' },
  {
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
  },
  -- lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local g_lsp_servers = require('lspservers').singleton
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      for _, lsp in ipairs(g_lsp_servers.servers) do
        if lsp.cfg_reader == 'nvim-lspconfig' then
          lspconfig[lsp.name].setup({
            capabilities = capabilities,
            settings = lsp.settings or {},
          })
        end
      end
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          -- by default both use
          -- dynamic_command = cmd_resolver.from_node_modules()
          null_ls.builtins.formatting.prettier.with({
            extra_args = {
              '--config-precedence=prefer-file',
              -- '--print-width=80',
              -- '--tab-width=2',
              -- no tabs
              -- '--semi=true',
              '--single-quote=true',
              -- '--quote-props=as-needed',
              -- '--jsx-single-quote=false',
              '--trailing-comma=all',
              '--bracket-spacing=false',
              -- '--jsx-bracket-same-line=false',
              -- '--arrow-parens=always',
              -- '--require-pragma=false',
              -- '--insert-pragma=false',
              -- '--prose-wrap=preserve',
              -- '--html-whitepsace-sensitivity=css',
              -- '--end-of-line=lf',
              -- '--embedded-language-formatting=auto',
              -- '--single-attribute-per-line=false',
            },
          }),
          -- null_ls.builtins.diagnostics.eslint,
        },
      })
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup()
    end,
  },
  -- autocomplete
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
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
  },
  -- jsonnet
  { 'google/vim-jsonnet' },
})

-- starlark autoformat
local starlark_format_group = vim.api.nvim_create_augroup('k_starlark_format', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = starlark_format_group,
  pattern = '*.star',
  command = 'Black',
})
