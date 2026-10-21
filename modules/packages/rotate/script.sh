#!/usr/bin/env bash

input="$1"
angle="${2:-90}"

echo "$input"
echo "$angle"

case "$angle" in
    90) filter="transpose=1" ;;
    180) filter="transpose=1,transpose=1" ;;
    270) filter="transpose=2" ;;
    h) filter="hflip" ;;
    v) filter="vflip" ;;
    *) echo "Usage: rotate-img <input> [90|180|270|h|v]"; exit 1 ;;
esac

ffmpeg -i "$input" -vf "$filter" "$input" -y
