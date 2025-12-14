# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# -------------------------
# ALIASES
# -------------------------
# Top directories navigation
alias zz='z -l'      # lister les dossiers les plus utilisés
alias zc='cd $(z -l | fzf)'  # fuzzy cd avec z

alias vi="$EDITOR"
alias vim="$EDITOR"
alias sd="cd ~ && cd \$(find * -type d | fzf --preview 'ls -l {}')"
alias lg="lazygit"
alias py="python"
alias nrd="npm run dev"
alias crd="composer run dev"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias l="lsd"
alias ls="exa -al --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"
alias l.="ls -A | egrep '^\.'"
alias listdir="ls -d */ > list"
alias sps="sudo pacman -S"
alias spr="sudo pacman -R"
alias spss="sudo pacman -Ss"
alias cd..="cd .."
alias pdw="pwd"
alias update="sudo pacman -Syyu"
alias pacman="sudo pacman --color auto"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ip="ip -color"
alias wget="wget -c"
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Done. Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Done. Now log out.'"
alias rg="rg --sort path"

alias nnvim="$EDITOR ~/.config/nvim/init.lua"
alias nzsh="$EDITOR ~/.zshrc"
alias nbash="$EDITOR ~/.bashrc"
alias nkitty="$EDITOR ~/.config/kitty/kitty.conf"
alias ssn="sudo shutdown now"
alias sr="reboot"
alias sourcetmux="tmux source ~/.tmux.conf"
alias paco="/home/salman/francinette/tester.sh"
alias lab="cd ~/Work/LAB"
# z fuzzy navigation
alias zz='z -l'
alias zc='cd $(z -l | fzf)'

# Ctrl-f pour lancer tmux-sessionizer
bind -x '"\C-f":"tmux-sessionizer"'

# Alt-f pour navigation intelligente avec fzf
smart_fzf_nav() {
    local selected
    
    # Recherche dans le répertoire courant et sous-répertoires
    # Combine fichiers et dossiers avec preview intelligent
    selected=$(find . -mindepth 1 \( -path '*/\.*' -o -path '*/node_modules/*' -o -path '*/.git/*' \) -prune -o -print 2>/dev/null | \
        sed 's|^\./||' | \
        fzf --height=80% \
            --layout=reverse \
            --border \
            --preview '[[ -d {} ]] && ls -lah --color=always {} || ([[ -f {} ]] && (bat --style=numbers --color=always {} 2>/dev/null || cat {}))' \
            --preview-window=right:60% \
            --bind 'ctrl-/:toggle-preview' \
            --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
            --header 'Enter=cd/open | Ctrl-/:toggle preview | Ctrl-d/u:scroll')
    
    if [[ -n "$selected" ]]; then
        if [[ -d "$selected" ]]; then
            cd "$selected" && ls -la
        elif [[ -f "$selected" ]]; then
            ${EDITOR:-vi} "$selected"
        fi
    fi
}

bind -x '"\ef":"smart_fzf_nav"'

# Alt-d pour navigation dans les dossiers uniquement
fzf_dir_nav() {
    local selected
    
    # Recherche uniquement les dossiers
    selected=$(find . -mindepth 1 -type d \( -path '*/\.*' -o -path '*/node_modules' -o -path '*/.git' \) -prune -o -type d -print 2>/dev/null | \
        sed 's|^\./||' | \
        fzf --height=80% \
            --layout=reverse \
            --border \
            --preview 'ls -lah --color=always {}' \
            --preview-window=right:60% \
            --bind 'ctrl-/:toggle-preview' \
            --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
            --header 'Enter=cd to directory | Ctrl-/:toggle preview')
    
    if [[ -n "$selected" ]]; then
        cd "$selected" && ls -la
    fi
}

bind -x '"\ed":"fzf_dir_nav"'

# -------------------------
# FUNCTIONS
# -------------------------
# mkdir + cd
mkcd() { mkdir -p "$@" && cd "$_"; }

# Git flow rapide
togit(){ git add . && git commit -m "$1" && git push; }
gall(){ git add . && git commit -m "${1:-'quick commit'}" && git push; }


valgo(){ valgrind --leak-check=full --track-origins=yes ./"$1"; }

# Quick open/edit config
edit(){ $EDITOR ~/.config/$1/$2; }


# Tmux sessions
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

tms(){ tmux list-sessions; }
export PATH="$HOME/.local/bin:$PATH"
