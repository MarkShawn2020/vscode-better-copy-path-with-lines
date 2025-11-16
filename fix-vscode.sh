#!/bin/bash

echo "=== VSCode Extension Fix Script ==="
echo ""

echo "Step 1: Killing all VSCode processes..."
killall "Visual Studio Code" 2>/dev/null
killall "Code Helper" 2>/dev/null
sleep 2

echo "Step 2: Clearing VSCode cache..."
rm -rf ~/Library/Saved\ Application\ State/com.microsoft.VSCode.savedState
rm -rf ~/Library/Caches/com.microsoft.VSCode
rm -rf ~/Library/Caches/com.microsoft.VSCode.ShipIt
echo "Cache cleared!"

echo ""
echo "Step 3: Verifying extension installation..."
if [ -d ~/.vscode/extensions/markshawn2020.better-copy-path-with-lines-0.2.3 ]; then
    echo "✅ Extension 0.2.3 is installed"
    version=$(cat ~/.vscode/extensions/markshawn2020.better-copy-path-with-lines-0.2.3/package.json | jq -r '.version')
    echo "   Version in package.json: $version"
else
    echo "❌ Extension 0.2.3 NOT found!"
    echo "Installing from local VSIX..."
    code --install-extension better-copy-path-with-lines-0.2.2.vsix --force
fi

echo ""
echo "=== Fix Complete ==="
echo ""
echo "IMPORTANT: Now do the following:"
echo "1. Open VSCode"
echo "2. Open Command Palette (Cmd+Shift+P)"
echo "3. Type: Developer: Show Running Extensions"
echo "4. Search for 'better-copy-path' in the list"
echo "5. Verify it shows 'markshawn2020.better-copy-path-with-lines'"
echo "6. If it shows 'Activator: onCommand:markshawn2020.copy.relative.path.line'"
echo ""
echo "Then test:"
echo "A. Via Command Palette: Type 'Copy' and look for the commands"
echo "B. Via right-click menu in a file"
echo ""
