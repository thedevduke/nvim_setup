# Neovim Configuration VPS Setup TODO

## Prerequisites on VPS

### 1. Install Core Dependencies
```bash
# Update package manager
sudo apt update && sudo apt upgrade -y  # For Debian/Ubuntu
# OR
sudo yum update -y  # For RHEL/CentOS

# Install Neovim (v0.9.0 or later)
# Option A: From package manager (might be older)
sudo apt install neovim -y  # Debian/Ubuntu
# Option B: From official releases (recommended)
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
sudo mv nvim-linux64 /opt/
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

# Install Git
sudo apt install git -y

# Install build tools (needed for Treesitter)
sudo apt install build-essential cmake -y

# Install Node.js and npm (for LSP servers)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install nodejs -y

# Install Python3 and pip
sudo apt install python3 python3-pip -y

# Install ripgrep (for Telescope grep)
sudo apt install ripgrep -y

# Install fd-find (optional, for better file finding)
sudo apt install fd-find -y
```

## Setup Steps

### 1. Initialize Git Repository (Local Machine)
```bash
cd ~/.config/nvim
git init
git add .
git commit -m "Initial Neovim configuration"
# Create a GitHub/GitLab repo and push
git remote add origin YOUR_REPO_URL
git push -u origin main
```

### 2. Clone Configuration on VPS
```bash
# Backup existing config if any
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null

# Clone your configuration
git clone YOUR_REPO_URL ~/.config/nvim

# Enter Neovim (plugins will auto-install)
nvim
# Wait for lazy.nvim to bootstrap and install plugins
# Exit and re-enter if needed
```

### 3. Post-Installation Verification
```bash
# Check Neovim version
nvim --version

# Inside Neovim, run health check
:checkhealth

# Check Mason installations
:Mason

# Update plugins if needed
:Lazy update
```

## Troubleshooting

### Common Issues

1. **Treesitter compilation fails**
   - Ensure `gcc` and `make` are installed
   - Check that you have sufficient permissions

2. **LSP servers not installing**
   - Verify Node.js is installed: `node --version`
   - Check Mason log: `:MasonLog`

3. **Telescope not finding files**
   - Install ripgrep: `sudo apt install ripgrep`
   - Install fd-find for better performance

4. **Clipboard not working**
   - Install xclip or xsel: `sudo apt install xclip`
   - For SSH sessions, use OSC 52 or forward X11

5. **Fonts/Icons not displaying**
   - Install a Nerd Font on your local terminal
   - Configure your SSH client to use the Nerd Font

## Maintenance

### Keep Configuration Synced
```bash
# On VPS - Pull latest changes
cd ~/.config/nvim
git pull

# After making changes locally
git add .
git commit -m "Update configuration"
git push
```

### Update Plugins
```bash
# Inside Neovim
:Lazy update
:Mason update
```

### Update Lock File
```bash
# After updating plugins, commit the lock file
git add lazy-lock.json
git commit -m "Update plugin versions"
git push
```

## Optional Enhancements

- [ ] Set up dotfiles repository for broader config management
- [ ] Create install script for automated setup
- [ ] Configure SSH key for GitHub access on VPS
- [ ] Set up Neovim as default editor: `export EDITOR=nvim`
- [ ] Install additional language servers via Mason as needed