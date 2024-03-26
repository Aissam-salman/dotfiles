#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

# Définition des variables pour les chemins
AURIC_DIR="$HOME/AURIC"
CONFIG_DIR="$HOME/.config"

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

# Installation des logiciels depuis les dépôts officiels
print_step "Installing software from official repositories"
PKGS=(
    # FONT
    'ttf-nerd-fonts-symbols-mono'

    # DEVELOPMENT ---------------------------------------------------------
    'fish'
    'fzf'
    'exa'
    'fd'
    'ripgrep'
    'zoxide'
    'lsd'
    'clang'                 # C Lang compiler
    'cmake'                 # Cross-platform open-source make system
    'postgresql'
    'go'
    'git'                   # Version control system
    'gcc'                   # C/C++ compiler
    'glibc'                 # C libraries
    'nodejs'                # Javascript runtime environment
    'npm'                   # Node package manager
    'php'                   # Web application scripting language
    'python'                # Scripting language
    'yarn'                  # Dependency management (Hyper needs this)
    'jdk-openjdk'
    'jdk17-openjdk'

    # WEB TOOLS -----------------------------------------------------------
    'firefox'               # Web browser
    # MEDIA ---------------------------------------------------------------
    'vlc'                   # Video player
    # GRAPHICS AND DESIGN -------------------------------------------------
    'gcolor2'               # Colorpicker
    # PRODUCTIVITY --------------------------------------------------------
    'obsidian'
    'bitwarden'
    # VIRTUALIZATION ------------------------------------------------------
    # 'virtualbox'
    # 'virtualbox-host-modules-arch'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

# Installation des logiciels AUR
print_step "Installing AUR software"
mkdir -p "$AURIC_DIR"
cd "$AURIC_DIR" || exit

if [ ! -d "$AURIC_DIR/.git" ]; then
    git clone "https://github.com/rickellis/AURIC.git" .
else
    git pull origin master
fi

chmod +x auric.sh

AUR_PKGS=(
    # TERMINAL UTILITIES --------------------------------------------------
    'wezterm'                     # Terminal emulator built on Electron
    # DEVELOPMENT ---------------------------------------------------------
    'visual-studio-code-bin'      # Kickass text editor
    # OTHER
    'appimagelauncher'
    # THEMES --------------------------------------------------------------
    'gtk-theme-arc-git'
    'adapta-gtk-theme-git'
    'paper-icon-theme'
    'tango-icon-theme'
    'tango-icon-theme-extras'
    'numix-icon-theme-git'
    'sardi-icons'
)

for PKG in "${AUR_PKGS[@]}"; do
    ./auric.sh -i "$PKG"
done

# Installation de starship
print_step "Installing Starship prompt"
curl -sS https://starship.rs/install.sh | sh

echo
echo "Done!"
echo
