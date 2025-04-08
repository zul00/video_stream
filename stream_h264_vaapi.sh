#!/usr/bin/env bash

# list the device using 
## v4l2-ctl --list-devices
## v4l2-ctl --list-formats-ext
## ffmpeg -f v4l2 -list_formats all -i /dev/video0

# Basic command
LIBVA_DRIVER_NAME=i965 \
        ffmpeg -f v4l2 -input_format mjpeg \
       -framerate 15 \
       -video_size "$2" \
       -i "$1" \
       -vaapi_device /dev/dri/renderD128 \
       -vf 'format=nv12,hwupload=extra_hw_frames=64' \
       -c:v h264_vaapi \
       -tune zerolatency -profile:v constrained_baseline \
       -b:v 1M -maxrate 1M -bufsize 2M -g 30 \
       -f rtp rtp://192.168.8.218:1337 \
       -sdp_file stream.sdp
