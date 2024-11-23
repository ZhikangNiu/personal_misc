#!/bin/bash

# 设置根URL
ROOT_URL="https://storage.googleapis.com/cvss"

# 定义所有语言
LANGUAGES=("de" "fr" "es" "ca" "it" "ru" "zh" "pt" "fa" "et" \
           "mn" "nl" "tr" "ar" "sv" "lv" "sl" "ta" "ja" "id" "cy")

# 定义版本号
VERSION="1.0"

# 定义数据集名称，支持 'cvss_c' 和 'cvss_t'
NAMES=("cvss_c" "cvss_t")

# 下载函数
download_data() {
  local name=$1
  local output_dir=$2
  mkdir -p "$output_dir"  # 创建目标文件夹
  for lang in "${LANGUAGES[@]}"; do
    url="${ROOT_URL}/${name}_v${VERSION}/${name}_${lang}_en_v${VERSION}.tar.gz"
    echo "Downloading: $url to $output_dir"
    aria2c -x 16 -s 16 -d "$output_dir" "$url"
  done
}

# 解压函数
extract_all() {
  local target_dir=$1
  echo "Extracting files in $target_dir"
  find "$target_dir" -type f -name "*.tar.gz" | while read -r file; do
    # 获取文件名（不包含后缀）
    folder_name="${file%.tar.gz}"
    
    # 创建与文件同名的文件夹
    mkdir -p "$folder_name"
    
    # 解压到指定文件夹
    echo "Extracting $file to $folder_name"
    tar -xzvf "$file" -C "$folder_name"
  done
}

# 主逻辑
for name in "${NAMES[@]}"; do
  output_dir="./${name}"  # 定义文件夹名称为数据集名称
  echo "Starting download for $name into folder: $output_dir"
  
  # 下载数据
  download_data "$name" "$output_dir"
  
  # 解压数据
  extract_all "$output_dir"
done

echo "Download and extraction completed!"
