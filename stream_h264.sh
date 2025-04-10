#!/usr/bin/env bash

# list the device using 
## v4l2-ctl --list-devices
## v4l2-ctl --list-formats-ext
## ffmpeg -f v4l2 -list_formats all -i /dev/video0

# Basic command
ffmpeg -f v4l2 -input_format mjpeg \
       -framerate "$3" \
       -video_size "$2" \
       -i "$1" \
       -r 10 \
       -vcodec libx264 -preset ultrafast -tune zerolatency \
       -pix_fmt yuv420p \
       -fflags nobuffer -flags low_delay -fflags +genpts \
       -metadata title="H264 stream" \
       -f rtp rtp://localhost:1338 \
       -sdp_file stream.sdp
