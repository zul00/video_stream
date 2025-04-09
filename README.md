# Image stream from USB camera

This repo consists of three unicast streaming options through RTP using ffmpeg
tools
- USBcam -> H264
- USBcam -> H244 with VA API
- USBcam -> MJPG

On the receiving side it uses ffplay with *.sdp file being used to define the
session.

# How to Use

1. Select one of streamer script.
   a. `./stream_h264.sh`
   b. `./stream_h264_vaapi.sh`
   c. `./stream_mjpg.sh`
2. Update the target url to IP of the receiving machine, by default I set it to
   `localhost`
3. Connect the USB camera to the streamer machine.
4. List available camera using
```
$ v4l2-ctl --list-devices

Arducam IMX477 HQ Camera: Arduc (usb-0000:00:14.0-4.4.2):
        /dev/video4
        /dev/video5
        /dev/media2
```
5. Check the supported output of the camera, adjust the number `4` with the ID
   of the camera that was found from the previous command.
```
$ v4l2-ctl --list-formats-ext -d 4
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture

        [0]: 'MJPG' (Motion-JPEG, compressed)
                Size: Discrete 1920x1080
                        Interval: Discrete 0.017s (60.000 fps)
                        Interval: Discrete 0.033s (30.000 fps)
                        Interval: Discrete 0.067s (15.000 fps)
...
                Size: Discrete 640x480
                        Interval: Discrete 0.013s (80.000 fps)
                        Interval: Discrete 0.017s (60.000 fps)
                        Interval: Discrete 0.033s (30.000 fps)
                        Interval: Discrete 0.067s (15.000 fps)
```
6. Note the lowest value supported by the camera that we can use, in the
   example above we will try to use 640x480 resolution with 15 FPS.
7. Copy the script into the streaming machine. You can use scp.
```
scp -r ../video_stream upcore01_gl:~
```
8. Run the streamer script on the streamer machine using the configuration
   that we noted before
```
$ ./stream_h264.sh /dev/video4 640x480 15
```
   a. Running the script above will generate an *.sdp file, which can be used
   by the receiver machine to understand about the session.
9. On the receiver machine, copy the *.sdp file from the streamer, and then
   call the play script. You can use the following script which copy the sdp
   file and then call the play script
```
$ scp upcore01_gl:~/video_stream/stream.sdp . | ./play_h264.sh
```

# Debugging
You can also test and run the script locally for testing. Connect a USB camera
to a PC, and keep the url to local host. Then call both script on the same PC.
