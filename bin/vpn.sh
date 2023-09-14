#!/bin/bash
while [ 1 = 1 ] ; do
    if curl https://ya.ru -s --connect-timeout 1 > /dev/null && ! curl -s --connect-timeout 1 'https://duckduckgo.com/?t=ffab&q=my+ip&ia=answer' | grep Russia -q ; then
        break
    fi
    #for s in be207 be206 be205 be204 it239 it238 it237 ne1001 ne1000 ne998 ne999 ne996 ne997 ne993 mx93 mx94 mx92 mx90 mx91; do 
    # for s in Belgium Italy Netherlands Mexico; do 
    for s in Netherlands Turkey Bulgaria; do 
        nordvpn d
        nordvpn c $s || continue
        if curl https://ya.ru -s  --connect-timeout 1 > /dev/null && ! curl -s  --connect-timeout 1 'https://duckduckgo.com/?t=ffab&q=my+ip&ia=answer' | grep Russia -q ; then
            break
        fi
        #if ping 1.1.1.1 -w 3 -c 3 ; then
        #    break
        #fi
    done
done
