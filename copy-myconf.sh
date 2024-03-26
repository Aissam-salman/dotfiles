#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo "Copy from github repo"
echo 

## for fish && wezterm && starship file config 
git clone https://github.com/Aissam-salman/dotfiles.git {$HOME}
echo "clone dotfile"

cp -r ~/dotfiles/fish ~/.config/fish/
cp -r ~/dotfiles/wezterm ~/.config/wezterm 
cp  ~/dotfiles/starship.toml ~/.config/

## neovim 
git clone https://github.com/Aissam-salman/nvim-config.git ~/.config/nvim

## lab-code 
#
git clone https://github.com/Aissam-salman/labo_code.git ~/Documents/labo_code

echo 
echo "Done !!"
echo "Enjoy"
