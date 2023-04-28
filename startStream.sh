#!/bin/bash -ex

source "${BASH_SOURCE%/*}/stream.config"

function cleanup {
    echo "Cleaning up..."
    pkill Xvfb cool-retro-term ffmpeg
}

trap cleanup EXIT

# Start Xvfb in the background
Xvfb $DISPLAY_NUM -screen 0 640x480x24 -nolisten tcp -auth /dev/null &
export DISPLAY=$DISPLAY_NUM

# Start cool-retro-term in the background and wait for it to start
cool-retro-term --fullscreen -e btop -t &
sleep 5

ffmpeg -f lavfi -i anullsrc -c:a pcm_u8 \
    -f x11grab \
    -video_size 640x480 -show_region 1 -i "$DISPLAY"+0,0 -draw_mouse 0 \
    -framerate 30 -b:v 1500k -maxrate 1500k -bufsize 1500k \
    -c:v libx264 -preset veryslow -f flv \
    "rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY"
    # ./logs/output.mp4
    # -vf "format=yuv420p" -g 50 \