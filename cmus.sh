#!/bin/bash

iconcolor=#444
textcolor=#7aa2f7

output=$(cmus-remote -C status)
artist=$(echo "$output" | grep "^tag artist" | cut -c 12-)
path="$(echo "$output" | grep "^file" | cut -c 12- | sed "s/\.flac//")"
cmusstatus=$(echo "$output"| grep "^status" | cut -c 8-)
cmusduration=$(echo "$output" | grep "^duration" | cut -c 10- | date -d "@$(cat)" +%M:%S)
cmusposition=$(echo "$output" | grep "^position" | cut -c 10- | date -d "@$(cat)" +%M:%S)
cmuspercent="$cmusposition / $cmusduration"

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
    echo -n "%{F$textcolor}CMUS%{F-} $file $cmuspercent $icon%{F-}"
else
        echo
fi
