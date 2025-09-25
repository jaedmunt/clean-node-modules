#!/usr/bin/env bash
set -e

ROOT_PATH="$1"
if [ -z "$ROOT_PATH" ]; then
  DEFAULT_PATH="$HOME/github"
  echo "No path provided. Default is: $DEFAULT_PATH"
  read -p "Enter the root path: " ROOT_PATH
  [ -z "$ROOT_PATH" ] && exit 1
fi

if [ ! -d "$ROOT_PATH" ]; then
  echo "Path not found: $ROOT_PATH"
  exit 1
fi

start=$(date +%s)
folders=$(find "$ROOT_PATH" -type d -name "node_modules")
[ -z "$folders" ] && echo "No node_modules found" && exit 0

echo "Found $(echo "$folders" | wc -l) folders."
total_size=$(du -ch $folders 2>/dev/null | grep total$ | awk '{print $1}')
echo "Estimated space: $total_size"

i=0
count=$(echo "$folders" | wc -l)
freed=0

while IFS= read -r folder; do
  i=$((i+1))
  size=$(du -sh "$folder" 2>/dev/null | awk '{print $1}')
  echo "[$i/$count] Deleting $folder ($size)"
  du_bytes=$(du -sb "$folder" 2>/dev/null | awk '{print $1}')
  rm -rf "$folder"
  freed=$((freed+du_bytes))
  freed_gb=$(echo "scale=2; $freed/1024/1024/1024" | bc)
  echo "   Freed $size (Total: ${freed_gb} GB)"
done <<< "$folders"

end=$(date +%s)
elapsed=$((end-start))
echo
echo "=== Cleanup complete ==="
echo "Deleted: $count folders"
echo "Space freed: ~${freed_gb} GB"
echo "Time taken: ${elapsed}s"
