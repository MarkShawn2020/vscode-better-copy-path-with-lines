#!/bin/bash

echo "=== Extension Testing Script ==="
echo ""

echo "1. Checking installed extension versions..."
code --list-extensions --show-versions | grep better-copy
echo ""

echo "2. Checking extension directory..."
ls -la ~/.vscode/extensions/markshawn2020.better-copy-path-with-lines-*/package.json 2>/dev/null | awk '{print $9}'
echo ""

echo "3. Checking package.json version in each directory..."
for dir in ~/.vscode/extensions/markshawn2020.better-copy-path-with-lines-*; do
    if [ -d "$dir" ]; then
        echo "Directory: $(basename $dir)"
        cat "$dir/package.json" | jq -r '.version'
        echo "Commands:"
        cat "$dir/package.json" | jq -r '.contributes.commands[].command'
        echo "Activation Events:"
        cat "$dir/package.json" | jq -r '.activationEvents[]'
        echo ""
    fi
done

echo "4. Checking compiled extension.js..."
for dir in ~/.vscode/extensions/markshawn2020.better-copy-path-with-lines-*; do
    if [ -f "$dir/out/extension.js" ]; then
        echo "In $(basename $dir):"
        grep "registerCommand" "$dir/out/extension.js" | grep -o "registerCommand('[^']*'" || echo "No commands found"
        echo ""
    fi
done

echo "=== Test Complete ==="
echo ""
echo "Next steps:"
echo "1. Quit ALL VSCode windows completely"
echo "2. Run: killall 'Visual Studio Code' 2>/dev/null"
echo "3. Wait 5 seconds"
echo "4. Reopen VSCode"
echo "5. Test the command via Command Palette (Cmd+Shift+P) first"
echo "6. Then test via right-click menu"
