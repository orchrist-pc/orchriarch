#!/bin/bash
set -e

default_sink=$(pactl info | grep "Default Sink:" | cut '-d ' -f3)
current_sink=$default_sink
sinks=$(pactl list short sinks | cut -f2)

# for wrap-around
sinks="$sinks
$sinks"

check=0
while [ $check -eq 0 ];
do
    next_sink=$(echo "$sinks" | awk "/$default_sink/{getline x;print x;exit;}")
    name=$next_sink
    if [ "$next_sink" == "alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K3-00.analog-stereo" ]; then
        check=1
        name="Headphones"
        break
    fi
#
#    if [ "$next_sink" == "alsa_output.usb-SteelSeries_Arctis_Pro_Wireless-00.stereo-game" ]; then
#        check=1
#        name="Arctis Headset"
#        break
#    fi

    if [ "$next_sink" == "alsa_output.pci-0000_2f_00.4.analog-stereo" ]; then
        check=1
        name="Speakers"
        break
    fi
    default_sink=$next_sink
done

pactl set-default-sink "$next_sink"
pactl list short sink-inputs | \
 cut -f1 | \
 xargs -I{} pactl move-sink-input {} "$next_sink"

notify-send "$name"
