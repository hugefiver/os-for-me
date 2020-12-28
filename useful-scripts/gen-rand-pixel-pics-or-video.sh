# need `ffmpeg` and `imagemagick` as deps

# how to generate a picture with random pixels
# convert -depth 8 -size 1920x1080 "rgb:"<(cat /dev/urandom | head -c $(( 3*1080*1920 )) ) out.png

# video
SECS=60
FPS=24
# use `ffmpeg -codecs -hide_banner | grep hevc` to find suitable encoder you need
ENCODING=hevc
OUTPUT=./out.mp4
OUTPUT_ARGS=""

# frames
PIC_FMT='pic-%04d.png'
PIC_OUTPUT_PATH=./pic
PIC_WIDTH=1920
PIC_HEIGHT=1080

mkdir -p $PIC_OUTPUT_PATH

# generate pictures
for i in $( seq 1 $(( $SECS * $FPS )) )
do
    filename=$(printf $PIC_FMT $i)
    echo "Generating $filename"
    if [ ! -f $PIC_OUTPUT_PATH/$filename ]; then
            convert -depth 8 -size ${PIC_WIDTH}x${PIC_HEIGHT} "rgb:"<( cat /dev/urandom | head -c $(( 3 * $PIC_HEIGHT * $PIC_WIDTH )) ) \
            $PIC_OUTPUT_PATH/$filename
    fi
done


# generate video
echo -e "\nGenerating video..."
ffmpeg -i $PIC_OUTPUT_PATH/$PIC_FMT '-c:v' $ENCODING -r $FPS -an -y $OUTPUT_ARGS $OUTPUT
echo -e "\nAll completed. See $OUTPUT."
