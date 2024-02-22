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

OUTPUT_PATH="/home/v-zhikangniu/descript-audio-codec/data"  

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
    # tar -xvf $DATA -C $OUTPUT_PATH && rm $DATA
done  
