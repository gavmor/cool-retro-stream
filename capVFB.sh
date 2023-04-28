#!/bin/bash -ex
source stream.config

# Define screenshot filename using current timestamp
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
SCREENSHOT="$LOG_DIR/screen_$TIMESTAMP"

# Take screenshot using xwd and convert to PNG format using ImageMagick
import -display "$DISPLAY_NUM" -window root "$SCREENSHOT.png"

# Open screenshot using the default image viewer
xdg-open "$SCREENSHOT.png" &