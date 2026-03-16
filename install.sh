#!/bin/bash
set -e

echo "=== pdc dotfiles ==="

# install homebrew if missing
if ! command -v brew &>/dev/null; then
    echo "installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install packages
echo "installing packages..."
brew install eza bat zoxide fzf yazi zsh-autosuggestions zsh-syntax-highlighting zsh-completions fastfetch 2>/dev/null

# fix zsh completion permissions
chmod go-w "$(brew --prefix)/share" 2>/dev/null
chmod -R go-w "$(brew --prefix)/share/zsh" 2>/dev/null

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# symlink ghostty
echo "linking ghostty config..."
mkdir -p ~/.config/ghostty/themes
ln -sf "$DOTFILES/ghostty/config" ~/.config/ghostty/config
ln -sf "$DOTFILES/ghostty/themes/pdc-dark" ~/.config/ghostty/themes/pdc-dark
ln -sf "$DOTFILES/ghostty/themes/pdc-light" ~/.config/ghostty/themes/pdc-light

# symlink zshrc
echo "linking zshrc..."
ln -sf "$DOTFILES/zsh/.zshrc" ~/.zshrc

# symlink nvim
echo "linking nvim config..."
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES/nvim/init.lua" ~/.config/nvim/init.lua
rm -rf ~/.config/nvim/lua ~/.config/nvim/colors
ln -sf "$DOTFILES/nvim/lua" ~/.config/nvim/lua
ln -sf "$DOTFILES/nvim/colors" ~/.config/nvim/colors

# symlink yazi
echo "linking yazi config..."
mkdir -p ~/.config/yazi
ln -sf "$DOTFILES/yazi/yazi.toml" ~/.config/yazi/yazi.toml
ln -sf "$DOTFILES/yazi/keymap.toml" ~/.config/yazi/keymap.toml
ln -sf "$DOTFILES/yazi/theme-dark.toml" ~/.config/yazi/theme.toml

# symlink scripts
echo "linking scripts..."
mkdir -p ~/.local/bin
ln -sf "$DOTFILES/scripts/poly" ~/.local/bin/poly
ln -sf "$DOTFILES/scripts/donut" ~/.local/bin/donut

echo "done! restart your terminal to see changes."
