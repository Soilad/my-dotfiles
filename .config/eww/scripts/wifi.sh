 eww update wifilist="$(nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list |
                               jq -R -s '
                             split("\n")[:-1]
                             | map(split(":")[1])
                           ')"
