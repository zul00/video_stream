#!/usr/bin/env bash

ffplay -vf "drawtext=text='%{pts}':fontsize=60:fontcolor=blue:x=10:y=10" \
       -fflags nobuffer -flags low_delay -framedrop -sync ext \
       -protocol_whitelist "file,udp,rtp" mjpeg.sdp
