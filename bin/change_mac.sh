
echo "Previous mac:"
ip link show wlo1 | sed -E -n 's_link\/ether ([0-9A-Za-z:]+)_\1_p' 
sudo ip link set dev wlo1 down
if [[ "$1" == "first" ]] ; then
    sudo ip link set dev wlo1 address dc:fb:48:70:63:4a
else
    # sudo ip link set dev wlo1 address 4c:49:e3:bc:5d:09  # MObile
    sudo ip link set dev wlo1 address dc:fb:48:70:63:4b
fi
echo "New mac:"
ip link show wlo1 | sed -E -n 's_link\/ether ([0-9A-Za-z:]+)_\1_p' 
sudo ip link set dev wlo1 up

