-- ~/.config/nvim/lua/config/diagnostics.lua
-- This configures how errors and warnings are displayed across all languages

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = {
    -- This prefix appears before diagnostic messages
    prefix = '●',
    -- Only show the source if there are multiple sources (like ESLint + TypeScript)
    source = "if_many",
    -- Add some spacing between code and diagnostic text
    spacing = 4,
  },
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = false,  -- Don't update diagnostics while typing
  severity_sort = true,  -- Show errors before warnings
})

-- Define diagnostic signs for the gutter
-- These icons will appear next to line numbers
local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " "
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Customize diagnostic colors if you want them to stand out more
vim.cmd([[
  highlight DiagnosticVirtualTextError guifg=#db4b4b
  highlight DiagnosticVirtualTextWarn guifg=#e0af68
  highlight DiagnosticVirtualTextInfo guifg=#0db9d7
  highlight DiagnosticVirtualTextHint guifg=#10B981
]])

-- Auto-show diagnostics in hover window when cursor holds on an error
-- This will show the error message automatically after a short delay
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",  -- Shows which LSP/linter reported the error
      prefix = " ",
      scope = "cursor",   -- Only show diagnostics for current cursor position
    }
    vim.diagnostic.open_float(nil, opts)
  end,
  desc = "Show diagnostics in floating window when cursor holds"
})
