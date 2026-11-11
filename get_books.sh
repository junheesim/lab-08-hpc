#!/bin/bash
set -euo pipefail

BUCKET="$1"
DIR="$2"

mkdir -p "$DIR"

# Download the .txt files in the specified S3 bucket
aws s3 cp "s3://$BUCKET/" "$DIR" --recursive --exclude "*" --include "*.txt"

echo "File path" > book_list.txt 

# Get the absolute path of the book directory
ABS_DIR=$(realpath "$DIR")

# Find the book files, sort them, and append paths
find "$ABS_DIR" -name "*.txt" | sort >> book_list.txt

# Line count, minus the header
COUNT=$(($(wc -l < book_list.txt) - 1))

# Logging
echo "Wrote $COUNT book files to book_list.txt"
