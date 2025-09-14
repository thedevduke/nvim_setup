-- ~/.config/nvim/lua/plugins/formatting.lua
-- This file handles all formatting and linting configuration to match your VSCode setup

return {
  -- First, we need conform.nvim for formatting with Prettier
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    config = function()
      local conform = require("conform")
      
      conform.setup({
        formatters_by_ft = {
          -- These match your VSCode settings where Prettier is the default formatter
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          markdown = { "prettier" },
          yaml = { "prettier" },
          
          -- For other languages, we'll use their respective formatters
          python = { "black", "isort" },
          go = { "gofmt", "goimports" },
          rust = { "rustfmt" },
          lua = { "stylua" },
        },
        
        -- This is crucial - it matches your VSCode "editor.formatOnSave": true
        format_on_save = function(bufnr)
          -- Disable format on save for files in node_modules
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if bufname:match("/node_modules/") then
            return
          end
          
          -- Check if we should use LSP formatting instead for this buffer
          local disable_filetypes = { c = true, cpp = true }
          return {
            timeout_ms = 500,
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          }
        end,
        
        -- Configure Prettier to match your VSCode settings exactly
        formatters = {
          prettier = {
            prepend_args = function()
              -- These args match your VSCode Prettier settings
              return {
                "--tab-width", "2",
                "--use-tabs", "false",
                "--semi", "true",
                "--single-quote", "false",
                "--jsx-single-quote", "false",
                "--trailing-comma", "es5",
                "--arrow-parens", "always",
                "--print-width", "80",
                "--prose-wrap", "preserve",
              }
            end,
          },
        },
      })
      
      -- Create a command to format manually
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        conform.format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
      
      -- Keymap for manual formatting
      vim.keymap.set({ "n", "v" }, "<leader>f", function()
        conform.format({
          async = false,
          timeout_ms = 500,
          lsp_fallback = true,
        })
      end, { desc = "Format buffer" })
    end,
  },
  
  -- Now let's enhance the LSP configuration to handle ESLint properly
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure the servers table exists
      opts.servers = opts.servers or {}
      
      -- Configure ESLint to match your VSCode setup
      opts.servers.eslint = {
        settings = {
          -- This enables the same behavior as your VSCode ESLint extension
          codeActionOnSave = {
            enable = true,
            mode = "all",
          },
          format = false, -- We use Prettier for formatting, not ESLint
          packageManager = "npm",
          useESLintClass = true,
          workingDirectory = {
            mode = "auto",
          },
        },
      }
      
      -- Configure TypeScript server to not format (Prettier handles this)
      opts.servers.tsserver = vim.tbl_deep_extend("force", opts.servers.tsserver or {}, {
        settings = {
          typescript = {
            format = {
              enable = false, -- Disable tsserver formatting
            },
          },
          javascript = {
            format = {
              enable = false, -- Disable tsserver formatting
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
        },
      })
      
      return opts
    end,
  },
  
  -- Install mason packages for formatting
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "prettier",
        "eslint-lsp",
        "black",
        "isort",
        "stylua",
        "gofmt",
        "goimports",
        "rustfmt",
      })
      return opts
    end,
  },
}
