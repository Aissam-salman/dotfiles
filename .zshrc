# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/salman/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
# End of lines configured by zsh-newuser-install
#
#
# User paths
export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/Applications:/usr/bin:$PATH"

#
# sets tools
export EDITOR=nvim
export VISUAL=code

### ALIASES ###
#
#
## git
#
alias gc="git clone"
alias ga="git add ."
alias gm="git commit -m"
alias gp="git push"


## golang
alias gr="go run"
alias gb="go build"

# python
alias py="python"

## npm
alias nrd="npm run dev"

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

alias nb="$EDITOR ~/.bashrc"
alias nf="$EDITOR ~/.config/fish/config.fish"
alias nwezterm="$EDITOR ~/.config/wezterm/wezterm.lua"
alias nnvim="$EDITOR ~/.config/nvim/init.lua"
alias nzsh="$EDITOR ~/.zshrc"
alias nbash="$EDITOR ~/.bashrc"

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="reboot"

eval "$(zoxide init zsh)"


eval "$(starship init zsh)"
