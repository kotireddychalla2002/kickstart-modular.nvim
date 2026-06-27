# Kickstart Modular Neovim - Ubuntu Installation Guide

This guide provides instructions for installing **kickstart-modular.nvim** and all of its external dependencies on **Ubuntu**. 

This custom installation setup utilizes:
- **`bob`** (a Neovim version manager) to install and manage Neovim.
- **`cargo`** (Rust package manager) with the `--locked` flag to install `ripgrep`, `fd-find`, and `tree-sitter-cli` reliably.
- **`apt`** for basic system utilities.
- **JetBrains Mono Nerd Font** for rich icon and glyph support.

---

## Step 1: Install System Dependencies via APT

First, update your package database and install the required core utilities (git, build tools, unzip, and clipboard support):

```bash
sudo apt update
sudo apt install make gcc unzip git xclip
```

### Optional: Emoji Fonts (Ubuntu only)
If you want emoji support in Neovim, install the Noto Color Emoji font:
```bash
sudo apt install fonts-noto-color-emoji
```

---

## Step 2: Install Rust and Cargo

Since we will be installing `bob-nvim`, `ripgrep`, `fd-find`, and `tree-sitter-cli` via Cargo, you need to have Rust installed. The recommended way to install Rust on Ubuntu is via `rustup`:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Follow the on-screen prompts to complete the installation. Once installed, configure your current shell:

```bash
source "$HOME/.cargo/env"
```

---

## Step 3: Install Neovim using Bob

[Bob](https://github.com/MordechaiHadad/bob) is a Neovim version manager. Run the following commands to set your Rust toolchain and install Neovim via `bob`:

```bash
# Ensure you are on the stable Rust toolchain
rustup default stable
rustup update stable

# Install bob (using --locked for reproducible builds)
cargo install --locked bob-nvim

# Install and use the stable version of Neovim
bob use stable
```

### Configure PATH for Bob and Cargo
To run the installed tools and Neovim, ensure that Cargo's binary directory and Bob's Neovim binary directory are added to your PATH. Add the following lines to your shell profile configuration file (e.g., `~/.bashrc` or `~/.zshrc`):

```bash
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
```

Then, reload your shell configuration (or open a new terminal):
```bash
source ~/.bashrc
```

Verify the installation of Neovim:
```bash
nvim --version
```

---

## Step 4: Install Ripgrep, fd-find, and Tree-sitter CLI via Cargo

Now install the key external dependencies using `cargo` with the `--locked` flag:

```bash
cargo install --locked ripgrep fd-find tree-sitter-cli
```

> **Why use `--locked`?**
> Using `--locked` ensures Cargo builds and installs the packages using the exact dependency versions specified in their `Cargo.lock` files. This guarantees reproducible builds and prevents compilation issues caused by any breaking downstream dependency updates released on crates.io since the package was published.

---

## Step 5: Install and Configure JetBrains Mono Nerd Font

A Nerd Font is required to display files, debug, and git icons correctly inside Neovim.

### 1. Download and Install the Font on Ubuntu
Run the following commands to download, extract, and install JetBrains Mono Nerd Font to your local fonts directory:

```bash
# Create local font folder if it doesn't exist
mkdir -p ~/.local/share/fonts

# Download and extract JetBrains Mono Nerd Font
cd ~/.local/share/fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz
rm JetBrainsMono.tar.xz

# Refresh font cache
fc-cache -fv
```

### 2. Set Terminal Font
Once installed, you must tell your terminal emulator to use the newly installed font:
1. Open your terminal's **Preferences** or **Settings**.
2. Locate the **Profiles** or **Text** settings.
3. Enable **Custom Font** and select **JetBrainsMono Nerd Font** (e.g., *JetBrainsMono NFM* or *JetBrainsMono NF*).

### 3. Enable in Neovim Configuration
Ensure Neovim knows to render Nerd Font icons. In this setup, this is configured in [options.lua](file:///home/chkr/.config/nvim/lua/options.lua#L11) by setting:
```lua
vim.g.have_nerd_font = true
```

---

## Step 6: Install Kickstart

### Backup Existing Configuration
If you have an existing Neovim configuration, make sure to back it up and clear out previous local data files to avoid conflicts:

```bash
# Backup existing config if it exists
mv ~/.config/nvim ~/.config/nvim.bak

# Clear previous Neovim data files
rm -rf ~/.local/share/nvim/
```

### Clone the Repository
Clone your modular kickstart configuration into your Neovim config directory:

```bash
git clone https://github.com/kotireddychalla2002/kickstart-modular.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

---

## Step 7: Post Installation

Start Neovim:

```bash
nvim
```

Upon startup, Neovim will automatically install all the plugins configured in your setup. 

- To inspect the plugin state: `:lua vim.pack.update(nil, { offline = true })`
- To fetch updates: `:lua vim.pack.update()` (use `:write` to apply updates or `:quit` to cancel them).

---

## FAQ & Running Configurations in Parallel

If you want to keep your existing Neovim configuration in parallel to this one, you can use `$NVIM_APPNAME` to specify an alternative config directory:

1. Clone the kickstart configuration to a custom directory:
   ```bash
   git clone https://github.com/kotireddychalla2002/kickstart-modular.nvim.git ~/.config/nvim-kickstart
   ```
2. Create an alias in your shell profile (e.g., `~/.bashrc`):
   ```bash
   alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
   ```
3. Run `nvim-kickstart` to start Neovim using the alternative config.
