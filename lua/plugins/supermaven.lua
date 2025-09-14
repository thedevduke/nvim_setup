-- ~/.config/nvim/lua/plugins/supermaven.lua

return {
  {
    "supermaven-inc/supermaven-nvim",
    event = { "InsertEnter", "BufReadPost" }, -- Load on InsertEnter or when reading a buffer
    cmd = { "SupermavenStart", "SupermavenStop", "SupermavenStatus", "SupermavenRestart" }, -- Also load when these commands are used
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { 
          -- Add any filetypes where you don't want AI suggestions
          -- For example: cpp = true, 
        },
        color = {
          suggestion_color = "#ffffff",
          cterm = 244,
        },
        log_level = "info", -- You can set to "off" to disable logging
        disable_inline_completion = false, -- Set to true if you want to disable inline suggestions
        disable_keymaps = false, -- Set to true if you want to define your own keymaps
      })
      
      -- Auto-start Supermaven when the plugin loads
      vim.defer_fn(function()
        vim.cmd("SupermavenStart")
        vim.notify("Supermaven started", vim.log.levels.INFO)
      end, 100)
    end,
  },
}
