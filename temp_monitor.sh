#!/bin/bash

#logfiles
DATA_OUT="volt-temp.log"
GR_OUT="goesrecv_output.txt"

while true;
do
	# get latest vit
	vit=$(tail $GR_OUT -n 1 | sed -n "s/^.*vit(avg):\s*\([[:digit:]]*\).*$/\1/p")
	# write data to file
	echo "date=$(date +"%D") time=$(date +"%T") $(vcgencmd get_throttled) $(vcgencmd measure_volts) $(vcgencmd measure_temp) vit=$vit" >> $DATA_OUT
	# sleep
	sleep 60
done
