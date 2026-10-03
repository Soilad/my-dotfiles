eww update brightness=$(brightnessctl -d intel_backlight g | awk '{ print $1/17777*100 }')
eww update speaker-volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}')
eww update mic-volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2*100}')
