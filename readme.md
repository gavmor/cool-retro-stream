# startStream.sh

A script to stream the content of `cool-retro-term` to YouTube using `ffmpeg` and `xvfb`.

## Usage

1. Install the required dependencies: `cool-retro-term`, `ffmpeg`, and `xvfb`.
2. Clone this repository or copy the `startStream.sh` and `stream.config` files to your desired location.
3. Edit the `stream.config` file and set your YouTube stream key.
4. Create a `logs` directory in the same location as your `startStream.sh` script.
5. Run the script with `./startStream.sh`.

## Configuration

The configuration variables are stored in the `stream.config` file. You can modify these variables to update the configuration without having to modify the main script directly.

- `STREAM_KEY`: Your YouTube stream key.
- `DISPLAY_NUM`: The display number for Xvfb.
- `LOG_DIR`: The directory where log files will be saved.
- `LOG_FILE`: The log file name (a timestamp will be added to the file name when the script runs).

## Log Files

The script generates a log file with a unique name based on the current date and time. The log file contains detailed diagnostic information related to `rtmp` and is saved in the specified `LOG_DIR`.