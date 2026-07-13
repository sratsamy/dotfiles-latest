#!/bin/bash

brew install --cask wezterm
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
source ~/.zshrc
brew install eza
brew install zoxide

# starship
curl -sS https://starship.rs/install.sh | sh
