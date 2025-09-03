export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/Applications:/usr/bin:$PATH"
export PATH="/home/salman/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/salman/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"


[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap
source ~/Repos/znap/znap.zsh


# znap prompt sindresorhus/pure

# `znap eval` makes evaluating generated command output up to 10 times faster.
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# `znap install` adds new commands and completions.
znap install aureliojargas/clitest zsh-users/zsh-completions zsh-users/zsh-syntax-highlighting zsh-users/zsh-autosuggestions

znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-syntax-highlighting


zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/salman/.zshrc'

function update_tab_title() {
  print -Pn "\e]2;%n@%m: %~\a"
}
precmd_functions+=(update_tab_title)


# sets tools
export EDITOR=nvim
export VISUAL=code
export GIT_EDITOR=nvim


### ALIASES ###
#
alias vi="$EDITOR"
alias vim="$EDITOR"
## git
#
alias gc="git clone"
alias ga="git add ."
alias gm="git commit -m"
alias gp="git push"

togit ()
{
  git add .
  git commit -m $1
  git push
}

mkcd(){
  mkdir -p "$@"; 
  cd "$_";
}
## C 
alias try="cc -Wall -Wextra -Werror"

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
alias ll="ls -alFh"
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

alias psu="sudo pacstall -U"
alias psi="sudo pacstall -I"
alias psr="sudo pacstall -R"
alias pss="pacstall -S"

## Docker
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'

## Laravel
alias art='php artisan'

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

#golang 
alias gr="go run ."
#tmux 
alias sourcetmux="tmux source ~/.tmux.conf"

eval "$(starship init zsh)"
