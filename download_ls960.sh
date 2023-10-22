#!/bin/bash 


DATA_NAMES=(
    train-clean-100.tar.gz
    train-clean-360.tar.gz
    train-other-500.tar.gz
    dev-clean.tar.gz
    dev-other.tar.gz
    test-clean.tar.gz
    test-other.tar.gz
    )
PREFIX_URL="https://www.openslr.org/resources/12/"

OUTPUT_PATH="/scratch/v-zhikangniu/"

cd $OUTPUT_PATH
# mkdir -p $OUTPUT_PATH/{clean_fullband,noise_fullband}

for DATA in ${DATA_NAMES[@]}
do
    URL="$PREFIX_URL/$DATA"
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
    
    tar --use-compress-program="pigz" -xvpf $DATA
done
