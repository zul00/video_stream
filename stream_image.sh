#!/usr/bin/env bash

# list the device using 
## v4l2-ctl --list-devices
## v4l2-ctl --list-formats-ext
## ffmpeg -f v4l2 -list_formats all -i /dev/video0

# Basic
ffmpeg -re -i "$1" \
       -an -c:v libx264 \
       -preset ultrafast -tune zerolatency \
       -s "$2" \
       -g 1 -keyint_min 1 \
       -f rtp rtp://localhost:1337 \
       -sdp_file stream.sdp


# latency 1.2 s
# ffmpeg -re -i "$1" \
#        -an -c:v libx264 \
#        -preset ultrafast -tune zerolatency \
#        -s 800x600 \
#        -pix_fmt yuv420p \
#        -g 1 -keyint_min 1 \
#        -b:v 500k \
#        -bufsize 500k \
#        -max_delay 0 \
#        -f rtp rtp://localhost:1337 \
#        -sdp_file stream.sdp

# 1 second latency
# ffmpeg -re -i "$1" \
#        -an -c:v libx264 \
#        -preset ultrafast -tune zerolatency \
#        -s 1920x1080 -r 15 \
#        -pix_fmt yuv420p \
#        -g 1 -keyint_min 1 \
#        -b:v 500k -bufsize 500k \
#        -max_delay 0 -fflags nobuffer \
#        -flush_packets 1 \
#        -rtbufsize 1M \
#        -strict experimental \
#        -f rtp rtp://localhost:1337 \
#        -sdp_file stream.sdp


# ffmpeg -re -i "$1" \
#        -an -c:v libx264 \
#        -preset ultrafast -tune zerolatency \
#        -s 800x600 \
#        -pix_fmt yuv420p \
#        -g 1 -keyint_min 1 \
#        -b:v 500k \
#        -bufsize 500k \
#        -max_delay 0 \
#        -f mpegts udp://localhost:1337 \
#        -sdp_file stream.sdp
