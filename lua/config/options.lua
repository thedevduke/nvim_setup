-- Neovim Options Configuration
-- This file sets up core Neovim behaviors and features

local opt = vim.opt

-- Clipboard Integration
-- This makes Neovim use the system clipboard for all yank/delete/paste operations
opt.clipboard = "unnamedplus" -- Use system clipboard as default register

-- Line Numbers
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers for easy jumping

-- Indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically

-- Search
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Don't ignore case if search contains capitals
opt.hlsearch = false -- Don't highlight search results
opt.incsearch = true -- Show search results as you type

-- UI
opt.termguicolors = true -- True color support
opt.signcolumn = "yes" -- Always show sign column (for git/diagnostics)
opt.wrap = false -- Don't wrap lines
opt.scrolloff = 8 -- Keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8 -- Keep 8 columns to the left/right of cursor

-- Behavior
opt.backup = false -- Don't create backup files
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Save undo history
opt.updatetime = 50 -- Faster completion (default is 4000ms)
opt.timeoutlen = 1000 -- Time to wait for a mapped sequence to complete (1 second)

-- Split Windows
opt.splitbelow = true -- New horizontal splits go below
opt.splitright = true -- New vertical splits go to the right

-- Cursor
opt.cursorline = true -- Highlight the current line

-- Mouse
opt.mouse = "a" -- Enable mouse support in all modes