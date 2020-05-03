#!/bin/bash

pid=0

term_handler() {
	if [ $pid -ne 0 ]; then
		kill -SIGTERM "$pid"
		wait "$pid"
	fi
	exit 143
}

trap 'kill ${!}; term_handler' SIGTERM

python3 /windscribe/windscribe-autologin.py &
pid="$!"
while true
do
	tail -f /dev/null & wait ${!}
done
