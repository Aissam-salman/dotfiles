#!/bin/bash
# A simple script to update Neovim to the latest stable release
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "Downloading latest Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

echo "Installing..."
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo mv /opt/nvim-linux-x86_64 /opt/nvim

echo "Neovim updated to $(/opt/nvim/bin/nvim --version | head -n 1)"
rm -rf "$TEMP_DIR"
