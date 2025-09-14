-- ~/.config/nvim/lua/plugins/telescope.lua

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>pv", vim.cmd.Ex, desc = "Open Explorer" },
        
        -- Using builtin functions directly
        { "<leader>pf", builtin.find_files, desc = "Find Files" },
        { "<leader>ps", builtin.live_grep, desc = "Grep Search" },
        { "<leader>pg", builtin.git_files, desc = "Git Files" },
        { "<leader>pb", builtin.buffers, desc = "Buffers" },
        { "<leader>ph", builtin.help_tags, desc = "Help Tags" },
        { "<leader>po", builtin.oldfiles, desc = "Recent Files" },
        
        -- With custom options
        {
          "<leader>pf",
          function()
            builtin.find_files({ hidden = true, no_ignore = false })
          end,
          desc = "Find Files (including hidden)",
        },
        {
          "<leader>pA",
          function()
            builtin.find_files({ hidden = true, no_ignore = true })
          end,
          desc = "Find All Files",
        },
      }
    end,
  },
}
