# -------------------------
# PATH
# -------------------------
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.local/scripts:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export FZF_NAV_PATHS="${FZF_NAV_PATHS:-. ~/Work/LAB ~/Work/LAB/42 ~/Documents ~/.config ~/dotfiles}"

# -------------------------
# KEYBINDINGS (ZSH)
# -------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
# --- Configuration fzf personnalisée ---

# Fonction pour chercher les DOSSIERS depuis la racine (~) et s'y déplacer
fzf-cd-home() {
  local dir=$(find ~ -maxdepth 6 -type d 2> /dev/null | fzf +m --prompt="📁 Dossiers (~) > ")
  if [[ -n "$dir" ]]; then
    cd "$dir"
    zle reset-prompt
  fi
}

# Fonction pour chercher les FICHIERS depuis la racine (~) et les ouvrir avec l'éditeur par défaut
fzf-edit-home() {
  local file=$(find ~ -maxdepth 6 -type f 2> /dev/null | fzf +m --prompt="📄 Fichiers (~) > ")
  if [[ -n "$file" ]]; then
    ${EDITOR:-nano} "$file"
    zle reset-prompt
  fi
}

# Création des widgets ZSH
zle -N fzf-cd-home
zle -N fzf-edit-home

# Raccourcis clavier (Keybindings)
bindkey '^F' fzf-cd-home    # Ctrl + F pour les dossiers
bindkey '^E' fzf-edit-home  # Ctrl + E pour les fichiers


# -------------------------
# HISTORY
# -------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# -------------------------
# EDITORS & TOOLS
# -------------------------
export EDITOR=nvim
export VISUAL=code
export GIT_EDITOR=nvim

# -------------------------
# FZF Configuration
# -------------------------
# Personnalisez FZF_NAV_PATHS pour ajouter vos propres chemins

# -------------------------
# OH-MY-ZSH Configuration
# -------------------------
# ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode auto      # update automatically without asking

plugins=(git z tmux vi-mode zsh-autosuggestions zsh-syntax-highlighting)
# -------------------------
# INITIALIZE TOOLS
# -------------------------

eval "$(fzf --zsh)"

alias nzsh="nvim ~/.zshrc"
alias sz="source ~/.zshrc"

# -------------------------
# NAVIGATION ALIASES
# -------------------------
alias zz='z -l'      # lister les dossiers les plus utilisés
alias zc='cd $(z -l | fzf)'  # fuzzy cd avec z
alias sd="cd ~ && cd \$(find * -type d | fzf --preview 'ls -l {}')"
alias cd..="cd .."
alias pdw="pwd"
alias lab="cd ~/Work/LAB/"

# -------------------------
# EDITOR ALIASES
# -------------------------
alias vi="$EDITOR"
alias vim="$EDITOR"
alias ff="fzf --preview 'bat --style=numbers --color=always {}' | xargs -n 1 $EDITOR"

# -------------------------
# CONFIG FILE ALIASES
# -------------------------
alias nf="$EDITOR ~/.config/fish/config.fish"
alias nwezterm="$EDITOR ~/.config/wezterm/wezterm.lua"
alias nnvim="$EDITOR ~/.config/nvim/init.lua"
alias nzsh="$EDITOR ~/.zshrc"
alias nbash="$EDITOR ~/.bashrc"
alias nkitty="$EDITOR ~/.config/kitty/kitty.conf"

# -------------------------
# GIT ALIASES
# -------------------------
alias lg="lazygit"

# -------------------------
# DEVELOPMENT ALIASES
# -------------------------
alias gr="go run"
alias gb="go build"
alias py="python"
alias nrd="npm run dev"
alias crd="composer run dev"
alias paco="/home/salman/francinette/tester.sh"

# -------------------------
# FILE OPERATIONS
# -------------------------
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# -------------------------
# LISTING ALIASES
# -------------------------
alias l="lsd"
alias l.="ls -A | egrep '^\.'"
alias listdir="ls -d */ > list"

# -------------------------
# PACKAGE MANAGER (Arch/Pacman)
# -------------------------
alias sps="sudo pacman -S"
alias spr="sudo pacman -R"
alias spss="sudo pacman -Ss"
alias update="sudo pacman -Syyu"
alias pacman="sudo pacman --color auto"

# -------------------------
# SYSTEM UTILITIES
# -------------------------
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ip="ip -color"
alias wget="wget -c"
alias rg="rg --sort path"

# -------------------------
# SYSTEM CONFIGURATION
# -------------------------
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Done. Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Done. Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Done. Now log out.'"

# -------------------------
# POWER MANAGEMENT
# -------------------------
alias ssn="sudo shutdown now"
alias sr="reboot"

# -------------------------
# TMUX ALIASES
# -------------------------
alias sourcetmux="tmux source ~/.tmux.conf"


# 42

alias new="~/Work/LAB/42/scripts/new_project_c.sh"
alias norme="norminette"
alias cpp="c++ -Wall -Wextra -Werror -std=c++98"# -------------------------
# FZF NAVIGATION
# -------------------------

# -------------------------
# DIRECTORY UTILITIES
# -------------------------
# mkdir + cd
mkcd() { mkdir -p "$@" && cd "$_"; }

# -------------------------
# GIT UTILITIES
# -------------------------
# Git flow rapide
togit(){ git add . && git commit -m "$1" && git push; }
gall(){ git add . && git commit -m "${1:-'quick commit'}" && git push; }

# -------------------------
# DEVELOPMENT UTILITIES
# -------------------------
valgo(){ valgrind --leak-check=full --track-origins=yes ./"$1"; }

# Quick open/edit config
edit(){ $EDITOR ~/.config/$1/$2; }

# -------------------------
# TMUX SESSION MANAGEMENT
# -------------------------
# Fonction pour attacher à une session tmux existante
tma() {
    if [ -z "$1" ]; then
        # Si aucun nom n'est fourni, attacher à la dernière session
        tmux attach
    else
        # Attacher à une session spécifique par son nom
        tmux attach -t "$1"
    fi
}

# Fonction pour attacher ou créer une nouvelle session
tmn() {
    if [ -z "$1" ]; then
        echo "Usage: tmn <nom-de-session>"
        return 1
    fi

    # Attacher si elle existe, sinon créer une nouvelle session
    tmux attach -t "$1" 2>/dev/null || tmux new -s "$1"
}

# Liste toutes les sessions tmux
tms(){ tmux list-sessions; }

[ -d "$HOME/.oh-my-zsh" ] && source "$HOME/.oh-my-zsh/oh-my-zsh.sh"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
