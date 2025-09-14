-- ~/.config/nvim/lua/plugins/toggleterm.lua

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        
        -- Open mapping - using <C-\> to toggle
        open_mapping = [[<c-\>]],
        
        -- Hide the number column in toggleterm buffers
        hide_numbers = true,
        
        -- Highlights
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        
        -- Start in insert mode
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        
        -- Persist size
        persist_size = true,
        persist_mode = true,
        
        -- Direction: 'vertical' | 'horizontal' | 'tab' | 'float'
        direction = "float",
        
        -- Close the terminal window when the process exits
        close_on_exit = true,
        
        -- Shell
        shell = vim.o.shell,
        
        -- Float opts
        float_opts = {
          border = "curved",
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.9)
          end,
          winblend = 3,
        },
        
        winbar = {
          enabled = false,
        },
      })
      
      -- Additional keymaps for different terminal types
      local Terminal = require('toggleterm.terminal').Terminal
      
      -- Lazygit terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })
      
      function _lazygit_toggle()
        lazygit:toggle()
      end
      
      -- Node terminal
      local node = Terminal:new({ cmd = "node", hidden = true })
      
      function _node_toggle()
        node:toggle()
      end
      
      -- Python terminal
      local python = Terminal:new({ cmd = "python3", hidden = true })
      
      function _python_toggle()
        python:toggle()
      end
      
      -- Keymaps
      vim.keymap.set("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Lazygit" })
      vim.keymap.set("n", "<leader>tn", "<cmd>lua _node_toggle()<CR>", { desc = "Node terminal" })
      vim.keymap.set("n", "<leader>tp", "<cmd>lua _python_toggle()<CR>", { desc = "Python terminal" })
      
      -- Quick terminal keymaps
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float terminal" })
      vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "Horizontal terminal" })
      vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "Vertical terminal" })
      
      -- Terminal mode mappings (to navigate out of terminal)
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end
      
      -- Set terminal keymaps on terminal open
      vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
    end,
    keys = {
      { "<c-\\>", desc = "Toggle terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float terminal" },
      { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "Horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "Vertical terminal" },
      { "<leader>gg", desc = "Lazygit" },
    },
  },
}