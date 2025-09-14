# 📚 Neovim Configuration Cheat Sheet

## 🎯 Leader Key
Your leader key is set to **SPACE** (`<leader>` = space bar)

### ⏱️ Key Sequence Timeout
- **Timeout**: 1000ms (1 second) - Time you have to complete multi-key commands
- **Why it matters**: After pressing `<leader>` (Space), you have 1 second to press the next key
- **Example**: `<leader>pf` = Press Space, then within 1 second press `p`, then `f`
- **Tip**: This prevents accidental pastes when you have text yanked and use Telescope commands

---

## 🧭 Navigation Philosophy
Your Neovim setup uses a **three-tier navigation strategy** for maximum efficiency:

1. **🔭 Telescope** - For finding files you know exist somewhere in your project
2. **🎯 Harpoon** - For instantly switching between your actively-edited files ✅
3. **📂 File Explorer** - For browsing directory structure when you need to explore

Think of it like this:
- Use **Telescope** when you think "I need to find that config file..."
- Use **Harpoon** when you're bouncing between the same 4-5 files repeatedly
- Use **File Explorer** when you need to see what's in a folder

---

## 🔭 What is Telescope?

**Telescope** is a highly extendable fuzzy finder that revolutionizes how you navigate files and content in Neovim. Unlike traditional file explorers, Telescope lets you find anything by typing partial matches.

### Why Telescope is Powerful:
- **Fuzzy Matching**: Type "useff" to find "useEffect.js" - no need for exact names!
- **Live Preview**: See file contents as you navigate through results
- **Multiple Pickers**: Search files, text content, Git files, buffers, and more
- **Smart Sorting**: Most relevant results appear first
- **Extensible**: Supports many sources beyond just files

### Fuzzy Matching Examples:
- `init` → finds `init.lua`, `initialize.js`, `AdminInit.tsx`
- `compo` → finds `components/`, `Composer.vue`, `compose.yaml`
- `ueff` → finds `useEffect.js`, `userEffects.ts`
- `confts` → finds `config.ts`, `tsconfig.json`

---

## 📁 File Navigation with Telescope

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `<leader>pf` | **Find Files** | Opens a fuzzy finder to search for files in your project by name. Just start typing! |
| `<leader>ps` | **Live Grep Search** | Search for text content across all files in your project. Great for finding where something is used. |
| `<leader>pg` | **Git Files** | Search only through files tracked by Git (ignores untracked files). |
| `<leader>pb` | **Browse Buffers** | See and switch between all open files (buffers). |
| `<leader>ph` | **Help Tags** | Search through Neovim's help documentation. |
| `<leader>po` | **Recent Files** | Shows your recently opened files for quick access. |
| `<leader>pA` | **Find All Files** | Find files including hidden and ignored ones (like node_modules). |
| `<leader>pv` | **File Explorer** | Opens Neovim's built-in file explorer (netrw) to browse directories. |

### 💡 Telescope Tips & Tricks

**Navigation in Telescope:**
- `Ctrl+j/k` or `Ctrl+n/p` - Move up/down through results
- `Enter` - Open the selected file
- `Ctrl+x` - Open file in horizontal split
- `Ctrl+v` - Open file in vertical split
- `Ctrl+t` - Open file in new tab
- `Esc` or `Ctrl+c` - Close Telescope
- `Ctrl+u` - Clear the search prompt
- `Tab` - Toggle selection and move down
- `Shift+Tab` - Toggle selection and move up

**Search Patterns:**
- Start with `^` to match beginning: `^init` finds files starting with "init"
- End with `$` to match ending: `.lua$` finds all Lua files
- Use spaces as wildcards: `user controller` finds "userController.js"
- Case matters only if you use capitals: `User` is case-sensitive, `user` is not

**Pro Tips:**
- In `<leader>ps` (live grep), use regex patterns for complex searches
- Use `<leader>po` (recent files) to quickly return to previous work
- `<leader>pg` (git files) is faster than `<leader>pf` in Git repos
- Combine with Harpoon: Use Telescope to find files, then mark them with Harpoon

---

## 🎯 Harpoon - Quick File Switching

> **Status**: ✅ INSTALLED - Ready to use!

### What is Harpoon?

**Harpoon** is like having speed-dial for your files. Created by ThePrimeagen, it solves the problem of constantly switching between the same 3-5 files during development. Instead of fuzzy finding the same files repeatedly, you "mark" them once and jump between them instantly.

### Why Use Harpoon?

**The Problem It Solves:**
When working on a feature, you often edit the same files repeatedly:
- A component and its test file
- A frontend file and its API endpoint
- Multiple related modules
- Config files you keep checking

**Without Harpoon**: You either spam `<leader>pf` in Telescope, cycle through all buffers with `:bn`, or maintain complex split layouts.

**With Harpoon**: Mark your working files once, then switch between them with single keystrokes. It's muscle memory, not mental overhead.

### Harpoon Keymaps (When Installed)

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `<leader>a` | **Add to Harpoon** | Mark current file for quick access |
| `<leader>h` | **Harpoon Menu** | View/edit your marked files list |
| `<C-h>` | **Go to File 1** | Instantly jump to 1st marked file |
| `<C-t>` | **Go to File 2** | Instantly jump to 2nd marked file |
| `<C-n>` | **Go to File 3** | Instantly jump to 3rd marked file |
| `<C-s>` | **Go to File 4** | Instantly jump to 4th marked file |
| `<leader>1-9` | **Number Navigation** | Jump to marked file by number |

### Harpoon Workflow Example

```
1. Open your main component: components/Button.tsx
2. Mark it: <leader>a
3. Open the test file: Button.test.tsx
4. Mark it: <leader>a
5. Open the styles: Button.module.css
6. Mark it: <leader>a

Now you can instantly jump:
- <C-h> → Button.tsx
- <C-t> → Button.test.tsx
- <C-n> → Button.module.css

No thinking, just muscle memory!
```

### Harpoon vs Telescope vs Buffers

| Tool | Use When | Speed | Mental Load |
|------|----------|-------|-------------|
| **Telescope** | Finding files you haven't opened yet | Medium | High (need to remember names) |
| **Harpoon** | Switching between working set (3-5 files) | Instant | None (muscle memory) |
| **Buffers** (`:bn`) | Cycling through all open files | Slow | Medium (need to cycle) |
| **File Explorer** | Browsing directory structure | Slow | High (need to navigate) |

### Pro Tips for Harpoon
- Mark files at the start of your coding session
- Use consistent positions: File 1 = main code, File 2 = test, etc.
- Marks persist between sessions, so tomorrow you'll start where you left off
- Different projects have different marks - Harpoon is project-aware
- Don't mark more than 5-6 files - defeats the purpose of quick access

---

## 🔧 LSP Features (Language Server Protocol)

### Navigation
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `gd` | **Go to Definition** | Jump to where a function/variable is defined. |
| `gD` | **Go to Declaration** | Jump to where a function/variable is declared. |
| `gi` | **Go to Implementation** | Jump to the implementation of an interface/abstract method. |
| `gr` | **Go to References** | Find all places where this symbol is used. |
| `gt` | **Go to Type Definition** | Jump to the type definition of a symbol. |

### Documentation & Help
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `K` | **Hover Documentation** | Shows documentation/type info for symbol under cursor in a floating window. |
| `Ctrl+k` | **Signature Help** | Shows function signature and parameter hints while typing. |

### Code Actions
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `<leader>rn` | **Rename Symbol** | Rename a variable/function across the entire project. |
| `<leader>ca` | **Code Actions** | Shows available quick fixes and refactoring options. |
| `<leader>f` | **Format Code** | Formats the current file using Prettier or language-specific formatter. |

---

## 🐛 Diagnostics (Errors & Warnings)

### Viewing Error Details

**🆕 Auto-Show Feature**: Errors now appear automatically when you hold your cursor on a line with diagnostics for ~0.5 seconds!

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| **Just wait** | **Auto-Show Diagnostic** | Hold cursor on error line for 0.5s - popup appears automatically! |
| `[d` | **Previous Diagnostic** | Jump to the previous error or warning in the file. |
| `]d` | **Next Diagnostic** | Jump to the next error or warning in the file. |
| `<leader>e` | **Show Diagnostic** | Opens a floating window with details about the error under cursor. |
| `<leader>q` | **Diagnostic List** | Opens a list of all diagnostics in the current buffer. |

### Visual Indicators
- 🔴 **Red squiggly underline** = Error location in code
- **●** = Virtual text showing error message inline (after your code)
- **** = Error icon in the gutter (left of line numbers)
- **** = Warning icon
- **** = Hint icon
- **** = Info icon

### Diagnostic Tips
- Error popups show the source (e.g., `[TypeScript]` or `[ESLint]`)
- Multiple error sources are shown together
- Move your cursor to dismiss the auto-show popup
- Colors: Red = Error, Yellow = Warning, Blue = Info, Green = Hint

---

## 📋 Clipboard & System Integration

### Automatic System Clipboard (Now Configured!)
With `clipboard = "unnamedplus"` set in your config, all operations now use system clipboard automatically:

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `yy` | **Copy Line** | Copies line directly to system clipboard (can paste anywhere!) |
| `dd` | **Cut Line** | Cuts line to system clipboard |
| `p` | **Paste** | Pastes from system clipboard |
| `y` | **Copy (Visual)** | In visual mode, copies selection to system clipboard |
| `d` | **Cut (Visual)** | In visual mode, cuts selection to system clipboard |

### Manual Clipboard Control (If Needed)
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `"+y` | **Explicit System Copy** | Force copy to system clipboard register |
| `"+p` | **Explicit System Paste** | Force paste from system clipboard register |
| `"*y` | **Selection Clipboard** | Copy to X11 selection clipboard (Linux) |
| `:reg` | **View Registers** | See all registers including clipboard |

### Clipboard Tips
- **macOS Users**: Your clipboard now works seamlessly with Cmd+V in other apps!
- **Copy from Insert Mode**: Still use Cmd+C if text is already selected
- **Terminal Mode**: Cmd+C/V work normally in terminal mode
- **Verify Setup**: Type `:echo has('clipboard')` - should return 1

---

## 🤖 AI Code Completion (Supermaven)

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `Tab` | **Accept Suggestion** | Accepts the full AI code suggestion. |
| `Ctrl+j` | **Accept Word** | Accepts only the next word of the suggestion. |
| `Ctrl+]` | **Clear Suggestion** | Dismisses the current AI suggestion. |

### 💡 Supermaven Tips
- Suggestions appear automatically as you type in Insert mode
- The AI learns from your coding patterns
- Works best with common programming patterns

---

## 🧠 Intellisense & Autocompletion (nvim-cmp)

> **Status**: ✅ CONFIGURED - TypeScript, JavaScript, and Tailwind CSS intellisense ready!

### What is nvim-cmp?

**nvim-cmp** is a powerful completion engine that provides IDE-like intellisense for Neovim. It shows intelligent code suggestions, function signatures, and documentation as you type.

### Completion Keybindings

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `Ctrl+y` | **Force Trigger Completion** | Manually show completion menu (Mac-friendly, was Ctrl+Space) |
| `Ctrl+n` | **Next Item** | Navigate down in completion menu |
| `Ctrl+p` | **Previous Item** | Navigate up in completion menu |
| `Enter` or `Tab` | **Accept Completion** | Insert the selected suggestion |
| `Ctrl+e` | **Cancel Completion** | Close the completion menu |
| `Ctrl+f` | **Scroll Docs Down** | View more documentation |
| `Ctrl+b` | **Scroll Docs Up** | Scroll back in documentation |
| `Ctrl+l` | **Next Snippet Placeholder** | Jump to next placeholder in snippet |
| `Ctrl+h` | **Previous Snippet Placeholder** | Jump to previous placeholder in snippet |

### Features by Language

**TypeScript/JavaScript:**
- Complete type information
- Auto-imports for modules
- Method signatures and parameters
- Inlay hints showing inferred types

**Tailwind CSS:**
- Class name suggestions with color previews
- Works in `className`, `cn()`, `clsx()`, and template literals
- CSS conflict warnings
- Invalid class detection

### Completion Sources
The menu shows where suggestions come from:
- `[LSP]` - Language Server Protocol (most accurate)
- `[Snippet]` - Code snippets
- `[Buffer]` - Words from current file
- `[Path]` - File paths
- `[Lua]` - Neovim Lua API

### 💡 Intellisense Tips
- Completion appears automatically as you type - no need to trigger manually
- Icons show the type of completion (function, variable, class, etc.)
- The documentation window shows detailed information about the selected item
- Ghost text preview shows how the completion will look

---

## 🏋️ Hardtime - Break Bad Vim Habits

> **Status**: ✅ INSTALLED - Ready to use!

### What is Hardtime?

**Hardtime.nvim** helps you break inefficient Vim habits by temporarily disabling repetitive key presses. It's like a personal trainer for your Vim skills - it prevents you from using inefficient movements and encourages better alternatives.

### Why Use Hardtime?

**Bad Habits It Breaks:**
- Holding `j/k` to navigate (use `{count}j/k` or search instead)
- Repeatedly pressing `h/l` for horizontal movement (use `w/b/e` or `f/t`)
- Using arrow keys instead of `hjkl`
- Inefficient movement patterns

### Hardtime Keymaps

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `<leader>ht` | **Toggle Hardtime** | Enable/disable movement restrictions |
| `<leader>hr` | **Hardtime Report** | Show your usage statistics and bad habits |

### How Hardtime Works

- **Restriction Mode**: Set to "hint" - only shows suggestions without blocking keypresses
- **Hints**: Shows suggestions for better alternatives (e.g., "Use - instead of k^")
- **Smart Detection**: Automatically disabled in UI windows (Telescope, Mason, etc.)
- **Visual Feedback**: Notifications when you hit the restriction limit

### Hardtime Configuration Details

- **Max Count**: 100 repetitions allowed before showing hints (effectively disabled)
- **Max Time**: 1000ms window for counting repetitions
- **Disabled Keys**: Arrow keys are disabled only in normal mode (enabled in insert mode)
- **Restricted Keys**: `h`, `j`, `k`, `l`, and other basic movements
- **Mouse**: Disabled to encourage keyboard navigation

---

## 👁️ Precognition - Learn Available Motions

> **Status**: ✅ INSTALLED - Ready to use!

### What is Precognition?

**Precognition.nvim** shows inline virtual text hints for available motions at your cursor position. It's like having a Vim tutor that constantly shows you what movements are possible, helping you discover and learn efficient navigation patterns.

### Why Use Precognition?

**What It Teaches:**
- Shows available jumps: next word (`w`), end of word (`e`), back (`b`)
- Line movements: beginning (`^`), first character (`0`), end (`$`)
- Matching pairs (`%`) for brackets and parentheses
- Paragraph jumps (`{`, `}`)
- File jumps (`gg`, `G`)

### Precognition Keymaps

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `<leader>pc` | **Toggle Precognition** | Show/hide motion hints |
| `:PrecognitionToggle` | **Command Toggle** | Alternative way to toggle hints |

### Understanding Precognition Hints

**Inline Hints (on current line):**
- `^` - First non-blank character of line
- `0` - Beginning of line
- `w` - Next word
- `e` - End of current/next word
- `b` - Previous word
- `W`, `E`, `B` - WORD movements (space-delimited)
- `$` - End of line
- `%` - Matching bracket/parenthesis

**Gutter Hints (in the sign column):**
- `gg` - Go to first line of file
- `G` - Go to last line of file
- `{` - Previous paragraph/block
- `}` - Next paragraph/block

### How They Work Together

**Learning Workflow:**
1. **Precognition** shows you what movements are available
2. Try using those movements instead of repetitive `hjkl`
3. **Hardtime** blocks you when you fall back to bad habits
4. Over time, you naturally adopt efficient movements

**Example Scenario:**
- You want to move to the end of a line
- Precognition shows `$` hint at the end
- You try pressing `l` repeatedly instead
- Hardtime blocks you after 2 presses and suggests using `$`
- Next time, you remember to use `$` directly!

### Tips for Using Both Plugins

1. **Start with Precognition only** - Learn what's available
2. **Add Hardtime gradually** - Enable it once you know the alternatives
3. **Disable temporarily** - Use `<leader>ht` during urgent work
4. **Check your progress** - Use `<leader>hr` to see improvement
5. **Be patient** - Building muscle memory takes time

---

## 📦 Plugin Management (Mason & Lazy)

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `<leader>cm` | **Open Mason** | Opens the Mason UI to install/manage language servers and tools. |

### Commands (Type these in command mode `:`)
| Command | Description |
|---------|-------------|
| `:Mason` | Open Mason package manager to install LSP servers |
| `:Lazy` | Open Lazy plugin manager interface |
| `:Lazy update` | Update all plugins to latest versions |
| `:Lazy clean` | Remove unused plugins |
| `:Format` | Manually format the current file |

---

## ⚡ Code Editing Power Moves

### Line Operations
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `dd` | **Delete Line** | Deletes the entire current line and copies it to clipboard |
| `D` | **Delete to End** | Deletes from cursor to end of line |
| `C` | **Change to End** | Deletes from cursor to end of line and enters insert mode |
| `cc` or `S` | **Change Line** | Deletes entire line and enters insert mode |
| `yy` | **Yank (Copy) Line** | Copies the entire current line |
| `Y` | **Yank to End** | Copies from cursor to end of line |
| `yyp` | **Duplicate Line** | Copy line and paste below (quick duplicate) |
| `ddp` | **Swap Lines** | Delete line and paste below (moves line down) |
| `J` | **Join Lines** | Joins current line with next line (removes line break) |
| `gJ` | **Join Without Space** | Joins lines without adding a space |

### Indentation Commands
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `>>` | **Indent Right** | Indents current line to the right |
| `<<` | **Indent Left** | Indents current line to the left |
| `=` | **Auto-indent** | Auto-indents based on code syntax |
| `gg=G` | **Indent Entire File** | Auto-indents the whole file properly |
| `>}` | **Indent Paragraph** | Indents until next blank line |
| `3>>` | **Indent Multiple** | Indents 3 lines (change number as needed) |
| **Visual Mode:** | | |
| `V` then `>` | **Indent Selection** | Select lines, then indent right |
| `V` then `<` | **Outdent Selection** | Select lines, then indent left |
| `V` then `=` | **Auto-indent Selection** | Auto-indent selected lines |

### Delete Everything Commands
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `ggdG` | **Delete All Content** | Go to top, delete to bottom (nuclear option!) |
| `ggVG` | **Select All** | Go to top, visual select to bottom |
| `ggVGd` | **Select & Delete All** | Select everything then delete |
| `:%d` | **Command Delete All** | Delete all lines using command |
| `dG` | **Delete to End of File** | Delete from current position to end of file |
| `dgg` | **Delete to Start** | Delete from current position to start of file |

---

## 💻 Terminal Integration & Tmux

### 🤔 Why Terminals Matter in Neovim

You have **three levels** of terminal usage:
1. **Built-in Neovim Terminal** - Quick commands, integrated workflow
2. **Floating Terminals** (via plugins) - Pop-up terminals that don't disrupt your layout
3. **Tmux** - Session persistence, remote work, advanced multiplexing

---

### 🖥️ Built-in Neovim Terminal

Neovim has a powerful built-in terminal emulator that turns any buffer into a fully functional terminal.

#### Opening Terminals
| Command | Description | What It Does |
|---------|-------------|--------------|
| `:terminal` or `:term` | **Open Terminal** | Replaces current buffer with terminal |
| `:split term://bash` | **Horizontal Terminal** | Opens terminal below in horizontal split |
| `:vsplit term://bash` | **Vertical Terminal** | Opens terminal to the right in vertical split |
| `:tabnew term://zsh` | **Terminal in New Tab** | Opens terminal in a new tab |
| `:terminal npm run dev` | **Run Command** | Opens terminal and runs specific command |
| `:10split term://bash` | **Sized Terminal** | Opens terminal with specific height (10 lines) |

#### Terminal Mode Navigation
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `i` or `a` | **Enter Terminal Mode** | Start typing commands in terminal |
| `Ctrl+\ Ctrl+n` | **Exit to Normal Mode** | Leave terminal, treat as normal buffer |
| `Ctrl+w` + direction | **Switch Windows** | Navigate between terminal and editor splits |
| `Ctrl+w` + `:` | **Command Mode** | Run Vim commands while in terminal |

#### Terminal Workflow Tips
- **Quick Command**: `:term` → run command → `exit` → back to coding
- **Persistent Terminal**: `:vsplit term://bash` → keep it open for testing
- **Multiple Terminals**: Open different terminals for server, tests, git
- **Copy from Terminal**: `Ctrl+\ Ctrl+n` → use Vim motions → `y` to copy
- **Send to Terminal**: Copy code → switch to terminal → paste → execute

---

### 🎈 Floating Terminals with ToggleTerm

> **Status**: ✅ INSTALLED - ToggleTerm is ready to use!

Floating terminals give you pop-up terminals that don't disturb your window layout.

#### ToggleTerm Keymaps

| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `<C-\>` | **Toggle Terminal** | Opens/closes floating terminal (main toggle) |
| `<leader>tf` | **Float Terminal** | Open terminal in floating window |
| `<leader>th` | **Horizontal Terminal** | Open terminal at bottom (10 lines) |
| `<leader>tv` | **Vertical Terminal** | Open terminal on right side |
| `<leader>gg` | **Lazygit** | Open git interface in floating window |
| `<leader>tn` | **Node REPL** | Open Node.js interactive terminal |
| `<leader>tp` | **Python REPL** | Open Python interactive terminal |

#### Terminal Mode Navigation

When inside a ToggleTerm terminal:
| Keymap | Description |
|--------|-------------|
| `<Esc>` or `jk` | Exit to normal mode |
| `<C-h/j/k/l>` | Navigate to other windows |
| `<C-w>` | Window commands prefix |

#### ToggleTerm Tips

- **Multiple Terminals**: Use `2<C-\>` to open terminal #2, `3<C-\>` for #3, etc.
- **Send Commands**: Select text in normal mode, then `:ToggleTermSendVisualSelection`
- **Persistent Terminals**: Each numbered terminal maintains its own session
- **Direction Switch**: Start with float (`<leader>tf`), switch to horizontal with `<leader>th`

---

### 🚀 Tmux - The Terminal Multiplexer

**Tmux** (terminal multiplexer) is a separate program that manages terminal sessions. Think of it as a "window manager for your terminal."

#### What is Tmux?

Tmux creates persistent terminal sessions that:
- **Survive disconnections** - SSH drops? Your work is still there
- **Run in background** - Close terminal, tmux keeps running
- **Share sessions** - Multiple people can connect to same session
- **Organize workspaces** - Projects in different sessions

#### Why Use Tmux with Neovim?

| Use Case | Without Tmux | With Tmux |
|----------|--------------|-----------|
| **SSH Disconnects** | Lose everything | Reconnect, everything's there |
| **Long Processes** | Must keep terminal open | Detach, let it run, reattach later |
| **Multiple Projects** | Juggle windows/tabs | Switch entire sessions instantly |
| **Remote Pairing** | Screen sharing only | Both developers in same session |
| **System Restart** | Manually reopen everything | Restore entire workspace |

#### Tmux Key Concepts

1. **Sessions** - Entire workspace (like a project)
2. **Windows** - Tabs within a session (like browser tabs)
3. **Panes** - Splits within a window (like Vim splits)

```
Session: "my-project"
├── Window 1: "editor" (Neovim)
├── Window 2: "server" 
│   ├── Pane 1: npm run dev
│   └── Pane 2: npm run test:watch
└── Window 3: "git" (git commands)
```

#### Essential Tmux Commands

**Outside Tmux:**
| Command | Description |
|---------|-------------|
| `tmux` | Start new session |
| `tmux new -s project` | New session named "project" |
| `tmux ls` | List all sessions |
| `tmux attach -t project` | Attach to "project" session |
| `tmux kill-session -t project` | Delete "project" session |

**Inside Tmux (prefix = `Ctrl+b` by default):**
| Keymap | Description |
|--------|-------------|
| `Ctrl+b d` | Detach from session |
| `Ctrl+b c` | Create new window |
| `Ctrl+b n` | Next window |
| `Ctrl+b p` | Previous window |
| `Ctrl+b %` | Split vertically |
| `Ctrl+b "` | Split horizontally |
| `Ctrl+b arrow` | Navigate panes |
| `Ctrl+b z` | Zoom/unzoom pane |
| `Ctrl+b [` | Enter copy mode (vim-like navigation) |

#### Neovim + Tmux Workflow

**Basic Workflow:**
1. `tmux new -s myproject` - Start project session
2. Open Neovim in first window
3. `Ctrl+b c` - New window for server
4. `Ctrl+b c` - New window for git
5. `Ctrl+b 0/1/2` - Switch between windows
6. `Ctrl+b d` - Detach when done
7. `tmux attach -t myproject` - Resume tomorrow

**Advanced Integration:**
- **vim-tmux-navigator** - Seamless Ctrl+hjkl between Vim and tmux panes
- **tmux-resurrect** - Save/restore sessions after restart
- **tmux-continuum** - Auto-save sessions

#### Tmux vs Neovim Terminal

| Feature | Neovim Terminal | Tmux |
|---------|-----------------|------|
| **Persistence** | Dies with Neovim | Survives everything |
| **Remote Work** | Lost on disconnect | Perfect for SSH |
| **Resource Usage** | Part of Neovim | Separate process |
| **Learning Curve** | Just Vim commands | New key bindings |
| **Integration** | Perfect with Neovim | Good with plugins |
| **Use Case** | Quick commands | Long-running sessions |

### 🎯 Which Should You Use?

**Use Neovim's built-in terminal when:**
- Running quick commands
- Want to copy output easily
- Testing code changes
- Don't need persistence

**Use a floating terminal plugin when:**
- Want quick terminal access without disrupting layout
- Need better terminal UI
- Running interactive commands frequently

**Use Tmux when:**
- Working on remote servers
- Managing multiple projects
- Running long processes
- Need session persistence
- Pair programming

### Pro Terminal Tips
- Start with Neovim's built-in terminal
- Add a floating terminal plugin for convenience
- Learn tmux when you start working remotely or need persistence
- You can use all three together - they complement each other!

---

## 🚀 Developer Productivity Commands

### Text Objects (The Secret Sauce!)
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `ci{` or `ci}` | **Change Inside Braces** | Delete everything inside {} and enter insert mode |
| `di(` or `di)` | **Delete Inside Parens** | Delete everything inside () |
| `ci"` | **Change Inside Quotes** | Delete text inside quotes and enter insert mode |
| `ci'` | **Change Inside Single Quotes** | Delete text inside single quotes and enter insert mode |
| `cit` | **Change Inside Tags** | Change content inside HTML/XML tags |
| `ca{` | **Change Around Braces** | Delete {} and everything inside |
| `dap` | **Delete Around Paragraph** | Delete entire paragraph including blank lines |
| `cip` | **Change Inside Paragraph** | Change paragraph content |
| `ciw` | **Change Inside Word** | Change current word under cursor |
| `caw` | **Change Around Word** | Change word including surrounding spaces |

### Visual Block Mode (Multi-cursor editing!)
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `Ctrl+v` | **Enter Visual Block** | Start rectangular/column selection |
| `Ctrl+v` then `I` | **Insert Multiple Lines** | Insert at beginning of multiple lines |
| `Ctrl+v` then `A` | **Append Multiple Lines** | Append at end of multiple lines |
| `Ctrl+v` then `c` | **Change Multiple Lines** | Change selected block on all lines |
| `Ctrl+v` then `d` | **Delete Column** | Delete selected column |

### Macros (Automate Repetitive Tasks)
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `qa` | **Record Macro to 'a'** | Start recording actions to register 'a' |
| `q` | **Stop Recording** | Stop recording the macro |
| `@a` | **Play Macro 'a'** | Execute the macro stored in 'a' |
| `@@` | **Repeat Last Macro** | Play the last executed macro |
| `5@a` | **Play Macro 5 Times** | Execute macro 'a' 5 times |

### Registers (Advanced Copy/Paste)
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `"ayy` | **Copy to Register 'a'** | Copy line to named register 'a' |
| `"ap` | **Paste from Register 'a'** | Paste content from register 'a' |
| `"+y` | **Copy to System Clipboard** | Copy to system clipboard |
| `"+p` | **Paste from System Clipboard** | Paste from system clipboard |
| `:reg` | **View All Registers** | See contents of all registers |

---

## 🪟 Window & Split Management

### Creating Splits
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `:split` or `:sp` | **Horizontal Split** | Split window horizontally |
| `:vsplit` or `:vsp` | **Vertical Split** | Split window vertically |
| `Ctrl+w s` | **Quick Horizontal Split** | Split horizontally (no command needed) |
| `Ctrl+w v` | **Quick Vertical Split** | Split vertically (no command needed) |

### Navigating Splits
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `Ctrl+w h` | **Move Left** | Move to split on the left |
| `Ctrl+w j` | **Move Down** | Move to split below |
| `Ctrl+w k` | **Move Up** | Move to split above |
| `Ctrl+w l` | **Move Right** | Move to split on the right |
| `Ctrl+w w` | **Cycle Windows** | Move to next window |
| `Ctrl+w p` | **Previous Window** | Move to previous window |

### Managing Splits
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `Ctrl+w =` | **Equal Size** | Make all splits equal size |
| `Ctrl+w _` | **Max Height** | Maximize current split height |
| `Ctrl+w |` | **Max Width** | Maximize current split width |
| `Ctrl+w +` | **Increase Height** | Make split taller |
| `Ctrl+w -` | **Decrease Height** | Make split shorter |
| `Ctrl+w >` | **Increase Width** | Make split wider |
| `Ctrl+w <` | **Decrease Width** | Make split narrower |
| `Ctrl+w q` | **Close Split** | Close current split |
| `Ctrl+w o` | **Only This Split** | Close all other splits |

### Tabs (Workspaces)
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `:tabnew` | **New Tab** | Create a new tab |
| `gt` | **Next Tab** | Go to next tab |
| `gT` | **Previous Tab** | Go to previous tab |
| `3gt` | **Go to Tab 3** | Jump to specific tab number |
| `:tabclose` | **Close Tab** | Close current tab |
| `:tabonly` | **Close Other Tabs** | Keep only current tab |

---

## 🎨 General Vim/Neovim Commands

### Essential Modes
| Key | Mode | Description |
|-----|------|-------------|
| `i` | **Insert Mode** | Start typing/editing text |
| `Esc` | **Normal Mode** | Return to command mode |
| `v` | **Visual Mode** | Select text character by character |
| `V` | **Visual Line** | Select entire lines |
| `Ctrl+v` | **Visual Block** | Select rectangular blocks of text |

### 🆕 Cursor Movement in Insert Mode
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| **Arrow Keys** | **Move Cursor** | ✅ Now enabled in insert mode! Move without leaving insert |
| `Ctrl+o` + motion | **One-Time Normal Command** | Execute single normal mode command (e.g., `Ctrl+o` + `$` = jump to end) |
| `Ctrl+h` | **Backspace** | Delete character before cursor |
| `Ctrl+w` | **Delete Word** | Delete word before cursor |
| `Ctrl+u` | **Delete to Line Start** | Delete from cursor to beginning of line |

**Pro Tip**: Use `Ctrl+o` for quick movements: `Ctrl+o` + `w` (next word), `Ctrl+o` + `0` (line start), `Ctrl+o` + `A` (append at end)

### File Operations
| Command | Description |
|---------|-------------|
| `:w` | Save current file |
| `:q` | Quit Neovim |
| `:wq` or `:x` | Save and quit |
| `:q!` | Quit without saving |
| `:e filename` | Open a file |

### Navigation Basics
| Key | Description |
|-----|-------------|
| `h/j/k/l` | Move left/down/up/right |
| `gg` | Go to beginning of file |
| `G` | Go to end of file |
| `0` or `Home` | Go to beginning of line |
| `^` | Go to first non-blank character |
| `$` or `End` | Go to end of line |
| `w` | Jump to next word |
| `W` | Jump to next WORD (space-separated) |
| `b` | Jump to previous word |
| `B` | Jump to previous WORD |
| `e` | Jump to end of word |
| `E` | Jump to end of WORD |

### Advanced Navigation
| Key | Description |
|-----|-------------|
| `H` | Move to top of screen (High) |
| `M` | Move to middle of screen (Middle) |
| `L` | Move to bottom of screen (Low) |
| `Ctrl+f` | Page down (forward) |
| `Ctrl+b` | Page up (backward) |
| `Ctrl+d` | Half page down |
| `Ctrl+u` | Half page up |
| `Ctrl+e` | Scroll down one line |
| `Ctrl+y` | Scroll up one line |
| `zz` | Center current line on screen |
| `zt` | Move current line to top of screen |
| `zb` | Move current line to bottom of screen |
| `%` | Jump to matching bracket/parenthesis |
| `{` | Jump to previous paragraph |
| `}` | Jump to next paragraph |
| `[[` | Jump to previous section/function |
| `]]` | Jump to next section/function |
| `23G` or `:23` | Jump to line 23 |
| `50%` | Jump to 50% through file |

### Editing Shortcuts
| Key | Description |
|-----|-------------|
| `dd` | Delete (cut) current line |
| `yy` | Copy current line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo last change |
| `Ctrl+r` | Redo |
| `x` | Delete character under cursor |
| `r` | Replace character under cursor |
| `ci"` | Change text inside quotes |
| `di"` | Delete text inside quotes |
| `vi"` | Select text inside quotes |

---

## 🔍 Search & Replace

| Command | Description |
|---------|-------------|
| `/pattern` | Search forward for pattern |
| `?pattern` | Search backward for pattern |
| `n` | Go to next search result |
| `N` | Go to previous search result |
| `:%s/old/new/g` | Replace all occurrences in file |
| `:%s/old/new/gc` | Replace with confirmation |

---

## ⚙️ Quick Fixes for Common Tasks

### Case Conversion
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `~` | **Toggle Case** | Toggle case of character under cursor |
| `g~w` | **Toggle Word Case** | Toggle case of entire word |
| `gUw` | **Uppercase Word** | Make word UPPERCASE |
| `guw` | **Lowercase Word** | Make word lowercase |
| `gU$` | **Uppercase to End** | Make rest of line UPPERCASE |
| `gu$` | **Lowercase to End** | Make rest of line lowercase |
| `gUU` or `gUgU` | **Uppercase Line** | Make entire line UPPERCASE |
| `guu` or `gugu` | **Lowercase Line** | Make entire line lowercase |

### Number Operations
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `Ctrl+a` | **Increment Number** | Increase number under cursor by 1 |
| `Ctrl+x` | **Decrement Number** | Decrease number under cursor by 1 |
| `10Ctrl+a` | **Add 10** | Increase number by 10 |
| `5Ctrl+x` | **Subtract 5** | Decrease number by 5 |

### Quick Edits
| Keymap | Description | What It Does |
|--------|-------------|--------------|
| `xp` | **Transpose Characters** | Swap two characters |
| `ddp` | **Move Line Down** | Swap current line with next |
| `ddkP` | **Move Line Up** | Swap current line with previous |
| `>>` | **Indent Line** | Indent current line |
| `<<` | **Outdent Line** | Outdent current line |
| `.` | **Repeat Last Change** | Repeat your last edit action |
| `u` | **Undo** | Undo last change |
| `Ctrl+r` | **Redo** | Redo undone change |

---

## 🔥 "The Good Stuff" - Power User Combos

### Real-World Developer Scenarios
| Scenario | Commands | What It Does |
|----------|----------|--------------|
| **Delete entire function** | `vif` then `d` | Visual select inside function, delete |
| **Copy entire method** | `vap` then `y` | Visual select around paragraph/method, yank |
| **Change function parameters** | `ci(` | Delete everything inside () and edit |
| **Delete until next function** | `d]]` | Delete from here to next function |
| **Reformat entire file** | `gg=G` | Go to top, auto-indent to bottom |
| **Delete all blank lines** | `:g/^$/d` | Global command to delete empty lines |
| **Comment out block** | `Ctrl+v`, select, `I//` | Visual block, insert comment |
| **Change all occurrences** | `:%s/oldVar/newVar/g` | Replace variable name everywhere |

### Lightning Fast Edits
| Combo | Description | Real Use Case |
|-------|-------------|---------------|
| `dt;` | Delete until semicolon | Remove everything until end of statement |
| `ct}` | Change until closing brace | Replace rest of code block |
| `di"` | Delete inside quotes | Clear string content |
| `da{` | Delete around braces | Remove entire code block |
| `yif` | Yank inside function | Copy function body |
| `cit` | Change inside HTML tag | Replace tag content |
| `vi{` then `=` | Auto-indent block | Fix indentation of code block |
| `f(` then `%` | Find ( then match | Jump to closing parenthesis |

### Pro Combos for Specific Languages
| Language | Combo | What It Does |
|----------|-------|--------------|
| **JavaScript** | `cif` | Change inside function |
| **HTML** | `vit` | Select inside tag |
| **CSS** | `vi{` | Select inside rule |
| **Python** | `dap` | Delete entire function/class |
| **React** | `cit` | Change JSX tag content |

### Productivity Multipliers
| Pattern | Example | Result |
|---------|---------|--------|
| **Delete everything** | `ggdG` | Clear entire file |
| **Select all** | `ggVG` | Select entire file |
| **Copy whole file** | `ggVGy` | Copy everything |
| **Indent whole file** | `gg=G` | Fix all indentation |
| **Delete to end** | `dG` | Delete from cursor to EOF |
| **Delete to start** | `dgg` | Delete from cursor to beginning |

---

## 💡 Pro Tips

1. **Combine Motions**: You can combine numbers with movements, e.g., `5j` moves down 5 lines
2. **Repeat Last Action**: Press `.` to repeat your last action
3. **Quick Save**: Map `:w` to a shorter key if you save frequently
4. **Jump Lists**: Use `Ctrl+o` to go back and `Ctrl+i` to go forward in your location history
5. **Marks**: Set a mark with `ma` and jump back to it with `'a`

---

## 🚀 Workflow Tips

### For JavaScript/TypeScript Development
1. Use `<leader>ps` to search for function usage across the project
2. Use `gd` to quickly jump to definitions
3. `K` for instant type information
4. `<leader>ca` for quick fixes like adding missing imports

### For Quick Edits
1. `<leader>pf` to quickly open any file
2. `<leader>pb` to switch between open files
3. `<leader>f` to format on demand

### For Debugging
1. Use `]d` and `[d` to navigate between errors
2. `<leader>e` to understand what's wrong
3. `<leader>ca` for automatic fixes

---

## 📝 Notes

- **ESLint**: Automatically fixes issues on save for JavaScript/TypeScript files
- **Prettier**: Handles all formatting for web files (JS, TS, CSS, HTML, JSON)
- **Format on Save**: Enabled by default for all supported file types
- **Color Scheme**: Using Rose Pine theme (variant: main)

---

## 🆘 Getting Help

- Type `:h keyword` to get help on any Neovim topic
- Use `<leader>ph` to search help documentation with Telescope
- Check `:checkhealth` to diagnose issues with your setup

---

## 🔄 Quick Reference Card

```
Navigation:        Files:           LSP:            Format:
<leader>pf - find  :w - save       gd - definition  <leader>f
<leader>ps - grep  :q - quit       K - hover docs
<leader>pb - bufs  :wq - save+quit gr - references

Learning Tools:    Harpoon:         Terminal:
<leader>ht - hardtime toggle       <leader>a - add file    <C-\> - toggle term
<leader>hr - habit report          <leader>h - menu        <leader>tf - float
<leader>pc - precognition toggle   <C-h/t/n/s> - files 1-4 <leader>gg - lazygit
```

---

*Remember: The more you use these commands, the more natural they become. Start with the basics and gradually add more to your workflow!*
