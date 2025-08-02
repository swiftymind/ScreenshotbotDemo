# ScreenshotBot Demo - Troubleshooting Guide 🛠️

## Common Issues and Solutions

### 🚫 Build and Compilation Issues

#### 1. "iPhone 16 Pro simulator not found"
**Symptoms**: Test scripts fail with simulator not found error

**Solutions**:
```bash
# Check available simulators
xcrun simctl list devices | grep iPhone

# Option A: Install iPhone 16 Pro simulator
# Open Xcode → Window → Devices and Simulators → Simulators → Add (+)

# Option B: Update scripts to use available simulator
# Edit run_snapshot_tests.sh and replace 'iPhone 16 Pro' with your available device
```

#### 2. "TestScoping conformance error"
**Symptoms**: 
```
Cannot use conformance of 'Never' to 'TestScoping' here; 'Testing' has been imported as implementation-only
```

**Root Cause**: Using old version of swift-snapshot-testing (< 1.17.6)

**Solution**:
1. Open Xcode project
2. Select project in navigator
3. Go to "Package Dependencies" tab
4. Update swift-snapshot-testing to version 1.17.6 or later
5. Clean build folder (⌘+Shift+K)

#### 3. "Multiple commands produce" build errors
**Symptoms**: Xcode build fails with duplicate file errors

**Solution**:
```bash
# Clean derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/ScreenshotbotDemo-*

# Clean snapshot directories from old tests
rm -rf ScreenshotbotDemoTests/__Snapshots__/OldTestName/

# Rebuild project
xcodebuild clean build -scheme ScreenshotbotDemo
```

### 🧪 Testing Issues

#### 4. "Fatal error: calling into SwiftUI on a non-main thread"
**Symptoms**: Tests crash with threading error

**Root Cause**: SwiftUI operations not on main thread

**Solution**: Ensure tests use `@MainActor`:
```swift
@MainActor
struct YourSnapshotTests {
    // Tests here automatically run on main actor
}
```

#### 5. Tests timeout or hang
**Symptoms**: Tests never complete, Xcode shows spinning indicator

**Solutions**:
```bash
# Kill simulator processes
sudo killall Simulator
sudo killall "iOS Simulator"

# Reset simulator
xcrun simctl erase all

# Restart Xcode
```

#### 6. Snapshot images not generating
**Symptoms**: Tests run but no PNG files created

**Check**:
1. Verify `RECORD_MODE = true` in test file
2. Check __Snapshots__ directory permissions:
```bash
ls -la ScreenshotbotDemoTests/__Snapshots__/
```
3. Ensure simulator has enough disk space

### 📱 Simulator Issues

#### 7. Simulator won't boot
**Symptoms**: "Unable to boot device" error

**Solutions**:
```bash
# Reset specific simulator
xcrun simctl shutdown "iPhone 16 Pro"
xcrun simctl erase "iPhone 16 Pro"
xcrun simctl boot "iPhone 16 Pro"

# Or reset all simulators
xcrun simctl erase all
```

#### 8. Simulator performance issues
**Symptoms**: Very slow test execution

**Solutions**:
- Close other running simulators
- Restart Simulator app
- Check system resources (Activity Monitor)
- Reduce simulator scale: Device → Scale → 50%

### 🔧 Script Issues

#### 9. "Permission denied" when running scripts
**Symptoms**: `./script.sh: Permission denied`

**Solution**:
```bash
chmod +x *.sh
chmod +x run_snapshot_tests.sh
chmod +x setup_demo.sh
chmod +x upload_to_screenshotbot.sh
```

#### 10. Scripts can't find Xcode tools
**Symptoms**: `xcodebuild: command not found`

**Solution**:
```bash
# Set correct Xcode path
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Verify
which xcodebuild
```

### 🌐 ScreenshotBot Integration Issues

#### 11. "API credentials not found"
**Symptoms**: Upload script fails with missing credentials

**Solution**:
```bash
# Set environment variables
export SCREENSHOTBOT_API_KEY=your_actual_api_key
export SCREENSHOTBOT_API_SECRET=your_actual_api_secret

# Verify they're set
echo $SCREENSHOTBOT_API_KEY
```

#### 12. CLI installation fails
**Symptoms**: `curl https://cdn.screenshotbot.io/recorder.sh | sh` fails

**Solutions**:
- Check internet connection
- Try manual download:
```bash
curl -O https://cdn.screenshotbot.io/recorder.sh
chmod +x recorder.sh
./recorder.sh
```

#### 13. Upload fails with "No snapshots found"
**Symptoms**: CLI runs but reports no files to upload

**Check**:
1. Verify snapshots were generated:
```bash
find . -name "*.png" -path "*/__Snapshots__/*"
```
2. Check directory structure:
```bash
ls -la ScreenshotbotDemoTests/__Snapshots__/
```

### 🎛️ Development Workflow Issues

#### 14. Git conflicts with snapshots
**Symptoms**: Large binary diff files in git

**Solution**: Snapshots are gitignored, but if you see them:
```bash
# Remove from git tracking
git rm --cached **/__Snapshots__/**/*.png
git commit -m "Remove snapshots from tracking"

# Verify .gitignore includes:
echo "**/__Snapshots__/**/*.png" >> .gitignore
```

#### 15. Tests pass locally but fail in CI
**Symptoms**: Different results between local and CI environment

**Common Causes & Solutions**:
- **Different Xcode version**: Ensure CI uses same Xcode version
- **Different simulator**: Update CI to use same device
- **Different timezone**: Set consistent timezone in CI
- **Missing dependencies**: Ensure all packages are resolved

```yaml
# GitHub Actions example
- name: Setup Xcode
  uses: maxim-lobanov/setup-xcode@v1
  with:
    xcode-version: '16.4'  # Match your local version
```

### 📊 Performance Issues

#### 16. Tests take too long
**Symptoms**: Test suite runs for several minutes

**Optimizations**:
- Run single tests during development:
```bash
./run_snapshot_tests.sh single contentViewSnapshot
```
- Use smaller device configs for faster rendering
- Remove unnecessary test variations
- Run tests in parallel (already implemented with @MainActor)

#### 17. Large snapshot file sizes
**Symptoms**: PNG files are very large (>1MB each)

**Solutions**:
- Use appropriate device configs (don't test iPad if not needed)
- Consider lower resolution for non-critical tests
- Compress images if uploading manually

## 🆘 Getting Help

If you're still having issues:

1. **Check Logs**: Look at full Xcode console output
2. **Clean Everything**: 
   ```bash
   # Nuclear option - clean everything
   rm -rf ~/Library/Developer/Xcode/DerivedData/
   rm -rf ScreenshotbotDemoTests/__Snapshots__/
   xcodebuild clean
   ```
3. **Create Minimal Reproduction**: Strip down to simplest failing case
4. **Check Dependencies**: Ensure all packages are latest compatible versions

### Resources
- **ScreenshotBot Support**: https://screenshotbot.io/support
- **Swift Snapshot Testing Issues**: https://github.com/pointfreeco/swift-snapshot-testing/issues
- **Xcode Release Notes**: Check for known issues with your Xcode version
- **Apple Developer Forums**: For Xcode/simulator specific issues

### Debug Commands
```bash
# System info
sw_vers
xcodebuild -version

# Simulator info  
xcrun simctl list devices

# Package info
swift package show-dependencies

# Build logs
xcodebuild build -scheme ScreenshotbotDemo 2>&1 | tee build.log
```

---

**Remember**: Most issues are environment-related. When in doubt, clean everything and start fresh! 🧹✨
