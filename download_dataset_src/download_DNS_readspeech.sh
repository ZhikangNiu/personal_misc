#!/usr/bin/bash

# ***** 5th DNS Challenge at ICASSP 2023*****
# Track 2 Speakerphone Clean speech: All Languages
# -------------------------------------------------------------
# In all, you will need about 1TB to store the UNPACKED data.
# Archived, the same data takes about 550GB total.

# Please comment out the files you don't need before launching
# the script.

# NOTE: By default, the script *DOES NOT* DOWNLOAD ANY FILES!
# Please scroll down and edit this script to pick the
# downloading method that works best for you.

# -------------------------------------------------------------
# The directory structure of the unpacked data is:

# datasets_fullband 
# \-- clean_fullband 827G
#     +-- emotional_speech 2.4G
#     +-- french_speech 62G
#     +-- german_speech 319G
#     +-- italian_speech 42G
#     +-- read_speech 299G
#     +-- russian_speech 12G
#     +-- spanish_speech 65G
#     +-- vctk_wav48_silence_trimmed 27G
#     \-- VocalSet_48kHz_mono 974M

BLOB_NAMES=(
    clean_fullband/datasets_fullband.clean_fullband.read_speech_000_0.00_3.75.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_001_3.75_3.88.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_002_3.88_3.96.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_003_3.96_4.02.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_004_4.02_4.06.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_005_4.06_4.10.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_006_4.10_4.13.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_007_4.13_4.16.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_008_4.16_4.19.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_009_4.19_4.21.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_010_4.21_4.24.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_011_4.24_4.26.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_012_4.26_4.29.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_013_4.29_4.31.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_014_4.31_4.33.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_015_4.33_4.35.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_016_4.35_4.38.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_017_4.38_4.40.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_018_4.40_4.42.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_019_4.42_4.45.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_020_4.45_4.48.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_021_4.48_4.52.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_022_4.52_4.57.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_023_4.57_4.67.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_024_4.67_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_025_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_026_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_027_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_028_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_029_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_030_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_031_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_032_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_033_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_034_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_035_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_036_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_037_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_038_NA_NA.tar.bz2
    clean_fullband/datasets_fullband.clean_fullband.read_speech_039_NA_NA.tar.bz2
)

###############################################################
# this data is identical to non-personalized track 4th DNS Challenge clean speech
# recommend to re-download the data using this script

AZURE_URL="https://dns4public.blob.core.windows.net/dns4archive/datasets_fullband"

OUTPUT_PATH="/data/v-zhikangniu/DNS_readspeech/"

mkdir -p $OUTPUT_PATH/{clean_fullband,noise_fullband}

for BLOB in ${BLOB_NAMES[@]}
do
    URL="$AZURE_URL/$BLOB"
    echo "Download: $BLOB"

    # DRY RUN: print HTTP response and Content-Length
    # WITHOUT downloading the files
    # curl -s -I "$URL" | head -n 2

    # Actually download the files: UNCOMMENT when ready to download
    # curl "$URL" -o "$OUTPUT_PATH/$BLOB"

    # Same as above, but using wget
    # wget "$URL" -O "$OUTPUT_PATH/$BLOB"

    # Same, + unpack files on the fly
    # curl "$URL" | tar -C "$OUTPUT_PATH" -f - -x -j
    aria2c -s16 -x16 "$URL" | tar -C "$OUTPUT_PATH" -f - -x -j
done