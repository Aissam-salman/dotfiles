# Dotfiles (macOS)

Source de vérité de ma config macOS. Chaque dossier reproduit l'arborescence de `$HOME`.

```
dotfiles/
├── ghostty/   ~/.config/ghostty/config
├── lazygit/   ~/.config/lazygit/config.yml
├── nvim/      ~/.config/nvim            (submodule kickstart.nvim)
├── starship/  ~/.config/starship.toml
├── tmux/      ~/.tmux.conf, ~/.config/tmux-sessionizer, ~/.local/scripts
└── zsh/       ~/.zshrc                  (oh-my-zsh + starship)
```

## Installation

```bash
# outils
brew install neovim tmux starship lazygit fzf
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# dotfiles
git clone --recurse-submodules -b macos https://github.com/Aissam-salman/dotfiles.git ~/dotfiles
```

Puis copier les configs (écrase celles existantes) :

```bash
./dev-env --dry   # voir ce qui sera copié
./dev-env
```

Pour ajouter un dossier, l'ajouter à `packages` dans `dev-env`.

Dans tmux, `prefix + I` installe les plugins.

## Raccourcis

- `Ctrl+F` dans zsh : chercher un dossier dans ~/Work, ~/.config, ~/dotfiles (fzf)
- tmux `prefix + f` : tmux-sessionizer
- tmux `prefix + s` : changer de session, `prefix + X` : tuer une session
