env | grep _ >> /etc/environment; echo 'starting up'
git config --global credential.helper 'cache --timeout=172800'  # 48 hours
git config --global  --add user.name ArtyomK 
git config --global  --add user.email artyomkarpov@gmail.com
 

> create_env.sh cat <<EOF

apt-get --yes update
apt install --yes nnn neovim dstat htop  netbase git-lfs

function create_repo()
{
    URL=$$1
    DIR=$$2
    BRANCH=$$3

    git clone -b "$$BRANCH" --recurse-submodules "$$URL" "$$DIR" ;
    cd "$$DIR"

    python -m venv .venv
    source .venv/bin/activate
    pip install -U -r requirements.txt
}

create_repo https://github.com/artkpv/rl_for_steganography /workspace/rl_for_steg colors-mapping


EOF

