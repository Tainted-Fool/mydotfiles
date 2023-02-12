#!/bin/bash

# Sync dotfiles repo and ensure that dotfiles are handled correctly afterwards

# declare color for text
GREEN='\033[1;32m'
BLUE='\033[1;34m'
RED='\033[1;30m'
NC='\033[0m'

# navigate to the directory of this script (~/.dotfiles/.bin)
# cd $(dirname $(readlink -f $0))
# cd ..

echo -e "${GREEN}Stashing exisiting changes...${NC}"
stash_result=$(git stash push -m "sync-dotfiles: before syncing dotfiles")
needs_pop=1

if [ "$stash_result" = "No local changes to save" ]; then
  needs_pop=0
fi

echo -e "${BLUE}Pulling updates from dotfiles repo...${NC}"
echo
git pull origin linux
echo

if [[ $needs_pop -eq 1 ]]; then
  echo -e "${BLUE}popping stashed changes...${NC}"
  echo
  git stash pop
fi

unmerged_files=$(git diff --name-only --diff-filter=U)
if [[ -n $unmerged_files ]]; then
  echo -e "${RED}The following files have merge conflicts after popping the stash:${NC}"
  echo
  printf %"s\n" "$unmerged_files"
else
  stow .
fi
