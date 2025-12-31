# ============================================
# ZSH Configuration - Main Entry Point
# ============================================
# Fichier principal qui charge tous les modules
# Configuration modulaire pour une meilleure organisation
#
# Structure:
#   ~/.config/zsh/.zsh_config    - Configuration de base (PATH, history, keybindings, etc.)
#   ~/.config/zsh/.zsh_aliases   - Tous les alias
#   ~/.config/zsh/.zsh_functions - Toutes les fonctions personnalisées
# ============================================

# Charger la configuration de base
[ -f ~/.config/zsh/.zsh_config ] && source ~/.config/zsh/.zsh_config

# Charger les alias
[ -f ~/.config/zsh/.zsh_aliases ] && source ~/.config/zsh/.zsh_aliases

# Charger les fonctions
[ -f ~/.config/zsh/.zsh_functions ] && source ~/.config/zsh/.zsh_functions

