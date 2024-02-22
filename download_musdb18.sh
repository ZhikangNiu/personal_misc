#!/bin/bash 

# more info -> https://zenodo.org/record/4060432

DATA_NAMES=(musdb18.zip)
PREFIX_URL="https://zenodo.org/records/1117372/files/"

OUTPUT_PATH="/data/v-zhikangniu/MUSDB18/"

for DATA in ${DATA_NAMES[@]}
do
    URL="$PREFIX_URL/$DATA?download=1"
    echo "Download: $URL"

    aria2c -s16 -x16 "$URL" -d "$OUTPUT_PATH"
done

cd "$OUTPUT_PATH"

unzip musdb18.zip
