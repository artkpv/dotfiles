env | grep _ >> /etc/environment; echo 'starting up'
git config --global credential.helper 'cache --timeout=172800'  # 48 hours
git config --global  --add user.name ArtyomK 
git config --global  --add user.email artyomkarpov@gmail.com
 

#"${SHELL}" <(curl -L micro.mamba.pm/install.sh)

> create_env.sh cat <<EOF

#git clone https://github.com/artkpv/play_mats24.git /workspace/play_mats24 ;
#git clone https://github.com/ameek2/Inducing-human-like-biases-in-moral-reasoning-LLMs.git  /workspace/brainbias ;
#git clone https://github.com/artkpv/TransformerLens -b fixes-llama-loading-into-cuda /workspace/TransformerLens ;


#micromamba create --yes -n myenv -c nvidia -c pytorch -c conda-forge  \
#  python==3.10 \
#  conda-forge::datasets \
#  'conda-forge::tokenizers>=0.13.3' \
#  conda-forge::transformers \
#  conda-forge::accelerate \
#  einops \
#  httpcore \
#  ipykernel \
#  ipywidgets \
#  jaxtyping \
#  lightning \
#  numpy \
#  plotly \
#  protobuf \
#  pybids \
#  pynvml \
#  pyparsing \
#  'pytorch-cuda>=11.8' \
#  pytorch::pytorch \
#  pytorch::torchaudio \
#  pytorch::torchvision \
#  scikit-learn \
#  sentencepiece \
#  setuptools \
#  simple-parsing \
#  sniffio \
#  tqdm \
#  wandb \
#  wheel \
#  nbformat \
#  pytest \

apt-get --yes update
apt install --yes nnn neovim dstat htop  netbase git-lfs

#micromamba activate myenv

pip install -U \
    accelerate \
    circuitsvis \
    datasets \
    einops \
    httpcore \
    ipykernel \
    ipywidgets \
    jaxtyping \
    kaleido  \
    lightning \
    nbformat \
    numpy \
    plotly \
    protobuf \
    pybids \
    pynvml \
    pyparsing \
    pytest \
    scikit-learn \
    sentencepiece \
    setuptools \
    simple-parsing \
    sniffio \
    tokenizers \
    torch \
    torchaudio \
    torchvision \
    tqdm \
    transformers \
    wandb \
    wheel \
    openai \
    peft \
    bitsandbytes \
    kaleido \
    omegaconf \

pip install trl

# conda install -y -c nvidia cuda-compiler # Or other options. See https://github.com/microsoft/DeepSpeed/issues/2772
# pip install -U git+https://github.com/CarperAI/trlx.git

# pip install -e /workspace/TransformerLens

git clone https://github.com/artkpv/DLK-works.git /workspace/dlkworks ;
( cd /workspace/dlkworks ; git lfs fetch ; git lfs checkout )

#git clone https://github.com/artkpv/play_mats24 /workspace/play_mats24

#git clone https://github.com/artkpv/dotfiles /workspace/dotfiles

EOF

#cd /workspace/dotfiles || exit
#./install -c install_base.conf.yaml 
