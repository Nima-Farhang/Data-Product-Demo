#!/usr/bin/env bash
set -euo pipefail

parent_dir="./STREAMLIT/apps"
absolute_parent_dir=$(realpath "$parent_dir")

for dir in "$absolute_parent_dir"/*/; do
  if [ -d "$dir" ]; then
    echo "Processing directory: $dir"

    if [ ! -f "$dir/snowflake.yml" ]; then
      echo "snowflake.yml not found in $dir, skipping..."
      continue
    fi

    cd "$dir" || exit 1

    sed -i "s|%ENVIRONMENT%|${ENVIRONMENT}|g" snowflake.yml

    cat snowflake.yml

    snow streamlit deploy --replace --database "${ENVIRONMENT}_DATA_PRODUCT_DB" --schema APP

    cd "$absolute_parent_dir" || exit 1
  fi
done