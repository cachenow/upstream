#!/bin/bash

# YouTube 直播地址和 RTMP 目标地址
YOUTUBE_URL="YOUTUBE_URL"
RTMP_URL="RTMP_URL"

# Streamlink 和 ffmpeg 命令
STREAMLINK_CMD="streamlink ${YOUTUBE_URL} best -O"
FFMPEG_CMD="ffmpeg -re -i - -c:v libx264 -preset:v ultrafast -tune zerolatency -profile:v baseline -b:v 500k -maxrate 600k -bufsize 800k -g 30 -r 25 -s 1280x720 -c:a aac -b:a 128k -f flv ${RTMP_URL}"

# 启动 Streamlink 和 ffmpeg
while true; do
    ${STREAMLINK_CMD} | ${FFMPEG_CMD}
    echo "FFmpeg has stopped, restarting in 5 seconds..."
    sleep 5
done
