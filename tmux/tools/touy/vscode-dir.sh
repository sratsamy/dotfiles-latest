#!/usr/bin/env bash

# Filename: ~/github/dotfiles-latest/tmux/tools/prime/tmux-sessionizer.sh

# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

# NOTE:
# Remember to make this file executable

# Check if one argument is being provided
if [[ $# -eq 1 ]]; then
  # Use the provided argument as the selected directory
  selected=$1
elif [[ $# -eq 0 ]]; then
  # Explicitly specified 0 in case someone decides to pass more than 1 argument
  # Use 'find' to list directories in specified paths and 'fzf' for interactive selection
  selected=$(find ${HOME}/github ${HOME}/code ${HOME}/code/insights ${HOME}/insights/hawaii/pkg -mindepth 1 -maxdepth 1 -type d | fzf)
  # Prime's example below
  # selected=$(find ~/work/builds ~/projects ~/ ~/work ~/personal ~/personal/yt -mindepth 1 -maxdepth 1 -type d | fzf)

  # Debugging, uncomment below if you need to see what's being selected
  # tmux display-message -d 10000 "Directory selected via fzf: $selected"
elif [[ $# -eq 2 ]]; then
  # Use the second argument as the directory path for the find command
  dir_to_search="$2"
  # Make sure the directory exists
  if [[ -d "$dir_to_search" ]]; then
    selected=$(find "$dir_to_search" -mindepth 1 -maxdepth 1 -type d | fzf)
  else
    tmux display-message -d 3000 "Directory does not exist: $dir_to_search"
    exit 1
  fi
else
  # This will hopefully catch your attention
  tmux display-message -d 1000 "This script expects zero, one or two arguments."
  sleep 1
  tmux display-message -d 1000 "This script expects zero  one or two arguments."
  sleep 1
  tmux display-message -d 3000 "This script expects zero  one or two arguments."
  exit 1
fi

# Exit the script if no directory is selected
if [[ -z $selected ]]; then
  # Debugging
  # tmux display-message -d 5000 "No directory selected. Exiting."
  exit 0
fi

code $selected
