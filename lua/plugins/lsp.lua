-- ~/.config/nvim/lua/plugins/lsp.lua
-- This file MUST return a table, even if it's empty

-- Let's start fresh with a properly structured LSP configuration
return {
  -- This is the main LSP configuration plugin
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Mason manages LSP server installations
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      
      -- Show LSP progress
      { "j-hui/fidget.nvim", opts = {} },
      
      -- Additional Lua configuration for Neovim development
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- Import the plugin safely
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      
      -- Set up Mason first
      mason_lspconfig.setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "html",
          "cssls",
          "tailwindcss",
          "rust_analyzer",
          "gopls",
          "pyright",
          "lua_ls",
        },
      })
      
      -- Create capabilities for nvim-cmp integration
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- If you have nvim-cmp installed, enhance capabilities
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end
      
      -- Define what happens when an LSP attaches to a buffer
      local on_attach = function(client, bufnr)
        -- Create a function to simplify key mappings
        local function map(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        
        -- Navigation mappings
        map('gd', vim.lsp.buf.definition, "Go to Definition")
        map('gD', vim.lsp.buf.declaration, "Go to Declaration")
        map('gi', vim.lsp.buf.implementation, "Go to Implementation")
        map('gr', vim.lsp.buf.references, "Go to References")
        map('gt', vim.lsp.buf.type_definition, "Go to Type Definition")
        
        -- Documentation and help
        map('K', vim.lsp.buf.hover, "Hover Documentation")
        map('<C-k>', vim.lsp.buf.signature_help, "Signature Help")
        
        -- Actions
        map('<leader>rn', vim.lsp.buf.rename, "Rename")
        map('<leader>ca', vim.lsp.buf.code_action, "Code Action")
        map('<leader>f', function()
          vim.lsp.buf.format({ async = true })
        end, "Format")
        
        -- Diagnostics
        map('[d', vim.diagnostic.goto_prev, "Previous Diagnostic")
        map(']d', vim.diagnostic.goto_next, "Next Diagnostic")
        map('<leader>e', vim.diagnostic.open_float, "Show Diagnostic")
        map('<leader>q', vim.diagnostic.setloclist, "Diagnostic List")
      end
      
      -- Configure each language server
      -- TypeScript/JavaScript
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          typescript = {
            format = { enable = false }, -- Use Prettier instead
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          javascript = {
            format = { enable = false }, -- Use Prettier instead
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      })
      
      -- ESLint
      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- Auto-fix on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        capabilities = capabilities,
      })
      
      -- Python
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      })
      
      -- Rust
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            cargo = {
              allFeatures = true,
            },
          },
        },
      })
      
      -- Go
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
      
      -- HTML
      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- CSS
      lspconfig.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- Tailwind CSS
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                -- Support for clsx, cn, cva, etc.
                { "clsx\\(([^)]*)\\)", "\"([^\"]*)\"" },
                { "cn\\(([^)]*)\\)", "\"([^\"]*)\"" },
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "tw`([^`]*)" },
                { "tw=\"([^\"]*)" },
                { "tw={\"([^\"}]*)" },
                { "tw\\.\\w+`([^`]*)" },
                { "tw\\(.*?\\)`([^`]*)" },
              },
            },
            validate = true,
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidScreen = "error",
              invalidVariant = "error",
              invalidConfigPath = "error",
              invalidTailwindDirective = "error",
              recommendedVariantOrder = "warning",
            },
          },
        },
      })
      
      -- Lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },
  
  -- Add Mason plugin separately to ensure it's properly configured
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "prettier",
        "stylua",
        "black",
        "isort",
        "shfmt",
      },
    },
  },
}
