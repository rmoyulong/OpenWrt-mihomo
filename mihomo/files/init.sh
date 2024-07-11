#!/bin/sh

# check mihomo.config.init
init=$(uci -q get mihomo.config.init); [ -z "$init" ] && return

# generate random string for api_secret/password
random=$(awk 'BEGIN{srand(); print int(rand() * 1000000)}')

# set mihomo.mixin.api_secret
uci set mihomo.mixin.api_secret="$random"

# set mihomo.@authentication[0].password
uci set mihomo.@authentication[0].password="$random"

# remove mihomo.config.init
uci del mihomo.config.init

# commit
uci commit mihomo

# exit with 0
exit 0
