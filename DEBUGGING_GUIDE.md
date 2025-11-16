# Extension Debugging Guide

## Current Status

### ✅ Extension is Correctly Configured
- Version: 0.2.3
- Command IDs: `markshawn2020.copy.relative.path.line`, `markshawn2020.copy.absolute.path.line`
- Activation Events: Properly configured with `onCommand`
- Compiled Code: Verified correct

### Problem: "command not found" error

This suggests VSCode is not properly loading/activating the extension.

## Diagnostic Steps

### Step 1: Verify Extension is Installed

```bash
code --list-extensions --show-versions | grep better-copy
```

Expected: `markshawn2020.better-copy-path-with-lines@0.2.3`

### Step 2: Check Running Extensions

1. Open VSCode
2. Press `Cmd+Shift+P`
3. Type: `Developer: Show Running Extensions`
4. Search for "better-copy-path"
5. Check:
   - Is it in the list?
   - What's the "Activator" value?
   - Is there a red error indicator?

### Step 3: Check Extension Host Log

1. Press `Cmd+Shift+P`
2. Type: `Developer: Show Logs...`
3. Select: `Extension Host`
4. Look for errors related to `markshawn2020.better-copy-path-with-lines`

### Step 4: Force Full Reload

```bash
# Kill all VSCode processes
killall "Visual Studio Code"
killall "Code Helper"

# Clear cache
rm -rf ~/Library/Saved\ Application\ State/com.microsoft.VSCode.savedState
rm -rf ~/Library/Caches/com.microsoft.VSCode

# Reinstall extension
code --uninstall-extension markshawn2020.better-copy-path-with-lines
code --install-extension ~/.../better-copy-path-with-lines-0.2.3.vsix --force

# Restart VSCode
```

## Testing Methods

### Method 1: Command Palette (Best for initial test)
1. Press `Cmd+Shift+P`
2. Type: `Copy Relative Path:Line` or `Copy Absolute Path:Line`
3. This should trigger extension activation

### Method 2: Right-Click Menu
1. Right-click in an editor
2. Look for "Copy Relative Path:Line" and "Copy Absolute Path:Line" options
3. Click one

### Method 3: Line Number Gutter
1. Right-click on a line number
2. Look for the copy commands
3. Click one

## Common Issues

### Issue 1: Multiple Extension Versions
**Symptom**: VSCode loads an old version
**Solution**:
```bash
rm -rf ~/.vscode/extensions/markshawn2020.better-copy-path-with-lines-*
code --install-extension better-copy-path-with-lines-0.2.3.vsix --force
```

### Issue 2: Extension Not Activating
**Symptom**: Commands appear in package.json but not in Command Palette
**Cause**: `activationEvents` missing or incorrect
**Check**: package.json should have:
```json
"activationEvents": [
  "onCommand:markshawn2020.copy.relative.path.line",
  "onCommand:markshawn2020.copy.absolute.path.line"
]
```

### Issue 3: Command ID Mismatch
**Symptom**: Error says "command 'markshawn2020.copy.*.line' not found"
**Cause**: Extension didn't register commands
**Check**:
1. Verify extension activated (see Step 2 above)
2. Check Extension Host log for activation errors

### Issue 4: VSCode Cache
**Symptom**: Changes don't take effect
**Solution**: See "Step 4: Force Full Reload" above

## Development Testing

To test local changes:

1. Open this project in VSCode
2. Press `F5` to launch Extension Development Host
3. In the new window, test the commands
4. Check Debug Console for any errors

## Quick Fix Script

Run: `./fix-vscode.sh`

This will:
- Kill VSCode processes
- Clear caches
- Verify installation
- Provide next steps
