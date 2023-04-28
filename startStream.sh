#!/bin/bash -ex

source "${BASH_SOURCE%/*}/stream.config"

function cleanup {
    echo "Cleaning up..."
    pkill ffmpeg
    pkill cool-retro-term
    pkill Xvfb
}

trap cleanup EXIT

Xvfb $DISPLAY_NUM -screen 0 640x480x24 -nolisten tcp -auth /dev/null &
DISPLAY=$DISPLAY_NUM cool-retro-term --fullscreen -e btop -t &

ffmpeg \
  -f lavfi -i anullsrc -c:a pcm_u8 \
  -f x11grab -video_size 640x480 -draw_mouse 0 -i "$DISPLAY_NUM"+0,0 \
  -framerate 20 -b:v 1500k -maxrate 1500k -bufsize 1500k \
  -c:v libx264 -preset veryslow \
  -f flv "rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY"
