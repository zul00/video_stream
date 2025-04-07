ffplay -vf "drawtext=text='%{pts}':fontsize=24:fontcolor=white:x=10:y=10" \
       -fflags nobuffer -flags low_delay -framedrop -sync ext \
       -protocol_whitelist "file,udp,rtp" stream.sdp
