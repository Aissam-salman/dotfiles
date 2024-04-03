#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

# Définition des variables pour les chemins
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
NVIM_CONFIG_DIR="$CONFIG_DIR/nvim"
LAB_CODE_DIR="$HOME/Documents/lab_code"

# Fonction pour afficher les étapes
print_step() {
    echo
    echo "=== $1 ==="
    echo
}

# Configuration Git
print_step "Configuring Git"
git config --global user.name "Aissam-salman"
git config --global user.email "nasawi.lmj@gmail.com"
git config --global credential.helper store

# Copie des configurations vers dotfiles
print_step "Copying configurations to dotfiles"
mkdir -p "$DOTFILES_DIR"
cp -rf "$CONFIG_DIR/wezterm" "$DOTFILES_DIR/"
cp -rf "$CONFIG_DIR/fish" "$DOTFILES_DIR/"
cp "$CONFIG_DIR/starship.toml" "$DOTFILES_DIR/"

# Ajout et commit des modifications dans le dépôt dotfiles
print_step "Committing changes in dotfiles"
cd "$DOTFILES_DIR" && git add . && git commit -m "Save dotfiles" && git push

# Copie de la configuration Neovim
print_step "Copying Neovim configuration"
mkdir -p "$DOTFILES_DIR/nvim"
cp -rf "$NVIM_CONFIG_DIR/." "$DOTFILES_DIR/nvim/"

# Ajout et commit des modifications dans le dépôt Neovim
print_step "Committing changes in Neovim configuration"
cd "$DOTFILES_DIR/nvim" && git add . && git commit -m "Save Neovim configuration" && git push

# Copie du projet lab_code
print_step "Copying lab_code project"
mkdir -p "$DOTFILES_DIR/lab_code"
cp -rf "$LAB_CODE_DIR/." "$DOTFILES_DIR/lab_code/"

# Ajout et commit des modifications dans le dépôt lab_code
print_step "Committing changes in lab_code project"
cd "$DOTFILES_DIR/lab_code" && git add . && git commit -m "Save lab_code project" && git push

echo
echo "Done! Your data is saved."
echo
