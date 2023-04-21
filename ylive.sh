#!/bin/bash

# 交互式输入 YouTube 视频链接
read -p "请输入 YouTube 视频链接: " video_url

# 交互式输入 RTMP 服务器地址
read -p "请输入 RTMP 服务器地址: " rtmp_url

# 交互式输入流名称
read -p "请输入流名称: " stream_name

# 交互式选择是否启用 screen 会话
read -p "是否启用 screen 会话? (y/n) " use_screen

if [[ "$use_screen" == "y" ]]; then
  # 交互式输入 screen 会话名称
  read -p "请输入 screen 会话名称: " session_name
  # 创建 screen 会话并执行命令
  screen -dmS $session_name bash -c "streamlink --http-header 'User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3' -O $video_url best | ffmpeg -re -i pipe:0 -c:v libx264 -preset veryfast -tune zerolatency -b:v 5000k -maxrate 5500k -bufsize 6000k -pix_fmt yuv420p -g 60 -c:a aac -b:a 160k -ac 2 -ar 44100 -f flv $rtmp_url/$stream_name -strict -2"
else
  # 直接执行命令
  streamlink --http-header "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" -O $video_url best | ffmpeg -re -i pipe:0 -c:v libx264 -preset veryfast -tune zerolatency -b:v 5000k -maxrate 5500k -bufsize 6000k -pix_fmt yuv420p -g 60 -c:a aac -b:a 160k -ac 2 -ar 44100 -f flv $rtmp_url/$stream_name -strict -2
fi
