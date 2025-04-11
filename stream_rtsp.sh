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
       -c:v libx264 -preset ultrafast -tune zerolatency \
       -pix_fmt yuv420p \
       -f rtsp rtsp://localhost:8554/cam_stream

# Add the following to limit the bitrate
       # -b:v 400k -maxrate 400k -bufsize 400k \
