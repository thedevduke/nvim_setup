-- ~/.config/nvim/lua/config/autocommands.lua
-- This sets up automatic actions that happen when you save, matching VSCode behavior

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    
    -- Set up format on save for specific file types
    if client.name == "eslint" then
      -- This matches your VSCode "source.fixAll.eslint": "explicit"
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("EslintFixAll", { clear = true }),
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json" },
        callback = function()
          -- Run ESLint fix-all command before saving
          vim.cmd("silent! EslintFixAll")
        end,
      })
    end
    
    -- Set up automatic import organization
    if client.name == "tsserver" then
      -- This matches your VSCode "source.addMissingImports": "explicit"
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("TsserverOrganizeImports", { clear = true }),
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
        callback = function()
          -- First, add missing imports
          local params = vim.lsp.util.make_range_params()
          params.context = {
            only = { "source.addMissingImports.ts" },
            diagnostics = {},
          }
          local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end
          
          -- Then organize imports (remove unused and sort)
          params.context = {
            only = { "source.organizeImports.ts" },
            diagnostics = {},
          }
          result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end
        end,
      })
    end
  end,
})
