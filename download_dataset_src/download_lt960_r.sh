#!/bin/bash   
  
DATA_NAMES=(  
    train_clean_100.tar.gz
    train_clean_360.tar.gz
    train_other_500.tar.gz
    dev_clean.tar.gz
    dev_other.tar.gz
    test_clean.tar.gz
    test_other.tar.gz
)
PREFIX_URL="https://www.openslr.org/resources/141/"

OUTPUT_PATH="/inspire/hdd/ws-f4d69b29-e0a5-44e6-bd92-acf4de9990f0/public-project/public/public_datas/speech"

cd $OUTPUT_PATH

for DATA in ${DATA_NAMES[@]}
do
    URL="${PREFIX_URL}${DATA}"
    echo "Download: $URL"  

    # Download the files using aria2c  
    aria2c -s16 -x16 "$URL" -d "$OUTPUT_PATH"

    # Unpack files  
    tar -xvf $DATA -C $OUTPUT_PATH

    # Delete files
    # tar -xvf $DATA -C $OUTPUT_PATH  && rm $DATA
done
