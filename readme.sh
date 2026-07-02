#!/usr/bin/env sh

# magick input.png -background none -gravity north -splice 0x10 output.png
# magick input.png -background none -gravity west -splice 10x0 output.png
# magick input.png -background none -gravity east -splice 10x0 output.png
# magick input.png -background none -gravity south -splice 0x10 output.png
# magick input.png -bordercolor none -border 100x100 output.png

# magick input.png -gravity north -chop 0x10 output.png
# magick input.png -gravity west -chop 10x0 output.png
# magick input.png -gravity east -chop 10x0 output.png
# magick input.png -gravity south -chop 0x10 output.png
# magick input.png -shave 100x100 output.png
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
