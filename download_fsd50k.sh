#!/bin/bash 

# more info -> https://zenodo.org/record/4060432

FSD50K_NAMES=(
    FSD50K.dev_audio.z01
    FSD50K.dev_audio.z02
    FSD50K.dev_audio.z03
    FSD50K.dev_audio.z04
    FSD50K.dev_audio.z05
    FSD50K.dev_audio.zip
    FSD50K.doc.zip
    FSD50K.eval_audio.z01
    FSD50K.eval_audio.zip
    FSD50K.ground_truth.zip
    FSD50K.metadata.zip
)
PREFIX_URL="https://zenodo.org/record/4060432/files"

OUTPUT_PATH="/data/v-zhikangniu/FSD50K/"

for DATA in ${FSD50K_NAMES[@]}
do
    URL="$PREFIX_URL/$DATA?download=1"
    echo "Download: $URL"

    aria2c -s16 -x16 "$URL" -d "$OUTPUT_PATH"
done

cd "$OUTPUT_PATH"
zip -s 0 FSD50K.dev_audio.zip --out unsplit.zip
zip -s 0 FSD50K.eval_audio.zip --out eval_unsplit.zip

unzip unsplit.zip
unzip eval_unsplit.zip
