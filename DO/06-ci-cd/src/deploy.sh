#!/bin/bash

TARGET_USER="flagminn"
TARGET_HOST="192.168.7.39"
TARGET_DIR="/usr/local/bin"
BINARY="src/build/DO"

echo "=== START DEPLOYMENT ==="


if [ ! -f "$BINARY" ]; then
    echo "ERROR: Binary file $BINARY not found!"
    exit 1
fi


echo "Copying $BINARY to $TARGET_USER@$TARGET_HOST:$TARGET_DIR..."
scp -o StrictHostKeyChecking=no "$BINARY" "$TARGET_USER@$TARGET_HOST:$TARGET_DIR/"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to copy binary via SCP!"
    exit 1
fi


echo "Granting execution permissions..."
ssh -o StrictHostKeyChecking=no "$TARGET_USER@$TARGET_HOST" "chmod +x $TARGET_DIR/DO"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to set execution rights via SSH!"
    exit 1
fi

echo "SUCCESS: Deployment completed successfully!"
exit 0