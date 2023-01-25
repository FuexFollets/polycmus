#!/bin/bash

iconcolor=#444

output=$(cmus-remote -C status)
artist=$(echo "$output" | grep "^tag artist" | cut -c 12-)
path="$(echo "$output" | grep "^file" | cut -c 12- | /home/fuexfollets/user-configs/polybar/polycmus/trimname.sh)"
cmusstatus=$(echo "$output"| grep "^status" | cut -c 8-)
case $cmusstatus in 
    "playing")
        icon="(playing)"
        ;;
    "paused")
        icon="(paused)"
        ;;
    "stopped")
        echo
        exit 0
esac

if [[ $artist = *[!\ ]* ]]; then
    song=$(echo "$output" | grep "^tag title" | cut -c 11-)

    echo -n "%{F$iconcolor}$icon%{F-} $artist %{F$iconcolor}-%{F-} $song"
elif [[ $path = *[!\ ]* ]]; then
    IFS="/"
    read -ra parts <<< "$path"
    for i in "${parts[@]}"; do
        file=$i
    done
    # %{F$iconcolor}
    echo -n "CMUS $file $icon%{F-}"
else
        echo
fi
