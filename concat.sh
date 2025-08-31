#!/bin/bash

# Create a temporary file to store the list of videos
temp_file="video_list.txt"

# Remove the temporary file if it already exists
[ -f "$temp_file" ] && rm "$temp_file"

# List all video files with common extensions (case-insensitive) and add them to the temporary file
echo "Listing video files in the current directory..."

# Define video extensions (case-insensitive)
video_extensions="mp4 mkv avi mov wmv flv"

# Loop through all files in current directory
for file in *; do
    # Check if it's a regular file
    if [ -f "$file" ]; then
        # Get the file extension (convert to lowercase for comparison)
        ext="${file##*.}"
        ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
        
        # Check if extension matches any video extension
        for ve in $video_extensions; do
            if [ "$ext_lower" = "$ve" ]; then
                echo "file '$file'" >> "$temp_file"
                echo "Found: $file"
                break  # No need to check other extensions
            fi
        done
    fi
done


# Check if any video files were found
if [ ! -f "$temp_file" ] || [ ! -s "$temp_file" ]; then
    echo "No video files found in the current directory."
    rm -f "$temp_file"
    exit 1
fi

# Concatenate videos using FFmpeg
output_file="concatenated_output.mp4"
echo "Concatenating videos into $output_file..."
ffmpeg -f concat -safe 0 -i "$temp_file" -c copy "$output_file"

# Check if FFmpeg command was successful
if [ $? -eq 0 ]; then
    echo "Videos successfully concatenated into $output_file"
else
    echo "Error occurred during concatenation."
    rm -f "$temp_file"
    exit 1
fi

# Clean up the temporary file
rm -f "$temp_file"

echo "Done!"