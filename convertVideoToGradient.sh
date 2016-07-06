FILETYPE=png

# Generate the indevidual frames from the video file in png format
ffmpeg  -i $1  -vf fps=$2 output/out%d06.$FILETYPE

# how many frames did we end up creating
COUNT=$(ls -l output/ | egrep -c '^-')
# the final image will be in more or less 2:1 format
HEIGHT=$(expr $COUNT / 2 )
HEIGHT=$(expr $HEIGHT \* 10)

echo "Making images with 10x$HEIGHT dimensions"
# Harvest the avg color from the indevidual frames - This takes a relativly long time - speed up?
ls output/* | parallel -j 50 ./createGradient.sh {} $HEIGHT

# Create the final image
convert +append  gradients/out*.$FILETYPE output.$FILETYPE
convert -blur 0x1 output.$FILETYPE output.$FILETYPE

#clean up
rm output/*
rm gradients/*
