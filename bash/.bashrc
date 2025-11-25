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
alias ff="fzf --preview 'bat --style=numbers --color=always {}' | xargs -n 1 $EDITOR"
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
tma(){ tmux attach || tmux new -s "$1"; }
tms(){ tmux list-sessions; }
