#!/bin/bash

echo "=== Extension Host Log Extractor ==="
echo ""
echo "Please do the following:"
echo "1. Open VSCode"
echo "2. Press Cmd+Shift+P"
echo "3. Type: Developer: Show Logs..."
echo "4. Select: Extension Host"
echo "5. Try to use the command (trigger the error)"
echo "6. Copy the log output here"
echo ""
echo "Alternatively, check recent logs:"
echo ""

# Find recent VSCode logs
LOG_DIR="$HOME/Library/Application Support/Code/logs"
if [ -d "$LOG_DIR" ]; then
    LATEST_LOG=$(find "$LOG_DIR" -name "exthost*.log" -type f -print0 | xargs -0 ls -t | head -1)
    if [ -n "$LATEST_LOG" ]; then
        echo "Latest Extension Host log found:"
        echo "$LATEST_LOG"
        echo ""
        echo "=== Last 50 lines ==="
        tail -50 "$LATEST_LOG"
        echo ""
        echo "=== Searching for errors related to our extension ==="
        grep -i "better-copy-path\|markshawn2020\|qishan233" "$LATEST_LOG" | tail -20
    fi
else
    echo "Log directory not found. Please check logs manually in VSCode."
fi
