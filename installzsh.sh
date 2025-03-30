#!/bin/bash

# Vérification des droits root
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script en tant qu'administrateur."
  exit 1
fi

# Installation de Zsh
apt update && apt install -y zsh git curl

# Installation de Oh My Zsh
env RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# Installation des plugins Zsh
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions

# Installation de Starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Configuration de Starship
mkdir -p ~/.config
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Activation des plugins dans le fichier .zshrc
sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)/" ~/.zshrc


# Définir Zsh comme shell par défaut
chsh -s $(which zsh)

# Message de fin
echo "Installation terminée. Redémarrez le terminal pour utiliser Zsh avec Oh My Zsh et Starship."
