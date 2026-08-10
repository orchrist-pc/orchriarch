#!/bin/bash
PIDFILE="$HOME/myloop.pid"

case "$1" in
    -b | --start)
        if [ -f "$PIDFILE" ]; then
            kill -0 "$(cat $PIDFILE)" 2>/dev/null && { notify-send "Already running (PID $(cat $PIDFILE))"; exit 1; }
        fi

        # Start the loop
        while true; do
            xdotool type "7"
            sleep .5
        done &

        echo $! > "$PIDFILE"
        notify-send "Started loop with PID $!"
        ;;
    -e | --stop)
        if [ -f "$PIDFILE" ]; then
            kill "$(cat $PIDFILE)"
            rm -f "$PIDFILE"
            notify-send "Stopped Loop"
        else
            echo "No loop running"
        fi
        ;;
    *)
        echo "WRONG CHOICE BITCH"
        exit 1
esac
