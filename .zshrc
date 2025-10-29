export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/Applications:/usr/bin:$PATH"
export PATH="/home/salman/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/salman/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

function update_tab_title() {
  print -Pn "\e]2;%n@%m: %~\a"
}
precmd_functions+=(update_tab_title)

# sets tools
export EDITOR=nvim
export VISUAL=code
export GIT_EDITOR=nvim

### ALIASES ###
alias vi="$EDITOR"
alias vim="$EDITOR"
## git
alias gc="git clone"
alias ga="git add ."
alias gm="git commit -m"
alias gp="git push"

togit(){
  git add .
  git commit -m $1
  git push
}

try(){
    local exe="a.out"

    # Compiler et afficher toutes les erreurs de cc
    if ! cc -Wall -Wextra -Werror -o "$exe" "$@"; then
        echo "❌ Compilation échouée."
        return 1
    fi

    # Si la compilation réussit, exécuter
    echo "✅ Compilation réussie, exécution :"
    ./"$exe"
}

mkcd(){
  mkdir -p "$@"; 
  cd "$_";
}

alias sd="cd ~ && cd \$(find * -type d | fzf)"
alias ff="fzf --preview 'bat --style=numbers --color=always {}' | xargs -n 1 nvim"

## golang
alias gr="go run"
alias gb="go build"

# python
alias py="python"

## npm
alias nrd="npm run dev"
alias crd="composer run dev"

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# list
alias l="lsd"
alias ls="exa -al --color=always --group-directories-first" # my preferred listing
alias la="exa -a --color=always --group-directories-first"  # all files and dirs
alias l.="ls -A | egrep '^\.'"
alias listdir="ls -d */ > list"

# pacman
alias sps="sudo pacman -S"
alias spr="sudo pacman -R"
alias spss="sudo pacman -Ss"

# fix obvious typos
alias cd..="cd .."
alias pdw="pwd"
alias update="sudo pacman -Syyu"
alias pacman="sudo pacman --color auto"

## Colorize the grep command output for ease of use (good for log files)##
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# Color output of ip
alias ip="ip -color"

# continue download
alias wget="wget -c"

# grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# switch between bash, zsh and fish
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

# ## apt
# alias update='sudo apt update && sudo apt upgrade -y'
# alias install='sudo apt install -y'
# alias remove='sudo apt remove -y'
# alias autoremove='sudo apt autoremove -y'
# alias search='apt search'
# alias show='apt show'

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="reboot"

#tmux 
alias sourcetmux="tmux source ~/.tmux.conf"

# pnpm
export PNPM_HOME="/home/salman/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
