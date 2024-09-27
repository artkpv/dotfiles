#!/bin/bash

# Author: artkpv
# This is to install my dotfiles. Dotfiles are bare repository with an alias.

# To replicate on a new system:
DOTFILES="$1"
[[ -z "$DOTFILES" ]] && { 
    echo 'Usage: dotfiles_install.sh <path to dotfiles repo>'
    exit 1 
}

git clone --bare "$DOTFILES" "$HOME/.dotfiles"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

for file in $( dotfiles checkout 2>&1 | grep -E "\s+\." | cut -f 2 ) ; do 
    mkdir --parents ".dotfiles-backup/$( dirname "$file" )"
    mv "$file" ".dotfiles-backup/$file"
done

dotfiles checkout --recurse-submodules
dotfiles config --local status.showUntrackedFiles no
