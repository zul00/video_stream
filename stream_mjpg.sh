#!/usr/bin/env bash

ffmpeg -f v4l2 -input_format mjpeg \
       -framerate 15 \
       -video_size "$2" \
       -i "$1" \
       -c:v copy \
       -f rtp rtp://localhost:1337 \
       -sdp_file mjpeg.sdp
