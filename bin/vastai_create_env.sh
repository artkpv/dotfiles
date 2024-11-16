#!/bin/bash

# Creates dev environment

echo Installing and updating packages...
apt-get --yes update

packages=(
    bat
    dstat
    entr
    fzf
    git
    git-annex
    git-lfs
    git-repair
    htop
    make
    neovim
    netbase
    nnn
    sudo
    tmux
    tree
    zsh
    zoxide

    # python
    #git-delta
    #lf
    #tree-sitter-cli
    #z
    #zsh-completions
# fzf-tab-git
# git-filter-repo
# oh-my-zsh-git
)

apt install --yes "${packages[@]}"


dotfiles() {
    /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

if [[ ! -e $HOME/.dotfiles ]] ; then
    echo 'Installing dotfiles...'
    DOTFILES=https://oauth2:${GITHUB_TOKEN}@github.com/artkpv/dotfiles.git
    cd "$HOME" || exit 1
    git clone --bare "$DOTFILES" "$HOME/.dotfiles" 

    for file in $( dotfiles checkout 2>&1 | grep -E "\s+\." | cut -f 2 ) ; do 
        echo "Backing up $file"
        mkdir --parents ".dotfiles-backup/$( dirname "$file" )"
        mv "$file" ".dotfiles-backup/$file"
    done
    dotfiles checkout bare_main
    dotfiles config --local status.showUntrackedFiles no
    dotfiles submodule init
    dotfiles submodule update

    echo 'dotfiles installed'
fi

function create_repo()
{
    URL=$1
    DIR=$2
    BRANCH=$3

    [[ -e $DIR ]] || { 
        echo "Creating repo: $URL ($BRANCH) at $DIR "
        git clone --branch "$BRANCH" --recurse-submodules "$URL" "$DIR" ;
    }

    cd "$DIR" || { echo 'Failed to clone' ;  exit 1;  }
    python -m venv .venv
    source .venv/bin/activate
    pip install -U pip
    pip install -e .
    pip install vastai 
}

create_repo "https://oauth2:${GITHUB_TOKEN}@github.com/artkpv/rl_for_steganography" /workspace/rl_for_steg main

#[[ ! $SHELL =~ zsh ]] && chsh -s /usr/bin/zsh
