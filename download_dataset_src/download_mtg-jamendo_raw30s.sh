#!/bin/bash 


PREFIX_URL="https://cdn.freesound.org/mtg-jamendo/raw_30s/audio"
PREFIX_NAME="raw_30s_audio-"
OUTPUT_PATH="/home/v-zhikangniu/wus2_modelblob/users/v-zhikangniu/datas/mtg-jamendo-dataset/"

# mkdir -p $OUTPUT_PATH/{clean_fullband,noise_fullband}

# for NUM in {1..99}
# do
#     formatted_num=$(printf "%02d" $NUM)
#     DATA="$PREFIX_NAME$formatted_num.tar"
    
#     URL="$PREFIX_URL/$DATA"
#     echo "Download: $URL"

#     # DRY RUN: print HTTP response and Content-Length
#     # WITHOUT downloading the files
#     # curl -s -I "$URL" | head -n 2

#     # Actually download the files: UNCOMMENT when ready to download
#     # curl "$URL" -o "$OUTPUT_PATH/$BLOB"

#     # Same as above, but using wget
#     # wget "$URL" -O "$OUTPUT_PATH/$BLOB"

#     # Same, + unpack files on the fly
#     # curl "$URL" | tar -C "$OUTPUT_PATH" -f - -x -j
#     aria2c -s16 -x16 "$URL" -d "$OUTPUT_PATH"
# done

cd "$OUTPUT_PATH" && ls

for file in ${PREFIX_NAME}*.tar;
do 
    echo "Extracting $file..."  
    tar -xf "$file"  
    echo "Deleting $file..."  
    rm "$file"  
done  