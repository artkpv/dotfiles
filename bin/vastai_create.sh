# Published at https://gist.github.com/artkpv/c5ae0dd8609a934ca0a1fc64df8269ad
DPH="${1:-1.1}"
VRAM="${2:-40}"

search_str="reliability > 0.8 inet_down >= 600.0 num_gpus>=1 gpu_ram >= $VRAM disk_space >= 110 duration >= 1 dph <= $DPH cuda_vers >= 12.0 "
echo "$search_str":
instances=$( vastai search offers "$search_str" -o dlperf_usd )

echo "$instances"
IID=$( echo "$instances" | tail -1 | cut -d ' ' -f 1 )
echo "Enter ID for the instance to create ($IID)?"
read -r ans
ans=${ans:-$IID}

if [[ "$ans" =~ ^[0-9]+$ ]] ; then
    IID=$ans
    res=$( vastai create instance "$IID" \
        --disk 180 \
        --image 'pytorch/pytorch:latest' \
        --onstart ~/bin/vastai_template.sh \
        --env "-e GITHUB_TOKEN=$GITHUB_TOKEN -e HF_TOKEN=$HF_TOKEN -e WANDB_API_KEY=$WANDB_API_KEY -e OPENAI_API_KEY=$OPENAI_API_KEY " 
    )
    echo "$res"
    INS_ID=$( echo "$res" | grep -o "[0-9]\+" )
    SSHURL=$( vastai ssh-url "$INS_ID" )

    echo "$SSHURL"
    port=$( echo "$SSHURL" | grep -o '[0-9]\{3,\}' )
    nport=$(( port - 1 ))
    SSHURL="${SSHURL//$port/$nport}"
    echo "$SSHURL" | xclip -selection clipboard
    echo waiting to start
    sleep 15
    ssh "$SSHURL" <<EOF
    cd /workspace  
    . ./create_env.sh '
EOF
fi 

