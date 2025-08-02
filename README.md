# ScreenshotBot Demo App 📱✨

A comprehensive SwiftUI demo application showcasing **ScreenshotBot's** visual regression testing capabilities with automated snapshot generation and CI/CD integration.

## 🎯 What is ScreenshotBot?

ScreenshotBot is a powerful visual regression testing service that helps teams:
- **Catch visual bugs** before they reach production
- **Automate UI testing** with snapshot comparisons
- **Integrate seamlessly** with CI/CD pipelines
- **Track visual changes** across app versions

## 🚀 Demo App Features

This demo showcases a **modern SwiftUI application** with:

### 📊 Dashboard View
- Revenue and analytics metrics
- Interactive charts and data visualization
- Real-time performance indicators

### 🛍️ Products View
- Product catalog with search and filtering
- Category-based navigation
- Favorite products functionality

### 👤 Profile View
- User achievements and statistics
- Activity tracking and progress
- Social features integration

### ⚙️ Settings View
- App preferences and configuration
- Theme and notification settings
- Account management

## 🧪 Snapshot Testing Features

### ✅ Comprehensive Test Coverage
- **Full app views** (Dashboard, Products, Profile, Settings)
- **Component-level testing** (MetricCard, ProductCard)
- **Theme variations** (Light/Dark mode)
- **Device responsiveness** (iPhone SE, iPhone 13 Pro Max, iPad)

### 🎛️ Easy Record/Verify Toggle
```bash
# Record new snapshots
./run_snapshot_tests.sh record

# Verify against existing snapshots
./run_snapshot_tests.sh verify

# Run single test
./run_snapshot_tests.sh single contentViewSnapshot
```

## 🔧 Quick Start

### Prerequisites
- **Xcode 15+** with iOS 18.5+ SDK
- **macOS 12+** 
- **iPhone Simulator**

### Setup
```bash
# Clone the repository
git clone https://github.com/swiftymind/ScreenshotbotDemo.git
cd ScreenshotbotDemo

# Switch to develop branch for full code
git checkout develop

# Run setup script
./setup_demo.sh
```

### Generate Your First Snapshots
```bash
# Generate snapshots locally
./run_snapshot_tests.sh record

# Verify snapshots work
./run_snapshot_tests.sh verify
```

## 🏗️ CI/CD Integration

### GitHub Actions
Pre-configured workflow for automated testing:
- ✅ Build verification
- ✅ Snapshot generation
- ✅ ScreenshotBot upload
- ✅ Visual diff reports

### CircleCI & Fastlane
Alternative CI configurations included:
- `fastlane/Fastfile` - Automated lane for ScreenshotBot
- `.circleci/config.yml` - Full CircleCI pipeline

## 📱 Architecture

### SwiftUI + MVVM
- **Modern SwiftUI** declarative UI
- **Modular component design**
- **Responsive layouts** for all devices
- **Dark mode support**

### Testing Framework
- **Swift Testing** (@Test) - Apple's latest testing framework
- **swift-snapshot-testing** - Reliable visual testing
- **MainActor compliance** - Proper concurrency handling

## 🎨 Visual Components

| Component | Description | Snapshot Coverage |
|-----------|-------------|-------------------|
| MetricCard | Revenue/analytics display | ✅ Light & Dark |
| ProductCard | Product catalog items | ✅ Multiple states |
| SimpleChart | Data visualization | ✅ Animated states |
| TabView | Main navigation | ✅ All tabs |

## 🔗 Links

- **[ScreenshotBot Website](https://screenshotbot.io)** - Learn more about the service
- **[Documentation](https://screenshotbot.io/docs)** - Integration guides
- **[Swift Snapshot Testing](https://github.com/pointfreeco/swift-snapshot-testing)** - Testing library

## 🏆 Perfect for...

- **Demo purposes** - Showcase visual testing capabilities
- **Learning** - Understand snapshot testing best practices
- **Template** - Bootstrap new projects with visual testing
- **CI/CD examples** - See working automation setups

## 📄 License

MIT License - See [LICENSE](LICENSE) for details.

---

**Made with ❤️ for the iOS development community**

*Showcasing the power of visual regression testing with ScreenshotBot* 🚀