#!/usr/bin/env bash

# list the device using 
## v4l2-ctl --list-devices
## v4l2-ctl --list-formats-ext
## ffmpeg -f v4l2 -list_formats all -i /dev/video0

# Basic command
ffmpeg -i "$1" \
       -video_size "$2"  \
       -f v4l2 -input_format mjpeg \
       -vcodec libx264 -preset ultrafast -tune zerolatency \
       -f rtp rtp://localhost:5004 \
       -sdp_file stream.sdp
