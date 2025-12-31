# -------------------------
# FILE SYSTEM (from omarchy)
# -------------------------
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# -------------------------
# ZOXIDE INTEGRATION (from omarchy)
# -------------------------
if command -v zoxide &> /dev/null; then
  alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi

# -------------------------
# NAVIGATION ALIASES
# -------------------------
alias sd="cd ~ && cd \$(find * -type d | fzf --preview 'ls -l {}')"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd..="cd .."
alias pdw="pwd"
alias lab="cd ~/Work/LAB"

# -------------------------
# EDITOR ALIASES
# -------------------------
alias vi="$EDITOR"
alias vim="$EDITOR"
n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }

# -------------------------
# CONFIG FILE ALIASES
# -------------------------
alias nnvim="$EDITOR ~/.config/nvim/init.lua"
alias nzsh="$EDITOR ~/.zshrc"
alias nbash="$EDITOR ~/.bashrc"

# -------------------------
# GIT ALIASES (from omarchy)
# -------------------------
alias g='git'
alias gcm='git commit -m'
alias lg="lazygit"

# -------------------------
# DEVELOPMENT ALIASES
# -------------------------
alias d='docker'
alias py="python"
alias nrd="npm run dev"
alias crd="composer run dev"
alias paco="/home/salman/francinette/tester.sh"

# -------------------------
# LISTING ALIASES (custom)
# -------------------------
alias l="lsd"
alias l.="ls -A | egrep '^\.'"

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

# -------------------------
# SHELL SWITCHING
# -------------------------
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Done. Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Done. Now log out.'"

# -------------------------
# POWER MANAGEMENT
# -------------------------
alias ssn="sudo shutdown now"
alias sr="reboot"

# -------------------------
# TMUX ALIASES
# -------------------------
alias sourcetmux="tmux source ~/.tmux.conf"
