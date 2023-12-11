# setting path
set -e fish_user_paths
set -U fish_user_paths $HOME/bin $HOME/usr/bin $HOME/home/salman/.npm $HOME/usr/local/bin

# Changing "ls" to "exa"
alias l='lsd'
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'
# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'




# switch between shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"


#custom prompt shell
starship init fish | source
zoxide init fish | source
