# `$ stream_command`

The `stream_command` Bash function is designed to create a virtual X display, run a command, and stream the output to YouTube. 

## Usage

The function can be used by calling it with the required arguments:

```bash
stream_command $DISPLAY_NUM $STREAM_KEY $COMMAND $OTHER_ARGS
```

- `$DISPLAY_NUM`: the number of the virtual X display to create
- `$STREAM_KEY`: the key used to stream the output to YouTube
- `$COMMAND`: the command to run
- `$OTHER_ARGS`: additional arguments to be passed to the command

For example, to stream a `cool-retro-term` window running `tmux` with arguments `a`, you would run:

```bash
stream_command $DISPLAY_NUM $STREAM_KEY cool-retro-term -e tmux a
```

## Details

The `stream_command` function uses `Xvfb` to start a virtual X server on the specified display, with a resolution of 640x480 and 16-bit color depth. It also disables listening on the TCP port and sets authentication to `/dev/null`.

It then runs the specified command on the virtual X display, and uses `ffmpeg` to stream the output to YouTube. The `ffmpeg` command generates silent audio using the `anullsrc` filter, as audio is necessary to satisfy YouTube's streaming requirements.

The video encoding is performed using the `libx264` codec, with a target bitrate of 1500k and a maximum bitrate and buffer size of 1500k. The video is captured from the virtual X display using `x11grab`, with a framerate of 20 frames per second and a pixel format of `yuv420p`, which allows for more efficient video compression. 

Finally, the output is streamed to the YouTube RTMP server using the specified stream key.

## Dependencies
The `stream_command` Bash function has several dependencies that must be installed on the system in order for it to work properly. These dependencies include:

- `Xvfb`: a virtual X server that allows running X applications without a physical display.
- `ffmpeg`: a powerful tool for manipulating audio and video files.

In addition, the system must have a stable internet connection to be able to stream the output to YouTube.
