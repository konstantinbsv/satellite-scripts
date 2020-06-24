#!/bin/bash

# command to execute after find, set to "-print" for debug or "-exec rm -r {} +" to remove
# COMMAND = $(echo "-exec rm -r {} +")

# Keep disk space usage under control by removing old directories with images

### GOES 17
# remove channel images from GOES 17
find /home/konstantin/GOES_IMAGES/goes17/fd/ch*/* -type d -atime +10 -exec rm -r {} +

# remove mesoscale images from GOES 17
find /home/konstantin/GOES_IMAGES/goes17/m*/*c*/* -type d -atime +5 -exec rm -r {} +

# remove older non-cmip products
find /home/konstantin/GOES_IMAGES/goes17/non-cmip/fd/*/* -type d -atime +5 -exec rm -r {} +



### GOES16
# remove channel 13 unenchanced images from GOES 16
find /home/konstantin/GOES_IMAGES/goes16/fd/ch13/* -type d -atime +10 -exec rm -r {} +



### EMWIN
# remove older EMWIN directories
find /home/konstantin/GOES_IMAGES/emwin/* -type d -atime +10 -exec rm -r {} +

# remove EMWIN texts and general radar images from all dates
find /home/konstantin/GOES_IMAGES/emwin/* -iname "*IMGWWAUS.PNG" -exec rm -r {} +
find /home/konstantin/GOES_IMAGES/emwin/* -iname "*RAD*" -exec rm -r {} +
find /home/konstantin/GOES_IMAGES/emwin/* -iname "*.txt" -exec rm -r {} +




# remove empty directories
#find /home/konstantin/GOES_IMAGES/* -type d -empty -delete
