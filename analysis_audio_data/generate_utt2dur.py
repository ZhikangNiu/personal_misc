#!/usr/bin/env python3
import soundfile as sf
import argparse
import concurrent.futures
import os

def get_duration(file_path):
    try:
        info = sf.info(file_path)
        return info.duration
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return None

def generate_utt2dur(wav_scp_file, output_file):
    utterances = []

    with open(wav_scp_file, 'r') as f:
        lines = f.readlines()
    
    # 使用线程池并行处理每个音频文件
    with concurrent.futures.ThreadPoolExecutor() as executor:
        future_to_file = {
            executor.submit(get_duration, line.strip().split(maxsplit=1)[1]): line.strip().split(maxsplit=1)[0]
            for line in lines if line.strip()
        }
        for future in concurrent.futures.as_completed(future_to_file):
            utterance_id = future_to_file[future]
            duration = future.result()
            if duration is not None:
                utterances.append((utterance_id, duration))
    
    # 按持续时间从小到大排序
    utterances.sort(key=lambda x: x[1])
    
    # 写入 output_file
    with open(output_file, 'w') as f:
        for utterance_id, duration in utterances:
            f.write(f"{utterance_id} {duration:.2f}\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate utt2dur file from wav.scp, sorted by duration.")
    parser.add_argument("wav_scp", type=str, help="Path to wav.scp file.")
    parser.add_argument("output_file", type=str, help="Path to output utt2dur file.")
    args = parser.parse_args()
    
    generate_utt2dur(args.wav_scp, args.output_file)
    print(f"utt2dur file has been generated and sorted by duration at {args.output_file}")
