#!/usr/bin/env bash

ffmpeg -f v4l2 -list_formats all -i "$1"
