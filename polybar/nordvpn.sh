#!bash
nordvpn status | sed -nE '/Status/s/Status:\s(.*)/\1/p'
