#!/bin/bash

# ScreenshotBot iOS App Demo Script
# This script demonstrates our beautiful SwiftUI iOS application

set -e

echo "🎬 ScreenshotBot iOS App Demo"
echo "=============================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if we're in the right directory
if [ ! -f "ScreenshotbotDemo.xcodeproj/project.pbxproj" ]; then
    print_error "Please run this script from the ScreenshotbotDemo project root directory"
    exit 1
fi

print_step "Checking prerequisites..."

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    print_error "Xcode is not installed or not in PATH"
    exit 1
fi
print_success "Xcode found"

# Check if we have the right iOS Simulator
if ! xcrun simctl list devices | grep -q "iPhone 16 Pro"; then
    print_warning "iPhone 16 Pro simulator not found. Tests may fail."
    echo "Available simulators:"
    xcrun simctl list devices | grep iPhone
    echo ""
    read -p "Continue anyway? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    print_success "iPhone 16 Pro simulator found"
fi

print_step "Preparing iOS project..."
echo "✨ This is a native iOS app using Xcode project structure"
print_success "iOS project ready"

print_step "Building the project..."
xcodebuild build \
    -scheme ScreenshotbotDemo \
    -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
    -configuration Debug \
    CODE_SIGNING_REQUIRED=NO \
    -quiet

print_success "Project built successfully"

print_step "Running the beautiful iOS app..."
echo ""
echo "📱 Our iOS app features:"
echo "   🏠 Dashboard - Analytics with metric cards and interactive charts"
echo "   🛍️ Products - Product catalog with search and filtering"
echo "   👤 Profile - User profile with achievements and statistics"
echo "   ⚙️ Settings - Comprehensive app configuration"
echo ""

# Start the iOS Simulator and build the app
print_step "Building for iOS Simulator..."
xcodebuild build \
    -scheme ScreenshotbotDemo \
    -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
    -configuration Debug \
    CODE_SIGNING_REQUIRED=NO \
    -quiet

print_success "iOS app built successfully! 🎉"

print_step "Demonstrating app features..."
echo ""
echo "🌟 Key Features of our SwiftUI Demo App:"
echo ""
echo "📈 DASHBOARD VIEW:"
echo "   • Real-time analytics with animated metric cards"
echo "   • Interactive charts showing performance data"
echo "   • Recent activity feed with user interactions"
echo "   • Toggle notifications and view selection"
echo ""
echo "🛍 PRODUCTS VIEW:"
echo "   • Searchable product catalog"
echo "   • Category filtering (Electronics, Clothing, Books, Home)"
echo "   • Product cards with ratings and favorites"
echo "   • Beautiful grid layout with smooth scrolling"
echo ""
echo "👥 PROFILE VIEW:"
echo "   • User profile with avatar and statistics"
echo "   • Achievement badges (Early Adopter, Power User, etc.)"
echo "   • Activity metrics and engagement data"
echo "   • Profile editing capabilities"
echo ""
echo "⚙️ SETTINGS VIEW:"
echo "   • Comprehensive app configuration"
echo "   • Theme selection (Light/Dark/Auto)"
echo "   • Notification preferences"
echo "   • Privacy and security settings"
echo ""

print_step "Ready for ScreenshotBot integration..."
echo ""
echo "🎯 Next Steps for ScreenshotBot:"
echo "1. Add swift-snapshot-testing dependency via Xcode"
echo "2. Create snapshot tests for each view"
echo "3. Set up CI/CD pipeline with provided configurations"
echo "4. Configure API credentials and upload screenshots"
echo ""
echo "📁 Project includes:"
echo "   • Fastlane configuration (fastlane/Fastfile)"
echo "   • CircleCI setup (.circleci/config.yml)"
echo "   • GitHub Actions workflow (.github/workflows/)"
echo "   • Complete documentation (README.md)"

echo ""
echo "🎉 iOS App Demo Complete!"
echo ""
echo "✨ What you've got:"
echo "• Beautiful, production-ready SwiftUI iOS application"
echo "• Four comprehensive views: Dashboard, Products, Profile, Settings"
echo "• Modern SwiftUI architecture with reusable components"
echo "• Ready for ScreenshotBot integration"
echo ""
echo "🚀 To see the app in action:"
echo "• Open ScreenshotbotDemo.xcodeproj in Xcode"
echo "• Select iPhone 16 Pro simulator"
echo "• Run the app and explore the beautiful interface!"
echo ""
echo "📆 For complete setup instructions, see: README.md"
echo "🔗 For ScreenshotBot integration, visit: https://screenshotbot.io"
