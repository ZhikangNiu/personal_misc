#!/bin/bash 

# more info -> https://zenodo.org/record/4060432

DATA_NAMES=(musdb18.zip)
PREFIX_URL="https://zenodo.org/records/1117372/files/"

OUTPUT_PATH="/data/v-zhikangniu/MUSDB18/"

# mkdir -p $OUTPUT_PATH/{clean_fullband,noise_fullband}

for DATA in ${DATA_NAMES[@]}
do
    URL="$PREFIX_URL/$DATA?download=1"
    echo "Download: $URL"

    # DRY RUN: print HTTP response and Content-Length
    # WITHOUT downloading the files
    # curl -s -I "$URL" | head -n 2

    # Actually download the files: UNCOMMENT when ready to download
    # curl "$URL" -o "$OUTPUT_PATH/$BLOB"

    # Same as above, but using wget
    # wget "$URL" -O "$OUTPUT_PATH/$BLOB"

    # Same, + unpack files on the fly
    # curl "$URL" | tar -C "$OUTPUT_PATH" -f - -x -j
    aria2c -s16 -x16 "$URL" -d "$OUTPUT_PATH"
done

cd "$OUTPUT_PATH"

unzip musdb18.zip