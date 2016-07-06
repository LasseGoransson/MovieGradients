COLOR=$(convert $1 -scale 1x1\! txt:-|egrep -o '#\w+')
convert -size 10x$2 canvas:"$COLOR" gradients/$(basename $1)
exit 0
