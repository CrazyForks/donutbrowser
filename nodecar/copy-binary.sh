#!/bin/bash

# Determine file extension based on platform
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
    EXT=".exe"
else
    EXT=""
fi

# If architecture provided in the command line, use it to rename the binary in TARGET_TRIPLE
if [ -n "$1" ]; then
    TARGET_TRIPLE="$1"
else
    RUST_INFO=$(rustc -vV)
    TARGET_TRIPLE=$(echo "$RUST_INFO" | grep -o 'host: [^ ]*' | cut -d' ' -f2)
fi

# Check if target triple was found
if [ -z "$TARGET_TRIPLE" ]; then
    echo "Failed to determine platform target triple" >&2
    exit 1
fi

# Copy the file
cp "dist/nodecar${EXT}" "../src-tauri/binaries/nodecar-${TARGET_TRIPLE}${EXT}"