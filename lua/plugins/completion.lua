-- Autocompletion and Intellisense Configuration
-- Provides intelligent code completion for TypeScript, JavaScript, Tailwind, and more

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet engine (required for nvim-cmp)
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      
      -- Completion sources
      "hrsh7th/cmp-nvim-lsp",     -- LSP completions
      "hrsh7th/cmp-buffer",        -- Buffer completions
      "hrsh7th/cmp-path",          -- Path completions
      "hrsh7th/cmp-cmdline",       -- Command line completions
      "hrsh7th/cmp-nvim-lua",      -- Neovim Lua API completions
      
      -- Snippets
      "rafamadriz/friendly-snippets", -- Snippet collection
      
      -- Icons for completion menu
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      
      -- Load friendly snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        
        mapping = cmp.mapping.preset.insert({
          -- Navigate completion menu
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.complete(),  -- Changed from C-Space to C-y
          ["<C-e>"] = cmp.mapping.abort(),
          
          -- Accept completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          
          -- Navigate snippets
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },  -- LSP completions (highest priority)
          { name = "luasnip", priority = 750 },    -- Snippets
          { name = "nvim_lua", priority = 500 },   -- Neovim Lua API
          { name = "buffer", priority = 250 },     -- Buffer words
          { name = "path", priority = 250 },       -- File paths
        }),
        
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              nvim_lua = "[Lua]",
            },
            -- Show icons for different item types
            before = function(entry, vim_item)
              -- Special handling for Tailwind CSS colorization
              if vim_item.kind == "Color" and entry.completion_item.documentation then
                local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
                if r then
                  local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
                  local group = "Tw_" .. color
                  if vim.fn.hlID(group) < 1 then
                    vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
                  end
                  vim_item.kind_hl_group = group
                end
              end
              return vim_item
            end,
          }),
        },
        
        -- Enable completion in specific contexts
        enabled = function()
          -- Disable completion in comments (except for Tailwind classes)
          local context = require("cmp.config.context")
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
              or vim.bo.filetype == "html"
              or vim.bo.filetype == "jsx"
              or vim.bo.filetype == "tsx"
          end
        end,
        
        experimental = {
          ghost_text = true, -- Show preview of completion
        },
      })
      
      -- Setup completion for search
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      
      -- Setup completion for command mode
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}