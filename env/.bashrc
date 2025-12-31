# ============================================
# BASH Configuration - Main Entry Point
# ============================================
# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Fichier principal qui charge tous les modules
# Configuration modulaire pour une meilleure organisation
#
# Structure:
#   ~/.config/bash/.bash_config    - Configuration de base (history, keybindings, PATH, envs)
#   ~/.config/bash/.bash_aliases   - Tous les alias (incluant ceux d'omarchy)
#   ~/.config/bash/.bash_functions - Toutes les fonctions (incluant celles d'omarchy)
#
# Note: Intègre le contenu de omarchy pour portabilité entre distributions
# ============================================

# Charger la configuration de base
[ -f ~/.config/bash/.bash_config ] && source ~/.config/bash/.bash_config

# Charger les alias
[ -f ~/.config/bash/.bash_aliases ] && source ~/.config/bash/.bash_aliases

# Charger les fonctions
[ -f ~/.config/bash/.bash_functions ] && source ~/.config/bash/.bash_functions

eval "$(starship init bash)"