#!/bin/bash
# WEBM SETTINGS
videocodecwebm='libvpx'
audiocodecwebm='libvorbis'
# OGV SETTINGS
videocodecogv='libtheora'
audiocodecogv='libvorbis'
# MP4 SETTINGS
videocodecmp4='libx264'
audiocodecmp4='copy'
outfolder='out'
maxrate='700k'
minrate='200k'
bitrate='200k'

mkdir $outfolder;

/bin/ls *.mp4 | while read video 
	do
	filename=$(basename "$video")
	filename="${filename%.*}"
	echo "Transcoding $video";  
	echo /opt/local/bin/ffmpeg -y -i \"$video\" -c:v $videocodecwebm -minrate $minrate -maxrate $maxrate -b:v $bitrate -c:a $audiocodecwebm $outfolder/\"$filename\"_fast.webm |/bin/bash 
	echo /opt/local/bin/ffmpeg -y -i \"$video\" -c:v $videocodecmp4 -preset fast -c:a $audiocodecmp4 $outfolder/\"$filename\"_fast.mp4 |/bin/bash 
	echo /opt/local/bin/ffmpeg -y -i \"$video\" -c:v $videocodecogv -qscale:v 6 -c:a $audiocodecogv -qscale:a 6 $outfolder/\"$filename\"_fast.ogv |/bin/bash 
done
