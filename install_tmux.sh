#!/bin/sh

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

yay -S --no-confirm --needed tmux


cp ~/dotfiles/.tmux.conf ~/

sourcetmux
