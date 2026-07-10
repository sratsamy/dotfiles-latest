#!/usr/bin/env bash

# Filename: ~/github/dotfiles-latest/tmux/tools/prime/tmux-sessionizer.sh

# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

# NOTE:
# Remember to make this file executable

# Cache configuration
CACHE_FILE="${HOME}/.cache/cursor-workspaces.txt"
CACHE_DIR="$(dirname "$CACHE_FILE")"

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Function to update cache in background
update_cache() {
  find ${HOME}/github ${HOME}/code ${HOME}/code/insights ${HOME}/insights/hawaii/pkg -name "*.code-workspace" 2>/dev/null > "$CACHE_FILE.tmp" && mv "$CACHE_FILE.tmp" "$CACHE_FILE" &
}

# Check if one argument is being provided
if [[ $# -eq 1 ]]; then
  # Use the provided argument as the selected directory
  selected=$1
elif [[ $# -eq 0 ]]; then
  # Use cache if it exists, otherwise fall back to live search
  if [[ -f "$CACHE_FILE" ]]; then
    selected=$(cat "$CACHE_FILE" | fzf)
  else
    # Cache doesn't exist, do live search
    selected=$(find ${HOME}/github ${HOME}/code ${HOME}/code/insights ${HOME}/insights/hawaii/pkg -name "*.code-workspace" | fzf)
  fi
  # Update cache in background for next time
  update_cache
  # Prime's example below
  # selected=$(find ~/work/builds ~/projects ~/ ~/work ~/personal ~/personal/yt -mindepth 1 -maxdepth 1 -type d | fzf)

  # Debugging, uncomment below if you need to see what's being selected
  # tmux display-message -d 10000 "Directory selected via fzf: $selected"
elif [[ $# -eq 2 ]]; then
  # Use the second argument as the directory path for the find command
  dir_to_search="$2"
  # Make sure the directory exists
  if [[ -d "$dir_to_search" ]]; then
    selected=$(find "$dir_to_search" -name "*.code-workspace" | fzf)
    # Update cache in background for next time
    update_cache
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

cursor $selected
