#!/bin/bash -ex

source "${BASH_SOURCE%/*}/stream.config"
source "${BASH_SOURCE%/*}/lib.bash"

function cleanup {
    echo "Cleaning up..."
    pkill ffmpeg
    pkill cool-retro-term
    pkill Xvfb
}

trap cleanup EXIT

stream_command $DISPLAY_NUM $STREAM_KEY cool-retro-term -e watch fortune