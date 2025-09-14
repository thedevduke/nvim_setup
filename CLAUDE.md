# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration repository using Lua-based configuration with the lazy.nvim plugin manager. The configuration emphasizes a modern development environment with LSP support, formatting, and AI-powered code completion.

## Architecture

### Plugin Management System
- **lazy.nvim** is the plugin manager, bootstrapped in `lua/config/lazy.lua`
- Plugins are modularly organized in `lua/plugins/` with each file returning a table of plugin specifications
- Plugin lock file (`lazy-lock.json`) tracks exact versions for reproducibility

### Core Configuration Structure
```
init.lua                    # Entry point - loads lazy.nvim
lua/config/
  ├── lazy.lua             # Bootstrap and configure lazy.nvim
  ├── autocommands.lua     # LSP-specific autocommands for formatting/imports
  └── diagnostics.lua      # Diagnostic display configuration
lua/plugins/
  ├── init.lua             # Base LazyVim configuration and keymaps
  ├── lsp.lua              # LSP servers configuration with Mason
  ├── formatting.lua       # conform.nvim formatting setup
  ├── telescope.lua        # Fuzzy finder configuration
  ├── colorscheme.lua      # Rose Pine theme configuration
  └── supermaven.lua       # AI code completion
```

### LSP and Formatting Architecture
1. **Mason** manages LSP server installations automatically
2. **nvim-lspconfig** configures language servers with per-language settings
3. **conform.nvim** handles formatting with Prettier as primary formatter
4. ESLint runs fix-all on save for JS/TS files
5. Format-on-save is enabled globally with language-specific formatters

## Common Commands

### Plugin Management
```bash
# Open Neovim and plugins will auto-install on first launch
nvim

# Update plugins (within Neovim)
:Lazy update

# Clean unused plugins
:Lazy clean

# View plugin status
:Lazy
```

### LSP Commands (within Neovim)
```vim
:Mason                    # Open Mason UI to manage LSP servers
:LspInfo                 # Show attached LSP clients
:LspRestart             # Restart LSP servers
```

### Key Mappings
- `<leader>` is set to space
- `<leader>pf` - Find files with Telescope
- `<leader>ps` - Live grep with Telescope
- `<leader>f` - Format current buffer
- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

## Development Workflow

### Adding New Plugins
1. Create a new file in `lua/plugins/` or modify existing ones
2. Return a table with plugin specifications following lazy.nvim format
3. Restart Neovim or run `:Lazy reload` to load changes

### Configuring Language Servers
1. Add server name to `ensure_installed` in `lua/plugins/lsp.lua`
2. Add server-specific configuration in the same file
3. Mason will auto-install on next launch

### Customizing Formatters
1. Modify `lua/plugins/formatting.lua`
2. Add file type mappings in `formatters_by_ft` table
3. Configure formatter-specific options in the `formatters` table

## Important Implementation Details

### Plugin Loading Strategy
- Plugins use lazy loading with events like `BufReadPre`, `InsertEnter`
- Priority plugins (colorscheme) load immediately with `lazy = false`
- Keymaps can trigger plugin loading on-demand

### LSP Attachment Pattern
- Each LSP server gets configured with `on_attach` callback for buffer-local keymaps
- Capabilities are enhanced for nvim-cmp integration when available
- Server-specific settings are passed in the setup function

### Format on Save Implementation
- conform.nvim handles format-on-save with LSP fallback
- ESLint fix-all runs via autocommand for JS/TS files
- TypeScript organize imports runs automatically on save