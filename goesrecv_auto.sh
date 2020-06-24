#!/bin/bash

#logfiles
GR_OUT="goesrecv_output.txt"
LOGFILE="logfile.log"

# redirect output
LOG_LOCATION=./
exec 3>&1 2>&1
exec > >(tee -i -a $LOG_LOCATION/$LOGFILE)

# set traps
trap "exit" INT TERM ERR
trap "kill 0" EXIT

MAX_VIT=350
vit=0 # stores last vit
PID=0 # stores PID of goesrecv

while true; do
	if [ "$vit" -eq 0 ] || [ "$vit" -gt "$MAX_VIT" ]; then
		echo "$(date)"
		# check if goesrecv was running
		if [ $PID != 0 ]; then
			# goesrecv was running
			echo "goesrecv was running. vit out of bounds. VIT: $vit"
			echo "Killing PID: $PID"
			kill $PID
			sleep 2
		else
			echo "goesrecv not running. vit: $vit and PID: $PID"
			echo "Starting..."
		fi
		# (re)start goesrecv
		goesrecv -v -i 1 -c /home/konstantin/goesrecv.conf | tee $GR_OUT 1>&3 2>&1  &
		# delay for start
		sleep 2
		# ~/satellite-scripts/recv_test.sh | tee goesrecv_output.txt &
		PID=$(echo $!)
		echo -en "goesrecv started. PID: $PID\n\n"
	fi

	# delay between vit checks
	sleep 2
	# get lastest vit
	vit=$(tail $GR_OUT -n 1 | sed -n "s/^.*vit(avg):\s*\([[:digit:]]*\).*$/\1/p")
	# keep only last 900 lines (15min) of goesrecv_output.txt
	# tail -n 900 $GR_OUT | sponge goesrecv_output.txt
done
