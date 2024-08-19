#!/usr/bin/env python3
import soundfile as sf
import pandas as pd
import argparse
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

def get_audio_info(file_path):
    try:
        info = sf.info(file_path)
        return {
            'file_path': file_path,
            'samplerate': info.samplerate,
            'channels': info.channels,
            'duration': info.duration
        }
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return None

def process_wav_scp(wav_scp_file, output_path, max_workers=4):
    audio_files = []
    with open(wav_scp_file, 'r') as f:
        lines = f.readlines()
    
    for line in lines:
        if line.strip():  # 忽略空行
            _, file_path = line.strip().split(maxsplit=1)
            audio_files.append(file_path)
    
    # 使用多线程处理音频文件
    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        results = list(executor.map(get_audio_info, audio_files))
    
    # 过滤掉 None 值
    results = [r for r in results if r is not None]
    
    # 转换为 DataFrame 并写入 CSV 文件
    df = pd.DataFrame(results)
    output_file = Path(output_path) / "metainfo.csv"
    df.to_csv(output_file, sep='\t', index=False, columns=['file_path', 'samplerate', 'channels', 'duration'])

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate metainfo.csv file from wav.scp with audio metadata.")
    parser.add_argument("wav_scp", type=str, help="Path to wav.scp file.")
    parser.add_argument("output_path", type=str, help="Path to output metainfo.csv file.")
    parser.add_argument("--max-workers", type=int, default=4, help="Number of threads to use for processing.")
    args = parser.parse_args()
    
    process_wav_scp(args.wav_scp, args.output_path, args.max_workers)
    print(f"metainfo.csv file has been generated at {args.output_path}/metainfo.csv")
