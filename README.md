# Dotfiles

Configuration Linux portable et minimaliste.

## Structure

```
dotfiles/
├── env/                          # Configurations principales
│   ├── .bashrc                   # Point d'entrée Bash
│   ├── .zshrc                    # Point d'entrée Zsh
│   ├── .tmux.conf                # Configuration Tmux
│   └── .config/
│       ├── bash/                 # Modules Bash
│       │   ├── .bash_config      # Configuration de base
│       │   ├── .bash_aliases     # Alias
│       │   └── .bash_functions   # Fonctions
│       ├── zsh/                  # Modules Zsh
│       │   ├── .zsh_config       # Configuration de base
│       │   ├── .zsh_aliases      # Alias
│       │   └── .zsh_functions    # Fonctions
│       ├── kitty/                # Terminal Kitty
│       ├── nvim/                 # Neovim
│       ├── git/                  # Git config
│       ├── starship/             # Prompt Starship
│       └── ...
└── .local/
    └── scripts/                  # Scripts utilitaires
        ├── tmux-sessionizer
        ├── tmux-session-switcher
        └── ...
```

## Installation

Les fichiers de configuration sont gérés par `dev-env`.
run : execute les fichier d'installation situé dans runs_arch par défaut ou runs_{distro} si spécifié.


## Utilisation
- Pour installer les configurations, exécutez le script `dev-env` :
  ```bash
  ./dev-env
  ```
- Cela copiera les fichiers de configuration dans les emplacements appropriés.
- Vous pouvez personnaliser les configurations en modifiant les fichiers dans le répertoire `env/.config/`.
- Pour lancer l'installation, utilisez la commande :
  ```bash
  ./run --dry --distro [distro] [script_name]
  ```
  où `[distro]` est optionnel et permet de spécifier une distribution particulière (par exemple, `ubuntu`, `arch`, etc.).
- Assurez-vous que les chemins XDG sont correctement définis dans votre environnement.

## Configurations incluses
- **Bash/Zsh** : Configuration modulaire avec fichiers séparés pour config, alias et fonctions
- **Tmux** : Scripts de gestion de sessions
- **Neovim** : Configuration complète
- **Kitty** : Terminal avec thèmes
- **Git** : Configuration personnalisée
- **Starship** : Prompt minimaliste et personnalisable
- **Alacritty** : Configuration du terminal rapide
- **Lazygit** : Interface Git TUI
- **Hyprland** : Configuration du gestionnaire de fenêtres (en cours)



