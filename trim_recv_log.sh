#!/bin/bash

#logfiles
GR_OUT="goesrecv_output.txt"

echo "$(tail -n 900 $GR_OUT)" > $GR_OUT
