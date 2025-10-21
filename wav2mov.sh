#!/usr/bin/env bash
if [ -z "$1" ]; then
    echo "Usage: ./wav2mov.sh filename.wav"
    exit 1
fi

file="$1"

if [ ! -f "$file" ]; then
    echo "File not found: $file"
    exit 1
fi

base="${file%.wav}"
echo "Processing: $base.mov"

ffmpeg -f lavfi -i color=c=black:s=1280x720:r=30 \
       -i "$file" \
       -shortest \
       -c:v libx264 -tune stillimage -pix_fmt yuv420p \
       -c:a pcm_s16le \
       "${base}.mov"

echo "Done: $base.mov"
