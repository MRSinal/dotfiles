
#!/bin/bash

# Define some variables
DOTFILES_REPO="https://github.com/yourusername/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# Function to install a package
install_package() {
    if ! dpkg -s "$1" >/dev/null 2>&1; then
        echo "Installing $1..."
        sudo apt-get install -y "$1"
    else
        echo "$1 is already installed."
    fi
}

# Update and install required packages
echo "Updating package lists..."
sudo apt-get update

echo "Installing necessary packages..."
install_package rofi
install_package kitty
install_package neovim
install_package polybar
install_package git

# Clone the dotfiles repository
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "Dotfiles directory already exists."
fi

# Symlink configuration files
echo "Symlinking configuration files..."

# Kitty configuration
mkdir -p "$HOME/.config/kitty"
ln -sf "$DOTFILES_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# Neovim configuration
mkdir -p "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/nvim/init.vim" "$HOME/.config/nvim/init.vim"

# Rofi configuration
mkdir -p "$HOME/.config/rofi"
ln -sf "$DOTFILES_DIR/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"

# Polybar configuration
mkdir -p "$HOME/.config/polybar"
ln -sf "$DOTFILES_DIR/polybar/config" "$HOME/.config/polybar/config"
ln -sf "$DOTFILES_DIR/polybar/launch.sh" "$HOME/.config/polybar/launch.sh"
chmod +x "$HOME/.config/polybar/launch.sh"


# Done
echo "Dotfiles installation and configuration complete!"
