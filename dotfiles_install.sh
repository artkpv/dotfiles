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

mkdir -p .dotfiles-backup && \
    dotfiles checkout 2>&1 | grep -E "\s+\." | awk "{'print $1'}" | \
    xargs -I{} mv {} .dotfiles-backup/{}

dotfiles checkout --recurse-submodules
dotfiles config --local status.showUntrackedFiles no
