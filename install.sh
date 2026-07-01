#!/usr/bin/env sh

# magick input.png -gravity center -crop 100x100+0+0 output.png
# magick input.png -gravity center -extent 100x100 output.png
# magick input.png -bordercolor none -border 100x0 output.png
# montage frame/*.png -background none -geometry 100x100^+2+2
# -gravity center -extent 1000x1000 -tile 10x output.png
# magick input.png -resize 100% output.png

INPUT_DIR="input_images"
OUTPUT_DIR="output_mosaics"
mkdir -p "$OUTPUT_DIR"

for img in "$INPUT_DIR"/*.{jpg,png,avif}; do
    [ -e "$img" ] || continue

    filename=$(basename "$img")
    name="${filename%.*}"

    magick "$img" -crop 80x80@ +repage +adjoin miff:- | \
    montage - -background none -geometry +8+8 -tile 80x40 "$OUTPUT_DIR/${name}.png"

    echo "Processed: $filename → ${name}_mosaic.png"
done
