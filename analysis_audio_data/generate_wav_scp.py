#!/usr/bin/env python3
from pathlib import Path
import argparse

def generate_wav_scp(audio_dir, output_file, extensions):
    with open(output_file, 'w') as f:
        for path in Path(audio_dir).rglob(f'**/*{extensions}'):
            utterance_id = path.stem
            f.write(f"{utterance_id} {path.resolve()}\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Generate wav.scp file for Kaldi from audio files.")
    parser.add_argument("audio_dir", type=str, 
                        help="Directory containing audio files.")
    parser.add_argument("output_wav_scp", type=str, 
                        help="Output path for wav.scp file.")
    parser.add_argument("--extensions", type=str, nargs='+', default=['.wav'], 
                        help="List of file extensions to include (e.g., .wav .flac).")

    args = parser.parse_args()

    generate_wav_scp(args.audio_dir, args.output_wav_scp, args.extensions)
    print(f"wav.scp file has been generated at {args.output_wav_scp}")
