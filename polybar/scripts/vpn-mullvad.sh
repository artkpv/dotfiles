#!/usr/bin/env sh

# Refs https://github.com/totoroot/polybar-modules-mullvad/blob/main/vpn-mullvad.sh
#
get_current_protocol() {
    mullvad relay get | cut -d ' ' -f3 | tr '[:upper:]' '[:lower:]'
}

get_current_location() {
        mullvad relay get | grep -o -P '(?<=country|city).*(?=using)' | sed 's/ //g' | sed 's/,/-/g'
}

get_current_country() {
    get_current_location | sed 's/.*-//g'
}

get_tunnel_details() {
    if [ "$(get_current_protocol)" = "wireguard" ]; then
        echo "$(get_current_location) wg"
    elif [ "$(get_current_protocol)" = "openvpn" ]; then
        echo "$(get_current_location) ov"
    else
        echo "tunnel error"
    fi
}

set_protocol() {
    mullvad relay set tunnel-protocol "${1}"
}

list_country_shortcodes() {
    mullvad relay list | grep -v '^[[:blank:]]' | cut -d '(' -f2 | cut -d ')' -f1 | sed '/^$/d'
}

list_city_shortcodes() {
    mullvad relay list | grep '^[[:blank:]]' | cut -d '(' -f2 | cut -d ')' -f1 | grep '^[a-z]' | sed '/^$/d'
}

get_previous_country() {
    list_country_shortcodes | grep "$(get_current_country)" -B1 | head -n 1 | awk '{printf $0}'
}

get_next_country() {
    list_country_shortcodes | grep "$(get_current_country)" -A1 | tail -n 1 | awk '{printf $0}'
}

set_location() {
    mullvad relay set location "${1}"
}

toggle_protocol() {
    echo "wireguard openvpn" | sed "s/\s*$(get_current_protocol)\s*//g"
}

case $1 in
	"--status") 
        echo "$(mullvad status | cut -d ' ' -f1,6 )"
        ;;
	"--toggle")
	    if [[ "$(mullvad status)" =~ "Connected" ]]; then
	        mullvad disconnect
        elif [[ "$(mullvad status)" =~ "Disconnected" ]]; then
	        mullvad connect
	    else
            :
	    fi;;
	"--reconnect") mullvad reconnect;;
	"--tunnel-details") get_tunnel_details;;
	"--location") get_current_location;;
	"--country") get_current_country;;
	"--protocol") get_current_protocol;;
	"--previous") set_location "$(get_previous_country)";;
	"--next") set_location "$(get_next_country)";;
	"--toggle-protocol") set_protocol "$(toggle_protocol)";;
esac
