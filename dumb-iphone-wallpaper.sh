#!/bin/bash

# Check for ImageMagick installation
if ! command -v magick &> /dev/null; then
    echo "Warning: ImageMagick is not installed. Please install it to run this script."
    echo "Please refer to the system requirements here: https://github.com/marosige/dumb-iphone-wallpaper?tab=readme-ov-file#system-requirements"
    exit 1
fi

# Rest of your script follows...
# Default parameters
bg_color="#242424"   # Default background color
text_color="white"   # Default text color
output_file="$HOME/Downloads/dumb_iphone_wallpaper.png"

# iPhone 12 mini display resolution
width=1080
height=2340

# Font settings
font="Arial"
font_size=140
row_height=260

# Default empty text for each row
row1_text=""
row2_text=""
row3_text=""
row4_text=""
row5_text=""
row6_text=""

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -bg|--background-color) bg_color="$2"; shift ;;
        -tc|--text-color) text_color="$2"; shift ;;
        -l1|--line1) row1_text="$2"; shift ;;
        -l2|--line2) row2_text="$2"; shift ;;
        -l3|--line3) row3_text="$2"; shift ;;
        -l4|--line4) row4_text="$2"; shift ;;
        -l5|--line5) row5_text="$2"; shift ;;
        -l6|--line6) row6_text="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Define the starting positions for the text (starting from the second icon position)
start_x=350   # X position (shifted from the left to align with the icons)
start_y=350   # Y position for the first row

# Create the background
magick -size ${width}x${height} xc:$bg_color $output_file

# Add text to the image if it's not an empty string
[[ -n "$row1_text" ]] && magick $output_file -font $font -pointsize $font_size -fill $text_color -annotate +${start_x}+${start_y} "$row1_text" $output_file
[[ -n "$row2_text" ]] && magick $output_file -font $font -pointsize $font_size -fill $text_color -annotate +${start_x}+$(($start_y + $row_height)) "$row2_text" $output_file
[[ -n "$row3_text" ]] && magick $output_file -font $font -pointsize $font_size -fill $text_color -annotate +${start_x}+$(($start_y + 2 * $row_height)) "$row3_text" $output_file
[[ -n "$row4_text" ]] && magick $output_file -font $font -pointsize $font_size -fill $text_color -annotate +${start_x}+$(($start_y + 3 * $row_height)) "$row4_text" $output_file
[[ -n "$row5_text" ]] && magick $output_file -font $font -pointsize $font_size -fill $text_color -annotate +${start_x}+$(($start_y + 4 * $row_height)) "$row5_text" $output_file
[[ -n "$row6_text" ]] && magick $output_file -font $font -pointsize $font_size -fill $text_color -annotate +${start_x}+$(($start_y + 5 * $row_height)) "$row6_text" $output_file

# Notify the user
echo "Wallpaper created: $output_file"
