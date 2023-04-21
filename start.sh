#!/bin/bash -ex

# Set your YouTube stream key
STREAM_KEY=#!/bin/bash

# Set your YouTube stream key
STREAM_KEY="zdm7-r9ek-287c-1zmf-9f94"

# Set the display number for Xvfb
DISPLAY_NUM=":1"

# Start Xvfb in the background
Xvfb $DISPLAY_NUM -screen 0 1280x720x24 &

# Set the DISPLAY environment variable to use Xvfb
export DISPLAY=$DISPLAY_NUM

# Start cool-retro-term in the background
cool-retro-term &

# Wait for a few seconds to ensure cool-retro-term is running
sleep 5

# Start streaming the Xvfb buffer to YouTube using ffmpeg
ffmpeg -f x11grab -s 1280x720  \
  -r 30 -i $DISPLAY_NUM -c:v libx264 -preset veryfast -b:v 2500k -maxrate 2500k \
  -bufsize 5000k -vf "format=yuv420p" -g 50 -f flv \
  "rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY"

# Clean up background processes when the script exits
trap "killall cool-retro-term; killall Xvfb" EXIT

# Set the display number for Xvfb
DISPLAY_NUM=":1"

# Start Xvfb in the background
Xvfb $DISPLAY_NUM -screen 0 1280x720x24 &

# Set the DISPLAY environment variable to use Xvfb
export DISPLAY=$DISPLAY_NUM

# Start cool-retro-term in the background
cool-retro-term &

# Wait for a few seconds to ensure cool-retro-term is running
sleep 5

# Start streaming the Xvfb buffer to YouTube using ffmpeg
ffmpeg -f x11grab -s 1280x720 -r 30 -i $DISPLAY_NUM -c:v libx264 -preset veryfast -b:v 2500k -maxrate 2500k -bufsize 5000k -vf "format=yuv420p" -g 50 -f flv "rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY"

# Clean up background processes when the script exits
trap "killall cool-retro-term; killall Xvfb" EXIT
