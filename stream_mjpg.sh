#!/usr/bin/env bash

ffmpeg -f v4l2 -input_format mjpeg \
       -framerate "$3" \
       -video_size "$2" \
       -r 5 \
       -i "$1" \
       -c:v copy \
       -f rtp rtp://localhost:1338 \
       -sdp_file mjpg.sdp
