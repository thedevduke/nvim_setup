-- ~/.config/nvim/lua/plugins/harpoon.lua

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      
      -- REQUIRED
      harpoon:setup()
      
      -- Basic keymaps
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to Harpoon" })
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle Harpoon menu" })
      
      -- Quick navigation to files 1-4
      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
      
      -- Alternative number-based navigation
      for i = 1, 9 do
        vim.keymap.set("n", string.format("<leader>%d", i), function() harpoon:list():select(i) end, { desc = string.format("Harpoon file %d", i) })
      end
      
      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next" })
    end,
    keys = {
      { "<leader>a", desc = "Add file to Harpoon" },
      { "<leader>h", desc = "Toggle Harpoon menu" },
      { "<C-h>", desc = "Harpoon file 1" },
      { "<C-t>", desc = "Harpoon file 2" },
      { "<C-n>", desc = "Harpoon file 3" },
      { "<C-s>", desc = "Harpoon file 4" },
    },
  },
}