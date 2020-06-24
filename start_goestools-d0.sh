#!/bin/bash 

# starts goesrecv and goesproc inside a tmux windows
# goesproc-goesr.conf 		<- use for default configuration
# goesproc-goesr-emwin.conf	<- includes enabled EMWIN and Non-CMIP products

tmux new "goesrecv -v -i 1 -c /home/konstantin/goesrecv-d0.conf; sleep 30" ';' \
split "goesproc -c /usr/share/goestools/goesproc-goesr.conf -m packet  --subscribe tcp://127.0.0.1:5004 --out /home/konstantin/GOES_IMAGES; sleep 30"
