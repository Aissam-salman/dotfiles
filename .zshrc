# -------------------------
# PATH
# -------------------------
export PATH="$HOME/.volta/bin:$HOME/.local/bin:$HOME/Applications:$PATH"
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# -------------------------
# ZINIT SETUP
# -------------------------
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[[ ! -d "$ZINIT_HOME" ]] && mkdir -p "$(dirname $ZINIT_HOME)" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"

# Plugins (lazy loaded)
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit cdreplay -q

# -------------------------
# COMPLETIONS
# -------------------------
autoload -Uz compinit && compinit -C  # cache pour speed
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
mkdir -p ~/.zsh/cache

# -------------------------
# KEYBINDINGS
# -------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

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
eval "$(starship init zsh)"
eval "$(fzf --zsh)"

# -------------------------
# ALIASES
# -------------------------
# Top directories navigation
alias zz='z -l'      # lister les dossiers les plus utilisés
alias zc='cd $(z -l | fzf)'  # fuzzy cd avec z

alias vi="$EDITOR"
alias vim="$EDITOR"
alias sd="cd ~ && cd \$(find * -type d | fzf --preview 'ls -l {}')"
alias ff="fzf --preview 'bat --style=numbers --color=always {}' | xargs -n 1 $EDITOR"
alias lg="lazygit"
alias gr="go run"
alias gb="go build"
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
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Done. Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Done. Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Done. Now log out.'"
alias rg="rg --sort path"
alias nf="$EDITOR ~/.config/fish/config.fish"
alias nwezterm="$EDITOR ~/.config/wezterm/wezterm.lua"
alias nnvim="$EDITOR ~/.config/nvim/init.lua"
alias nzsh="$EDITOR ~/.zshrc"
alias nbash="$EDITOR ~/.bashrc"
alias nkitty="$EDITOR ~/.config/kitty/kitty.conf"
alias ssn="sudo shutdown now"
alias sr="reboot"
alias sourcetmux="tmux source ~/.tmux.conf"
alias paco="/home/salman/francinette/tester.sh"
alias lab="cd ~/LABCODE/"
# z fuzzy navigation
alias zz='z -l'
alias zc='cd $(z -l | fzf)'

alias ud="update_dotfiles"

# -------------------------
# FUNCTIONS
# -------------------------
# mkdir + cd
mkcd() { mkdir -p "$@" && cd "$_"; }

# Git flow rapide
togit(){ git add . && git commit -m "$1" && git push; }
gall(){ git add . && git commit -m "${1:-'quick commit'}" && git push; }

# C/C++ compile + run
try(){
    exe="a.out"
    if ! cc -Wall -Wextra -Werror -o "$exe" "$@"; then
        echo "❌ Compilation échouée."
        return 1
    fi
    echo "✅ Compilation réussie, exécution :"
    ./"$exe"
}

valgo(){ valgrind --leak-check=full --track-origins=yes ./"$1"; }

# Quick open/edit config
edit(){ $EDITOR ~/.config/$1/$2; }


# Tmux sessions
tma(){ tmux attach || tmux new -s "$1"; }
tms(){ tmux list-sessions; }

# dotfiles save
# ~/.zshrc ou fichier de fonctions
update_dotfiles() {
    DOTFILES="$HOME/dotfiles"

    # Liste des configs à sync
    CONFIGS=(
        ".zshrc"
        ".config/kitty/kitty.conf"
    )

    for f in "${CONFIGS[@]}"; do
        src="$HOME/$f"
        dest="$DOTFILES/$f"

        # créer le dossier cible si nécessaire
        mkdir -p "$(dirname "$dest")"
        cp -f "$src" "$dest"
        echo "Copied $f -> $dest"
    done

    # Commit & push
    cd "$DOTFILES" || return
    git add .
    git commit -m "${1:-'Update dotfiles'}"
    git push
    echo "✅ Dotfiles synced and pushed"
}

# -------------------------
# LS COLORS + COMPLETION
# -------------------------
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
