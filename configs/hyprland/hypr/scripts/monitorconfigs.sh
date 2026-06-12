#!/bin/bash

## all, top, bot, dual ; up, right, down, left
SOURCE=$HOME'/.config/hypr/config'
HYPRCONF=$HOME'/.config/hypr/hyprland.conf'

case "$1" in
    -b | --bottom)
        sed -i -r "s|/monitors/.*\.conf|/monitors/bottom_only.conf|1" $HYPRCONF
        sed -i -r "s|/workspaces/.*\.conf|/workspaces/default.conf|1" $HYPRCONF
        ;;
    -t | --top)
        sed -i -r "s|/monitors/.*\.conf|/monitors/top_only.conf|1" $HYPRCONF
        sed -i -r "s|/workspaces/.*\.conf|/workspaces/default.conf|1" $HYPRCONF
        ;;
    -d | --double)
        sed -i -r "s|/monitors/.*\.conf|/monitors/top_and_bot.conf|1" $HYPRCONF
        sed -i -r "s|/workspaces/.*\.conf|/workspaces/top_and_bot.conf|1" $HYPRCONF
        ;;
    -a | --all)
        sed -i -r "s|/monitors/.*\.conf|/monitors/all.conf|1" $HYPRCONF
        sed -i -r "s|/workspaces/.*\.conf|/workspaces/all.conf|1" $HYPRCONF
        ;;
    -s | --sunshine)
        RES=$2
        if [[ $RES == "1856x2160@60" ]]; then
            RES='1392x1620@60'
        fi
        if [[ $RES == "2160x1856@60" ]]; then
            RES='1620x1392@60'
        fi
        pactl set-default-sink "alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K3-00.analog-stereo"
        sleep 2
        cp -f $SOURCE/monitors/disable.conf $SOURCE/monitors/sunshine.conf
        sed -i -r "s|sunshine,disable|sunshine,$RES,auto,1,vrr,0|1" $SOURCE/monitors/sunshine.conf
        sed -i -r "s|/monitors/.*\.conf|/monitors/sunshine.conf|1" $HYPRCONF
        sed -i -r "s|/workspaces/.*\.conf|/workspaces/default.conf|1" $HYPRCONF
        hyprctl dispatch workspace 10
        ;;
    -r | --return)
        sed -i -r "s|/monitors/.*\.conf|/monitors/all.conf|1" $HYPRCONF
        sed -i -r "s|/workspaces/.*\.conf|/workspaces/all.conf|1" $HYPRCONF
        rm -rf $SOURCE/monitors/sunshine.conf
        hyprctl dispatch workspace e-1
        sleep 5
        ;;

# EXAMPLE FROM OLD SETUP
#    -f | --fold)
#        hyprctl output create auto sunshine
#        sleep 2
#        pactl set-default-sink "alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K3-00.analog-stereo"
#        sleep 2
#        sed -i -r "s|/monitors/.*\.conf|/monitors/fold.conf|1" $HYPRCONF
#        sed -i -r "s|/workspaces/.*\.conf|/workspaces/default.conf|1" $HYPRCONF
#        ;;

    *)
        echo "WRONG CHOICE BITCH"
        exit 1
esac

hyprctl reload
dms restart
