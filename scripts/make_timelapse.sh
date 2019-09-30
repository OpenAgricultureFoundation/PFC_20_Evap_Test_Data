#!/bin/bash
wget -i image_urls.txt
ffmpeg -f image2 -r 15 -pattern_type glob -i '*.png' -threads 8 -vcodec libx264 -pix_fmt yuv420p timelapse.mp4
