-- ~/.config/nvim/lua/plugins/precognition.lua

return {
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      startVisible = true,
      showBlankVirtLine = true,
      highlightColor = { link = "Comment" },
      hints = {
        Caret = { text = "^", prio = 2 },
        Dollar = { text = "$", prio = 1 },
        MatchingPair = { text = "%", prio = 5 },
        Zero = { text = "0", prio = 1 },
        w = { text = "w", prio = 10 },
        b = { text = "b", prio = 9 },
        e = { text = "e", prio = 8 },
        W = { text = "W", prio = 7 },
        B = { text = "B", prio = 6 },
        E = { text = "E", prio = 5 },
      },
      gutterHints = {
        G = { text = "G", prio = 10 },
        gg = { text = "gg", prio = 9 },
        PrevParagraph = { text = "{", prio = 8 },
        NextParagraph = { text = "}", prio = 8 },
      },
      disabled_fts = {
        "startify",
        "dashboard",
        "lazy",
        "mason",
        "neo-tree",
        "NvimTree",
        "oil",
        "telescope",
        "toggleterm",
        "harpoon",
      },
    },
    config = function(_, opts)
      require("precognition").setup(opts)
      
      -- Keymaps to toggle precognition
      vim.keymap.set("n", "<leader>pc", function()
        require("precognition").toggle()
      end, { desc = "Toggle Precognition hints" })
      
      -- Optional: Create a command for easier access
      vim.api.nvim_create_user_command("PrecognitionToggle", function()
        require("precognition").toggle()
      end, { desc = "Toggle Precognition hints" })
    end,
  },
}