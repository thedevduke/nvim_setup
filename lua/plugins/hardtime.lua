-- ~/.config/nvim/lua/plugins/hardtime.lua

return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
      max_time = 1000,
      max_count = 100,  -- Increased to allow many repeated presses
      disable_mouse = true,
      hint = true,
      notification = true,
      allow_different_key = false,
      enabled = true,
      resetting_keys = {
        ["1"] = { "n", "x" },
        ["2"] = { "n", "x" },
        ["3"] = { "n", "x" },
        ["4"] = { "n", "x" },
        ["5"] = { "n", "x" },
        ["6"] = { "n", "x" },
        ["7"] = { "n", "x" },
        ["8"] = { "n", "x" },
        ["9"] = { "n", "x" },
        ["c"] = { "n" },
        ["C"] = { "n" },
        ["d"] = { "n" },
        ["x"] = { "n" },
        ["X"] = { "n" },
        ["y"] = { "n" },
        ["Y"] = { "n" },
        ["p"] = { "n" },
        ["P"] = { "n" },
      },
      restricted_keys = {
        ["h"] = { "n", "x" },
        ["j"] = { "n", "x" },
        ["k"] = { "n", "x" },
        ["l"] = { "n", "x" },
        ["-"] = { "n", "x" },
        ["+"] = { "n", "x" },
        ["gj"] = { "n", "x" },
        ["gk"] = { "n", "x" },
        ["<CR>"] = { "n", "x" },
        ["<C-M>"] = { "n", "x" },
        ["<C-N>"] = { "n", "x" },
        ["<C-P>"] = { "n", "x" },
      },
      restriction_mode = "hint",  -- Changed from "block" to only show hints without blocking
      disabled_keys = {
        ["<Up>"] = { "" },     -- Only disabled in normal mode
        ["<Down>"] = { "" },   -- Only disabled in normal mode
        ["<Left>"] = { "" },   -- Only disabled in normal mode
        ["<Right>"] = { "" },  -- Only disabled in normal mode
      },
      disabled_filetypes = { 
        "qf", 
        "netrw", 
        "NvimTree", 
        "lazy", 
        "mason",
        "oil",
        "telescope",
        "harpoon",
        "toggleterm",
      },
      hints = {
        ["k^"] = {
          message = function() return "Use - instead of k^" end,
          length = 2,
        },
        ["j$"] = {
          message = function() return "Use + instead of j$" end,
          length = 2,
        },
      },
    },
    config = function(_, opts)
      require("hardtime").setup(opts)
      
      -- Keymaps to toggle hardtime
      vim.keymap.set("n", "<leader>ht", "<cmd>Hardtime toggle<cr>", { desc = "Toggle Hardtime" })
      vim.keymap.set("n", "<leader>hr", "<cmd>Hardtime report<cr>", { desc = "Hardtime Report" })
    end,
  },
}