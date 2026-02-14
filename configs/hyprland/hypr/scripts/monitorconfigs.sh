#!/bin/bash

## all, top, bot, dual ; up, right, down, left
SOURCE='$HOME/.config/hypr/config'
HYPRCONF='/home/orchrist/.config/hypr/hyprland.conf'

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
    -f | --fold)
        hyprctl output create auto sunshine
        sleep 2
        pactl set-default-sink "alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K3-00.analog-stereo"
        sleep 2
        sed -i -r "s|/monitors/.*\.conf|/monitors/fold.conf|1" $HYPRCONF
        sed -i -r "s|/workspaces/.*\.conf|/workspaces/default.conf|1" $HYPRCONF
        ;;
    -s | --steamdeck)
        hyprctl output create auto sunshine
        sleep 2
        pactl set-default-sink "alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K3-00.analog-stereo"
        sleep 2
        sed -i -r "s|/monitors/.*\.conf|/monitors/steamdeck.conf|1" $HYPRCONF
        sed -i -r "s|/workspaces/.*\.conf|/workspaces/default.conf|1" $HYPRCONF
        ;;
    -r | --return)
        sed -i -r "s|/monitors/.*\.conf|/monitors/all.conf|1" $HYPRCONF
        sed -i -r "s|/workspaces/.*\.conf|/workspaces/all.conf|1" $HYPRCONF
        sleep 3
        hyprctl output remove sunshine
        sleep 2
        ;;
    *)
        echo "WRONG CHOICE BITCH"
        exit 1
esac

hyprctl reload
dms restart
hyprctl dispatch workspace e-1
