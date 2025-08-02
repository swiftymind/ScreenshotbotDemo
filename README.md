# ScreenshotBot Demo App - Development Guide 🛠️

A comprehensive SwiftUI demo application showcasing **ScreenshotBot's** visual regression testing capabilities with automated snapshot generation and CI/CD integration.

## 🚀 Quick Start

### 1. Clone and Setup
```bash
git clone https://github.com/swiftymind/ScreenshotbotDemo.git
cd ScreenshotbotDemo

# Make scripts executable
chmod +x *.sh

# Run setup (builds project and verifies environment)
./setup_demo.sh
```

### 2. Generate Your First Snapshots
```bash
# Record new snapshots
./run_snapshot_tests.sh record

# Verify snapshots (should pass after recording)
./run_snapshot_tests.sh verify
```

### 3. View Generated Snapshots
Snapshots are saved to: `ScreenshotbotDemoTests/__Snapshots__/`

## 📱 App Architecture

### SwiftUI Views Structure
```
ContentView (TabView)
├── DashboardView     # Analytics & metrics
├── ProductsView      # Product catalog
├── ProfileView       # User profile & achievements  
└── SettingsView      # App configuration
```

### Key Components
- **MetricCard**: Revenue/analytics display cards
- **ProductCard**: Product catalog items with ratings
- **SimpleChartView**: Animated data visualization
- **AchievementBadge**: User achievement display
- **SettingsRow/Toggle/Picker**: Configuration components

## 🧪 Testing Strategy

### Test Files Structure
```
ScreenshotbotDemoTests/
├── WorkingSnapshotTests.swift    # Main comprehensive tests
└── QuickSnapshotTest.swift       # Simple single test
```

### Test Coverage
- ✅ **Full App Views**: All 4 main tabs (Dashboard, Products, Profile, Settings)
- ✅ **Component Level**: Individual UI components (MetricCard, ProductCard, etc.)
- ✅ **Theme Variations**: Light and Dark mode snapshots
- ✅ **Device Responsiveness**: iPhone 13 Pro Max layout testing
- ✅ **State Variations**: Different data states and interactions

## 🎛️ Snapshot Testing Control

### Easy Record/Verify Toggle
The `WorkingSnapshotTests.swift` has a simple toggle:

```swift
private let RECORD_MODE = false  // Set to true to record, false to verify
```

### Using the Helper Script (Recommended)
```bash
# Generate new snapshots
./run_snapshot_tests.sh record

# Test against existing snapshots  
./run_snapshot_tests.sh verify

# Run a single test
./run_snapshot_tests.sh single contentViewSnapshot
```

### Manual Xcode Testing
```bash
# Record snapshots manually
xcodebuild test -scheme ScreenshotbotDemo \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  -only-testing:ScreenshotbotDemoTests/WorkingSnapshotTests
```

## 🔧 Development Setup

### Prerequisites
- **Xcode 15+** with iOS 17+ SDK
- **iPhone 16 Pro Simulator** (or modify script for other devices)
- **macOS 12+**
- **Command Line Tools** installed

### Dependencies
The project uses **swift-snapshot-testing** library:
- Repository: `https://github.com/pointfreeco/swift-snapshot-testing`
- Version: `1.17.7` (includes Swift Testing support)
- Integration: Added via Xcode's Swift Package Manager

### Key Features
- **Swift Testing (@Test)**: Apple's modern testing framework
- **MainActor Compliance**: Proper concurrency handling
- **Record/Verify Modes**: Easy snapshot management
- **Device Configuration**: iPhone 13 Pro Max layout testing

## 🚀 ScreenshotBot Integration

### 1. API Setup
```bash
# Set your ScreenshotBot API credentials
export SCREENSHOTBOT_API_KEY=your_actual_api_key
export SCREENSHOTBOT_API_SECRET=your_actual_api_secret
```

### 2. Upload Snapshots
```bash
# Auto-upload all generated snapshots
./upload_to_screenshotbot.sh
```

### 3. CI/CD Integration

#### GitHub Actions (`.github/workflows/screenshot-tests.yml`)
- Automatic testing on push to main/develop
- Screenshot generation and upload
- Artifact storage for debugging

#### CircleCI (`.circleci/config.yml`)
- Alternative CI setup
- macOS environment with Xcode
- ScreenshotBot CLI installation and upload

#### Fastlane (`fastlane/Fastfile`)
- `fastlane tests` - Run all tests
- `fastlane screenshotbot_ci` - Full CI pipeline
- `fastlane demo` - Complete demo workflow

## 🎯 Demo Scenarios

### Scenario 1: New Feature Development
```bash
# 1. Record baseline snapshots
./run_snapshot_tests.sh record

# 2. Make UI changes...

# 3. Verify changes don't break existing UI
./run_snapshot_tests.sh verify

# 4. Update snapshots if changes are intentional
./run_snapshot_tests.sh record
```

### Scenario 2: CI/CD Pipeline
```bash
# Automated on every commit:
# 1. Build project
# 2. Run snapshot tests  
# 3. Upload to ScreenshotBot
# 4. Generate visual diff reports
```

### Scenario 3: Cross-team Review
```bash
# 1. Generate snapshots locally
./run_snapshot_tests.sh record

# 2. Upload to ScreenshotBot for team review
./upload_to_screenshotbot.sh

# 3. Team reviews visual changes in ScreenshotBot dashboard
```

## 🔍 Troubleshooting

### Common Issues

#### ❌ "iPhone 16 Pro simulator not found"
**Solution**: Update `run_snapshot_tests.sh` to use available simulator:
```bash
# Check available simulators
xcrun simctl list devices | grep iPhone

# Update the script with your simulator name
```

#### ❌ "TestScoping conformance error"
**Solution**: Ensure you're using swift-snapshot-testing v1.17.6+:
- In Xcode: File → Add Package Dependencies
- URL: `https://github.com/pointfreeco/swift-snapshot-testing`
- Version: 1.17.6 or later

#### ❌ "Fatal error: calling into SwiftUI on a non-main thread"
**Solution**: Tests use `@MainActor` - this is already implemented in the working tests.

#### ❌ Build conflicts with "Multiple commands produce..."
**Solution**: Clean derived data:
```bash
rm -rf ~/Library/Developer/Xcode/DerivedData/ScreenshotbotDemo-*
```

### Getting Help
- **ScreenshotBot Docs**: https://screenshotbot.io/docs
- **Swift Snapshot Testing**: https://github.com/pointfreeco/swift-snapshot-testing
- **SwiftUI Documentation**: https://developer.apple.com/documentation/swiftui

## 📊 Performance & Best Practices

### Snapshot Test Performance
- **Parallel Testing**: Tests can run concurrently with proper MainActor usage
- **Image Compression**: PNG files are automatically optimized
- **Selective Testing**: Use single test runs during development

### Maintenance Tips
- **Regular Updates**: Keep snapshots current with UI changes
- **Meaningful Names**: Use descriptive test names for easy identification
- **Component Testing**: Test individual components alongside full views
- **Device Coverage**: Test on multiple device sizes when needed

## 🎨 Customization

### Adding New Tests
1. Open `WorkingSnapshotTests.swift`
2. Add new `@Test` function:
```swift
@Test("Your New View Test")
func yourNewViewTest() async throws {
    let view = YourNewView()
    
    if RECORD_MODE {
        withSnapshotTesting(record: .all) {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
        }
    } else {
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
    }
}
```

### Different Device Sizes
```swift
// iPhone SE
.image(layout: .device(config: .iPhoneSe))

// iPad Pro
.image(layout: .device(config: .iPadPro12_9))

// Custom size
.image(layout: .fixed(width: 375, height: 812))
```

### Theme Testing
```swift
// Dark mode
let view = YourView()
    .preferredColorScheme(.dark)

// Light mode  
let view = YourView()
    .preferredColorScheme(.light)
```

## 📚 Additional Resources

### Project Structure
```
ScreenshotbotDemo/
├── ScreenshotbotDemo/          # Main app code
│   ├── ScreenshotbotDemoApp.swift
│   ├── ContentView.swift
│   └── Views.swift             # All UI components
├── ScreenshotbotDemoTests/     # Test files
│   ├── WorkingSnapshotTests.swift
│   └── QuickSnapshotTest.swift
├── .github/workflows/          # GitHub Actions
├── .circleci/                  # CircleCI config
├── fastlane/                   # Fastlane automation
└── Scripts/                    # Helper scripts
    ├── run_snapshot_tests.sh
    ├── setup_demo.sh
    └── upload_to_screenshotbot.sh
```

### Learning Resources
- **ScreenshotBot Blog**: Latest features and best practices
- **SwiftUI Tutorials**: Apple's official SwiftUI tutorials
- **iOS Testing Guide**: Apple's testing documentation
- **Visual Regression Testing**: Industry best practices

---

## 🎉 Ready to Demo!

Your ScreenshotBot demo is ready! Here's what you have:

✅ **Beautiful SwiftUI App** with 4 comprehensive views  
✅ **Working Snapshot Tests** with easy record/verify toggle  
✅ **CI/CD Integration** for GitHub Actions, CircleCI, and Fastlane  
✅ **Helper Scripts** for easy development workflow  
✅ **Comprehensive Documentation** for team adoption  

### Next Steps
1. **Run the demo**: `./setup_demo.sh`
2. **Generate snapshots**: `./run_snapshot_tests.sh record`
3. **Set up ScreenshotBot**: Add your API keys
4. **Start testing**: Make UI changes and see the visual diffs!

**Happy Testing! 🚀**
