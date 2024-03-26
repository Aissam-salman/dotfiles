#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

# Fonction pour afficher les messages de progression
print_message() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

print_message "Copying files from GitHub repository..."

# Clonage des fichiers de configuration depuis le référentiel GitHub
git clone https://github.com/Aissam-salman/dotfiles.git "$HOME/dotfiles" || { print_message "Error: Failed to clone dotfiles repository"; exit 1; }
print_message "Cloned dotfiles repository successfully"

# Configuration de Fish shell
if [ -d "$HOME/dotfiles/fish" ]; then
    mkdir -p "$HOME/.config"
    cp -r "$HOME/dotfiles/fish" "$HOME/.config/"
    print_message "Fish shell configuration copied successfully"
else
    print_message "Warning: Fish shell configuration not found in dotfiles repository"
fi

# Configuration de WezTerm
if [ -d "$HOME/dotfiles/wezterm" ]; then
    mkdir -p "$HOME/.config"
    cp -r "$HOME/dotfiles/wezterm" "$HOME/.config/"
    print_message "WezTerm configuration copied successfully"
else
    print_message "Warning: WezTerm configuration not found in dotfiles repository"
fi

# Configuration de Starship
if [ -f "$HOME/dotfiles/starship.toml" ]; then
    mkdir -p "$HOME/.config"
    cp "$HOME/dotfiles/starship.toml" "$HOME/.config/"
    print_message "Starship configuration copied successfully"
else
    print_message "Warning: Starship configuration not found in dotfiles repository"
fi

# Configuration de Neovim
git clone https://github.com/Aissam-salman/nvim-config.git "$HOME/.config/nvim" || { print_message "Error: Failed to clone Neovim configuration repository"; exit 1; }
print_message "Neovim configuration cloned successfully"

# Configuration de lab-code
git clone https://github.com/Aissam-salman/labo_code.git "$HOME/Documents/labo_code" || { print_message "Error: Failed to clone lab-code repository"; exit 1; }
print_message "Lab-code repository cloned successfully"

print_message "Setup and configuration completed successfully. Enjoy!"
