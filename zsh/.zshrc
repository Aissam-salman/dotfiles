# -------------------------
# PATH
# -------------------------
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"

# -------------------------
# EDITORS
# -------------------------
export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim

# -------------------------
# OH-MY-ZSH
# -------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""                         # prompt géré par starship
zstyle ':omz:update' mode auto
plugins=(git)
[ -d "$ZSH" ] && source "$ZSH/oh-my-zsh.sh"

# -------------------------
# HISTORY
# -------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_find_no_dups

# -------------------------
# KEYBINDINGS
# -------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Ctrl+F : chercher un dossier avec fzf et s'y déplacer
FZF_NAV_PATHS=(~/Work ~/.config ~/dotfiles)
fzf-cd-home() {
  local paths=(${^FZF_NAV_PATHS}(N/))   # ignore les dossiers absents
  local dir=$(find $paths -maxdepth 3 \( -name .git -o -name node_modules \) -prune -o -type d -print 2> /dev/null | fzf +m --prompt="📁 Dossiers > ")
  if [[ -n "$dir" ]]; then
    cd "$dir"
    zle reset-prompt
  fi
}
zle -N fzf-cd-home
bindkey '^F' fzf-cd-home

# -------------------------
# ALIASES
# -------------------------
alias vi="nvim"
alias vim="nvim"
alias lg="lazygit"
alias nzsh="$EDITOR ~/.zshrc"
alias nnvim="$EDITOR ~/.config/nvim/init.lua"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# -------------------------
# FUNCTIONS
# -------------------------
mkcd() { mkdir -p "$@" && cd "$_"; }

# attacher à une session tmux, ou la créer
tmn() { tmux attach -t "${1:?Usage: tmn <session>}" 2>/dev/null || tmux new -s "$1"; }

# -------------------------
# TOOLS
# -------------------------
command -v fzf      >/dev/null && eval "$(fzf --zsh)"
command -v zoxide   >/dev/null && eval "$(zoxide init zsh)"
command -v starship >/dev/null && eval "$(starship init zsh)"
