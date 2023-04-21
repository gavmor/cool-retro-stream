#!/bin/bash

# Load configuration variables from config file
source stream.config

# Start Xvfb in the background
Xvfb $DISPLAY_NUM -screen 0 1280x720x24 &

# Set the DISPLAY environment variable to use Xvfb
export DISPLAY=$DISPLAY_NUM

# Start cool-retro-term in the background
cool-retro-term &

# Wait for a few seconds to ensure cool-retro-term is running
sleep 5

# Get the current timestamp for the log file name
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)

# Start streaming the Xvfb buffer to YouTube using ffmpeg and log diagnostics
ffmpeg -f x11grab \
	-s 1280x720 \
	-r 30 \
	-i $DISPLAY_NUM \
	-c:v libx264 \
	-preset veryfast \
	-b:v 2500k \
	-maxrate 2500k \
	-bufsize 5000k \
	-vf "format=yuv420p" \
	-g 50 \
	-f flv "rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY" \
	-loglevel debug 2>&1 | tee "${LOG_DIR}/${TIMESTAMP}_${LOG_FILE}"

# Clean up background processes when the script exits
trap "killall cool-retro-term; killall Xvfb" EXIT
