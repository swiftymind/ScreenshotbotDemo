#!/bin/bash

# ScreenshotBot Upload Script
# Run this after taking screenshots of your app

echo "🚀 ScreenshotBot Upload Script"
echo "============================="

# Check if Screenshots directory exists
if [ ! -d "Screenshots" ]; then
    echo "📁 Creating Screenshots directory..."
    mkdir -p Screenshots
    echo "⚠️  Please add your screenshot PNG files to the Screenshots/ directory first"
    echo "   Then run this script again"
    exit 1
fi

# Count screenshots
SCREENSHOT_COUNT=$(find Screenshots -name "*.png" | wc -l)
if [ $SCREENSHOT_COUNT -eq 0 ]; then
    echo "⚠️  No PNG files found in Screenshots/ directory"
    echo "   Please take screenshots first using:"
    echo "   1. Run app in Xcode (⌘+R)"
    echo "   2. Use Device > Screenshot (⌘+S) in simulator"
    echo "   3. Save files to Screenshots/ directory"
    exit 1
fi

echo "📸 Found $SCREENSHOT_COUNT screenshot(s) to upload"

# Install ScreenshotBot CLI
echo "📋 Installing ScreenshotBot CLI..."
curl https://cdn.screenshotbot.io/recorder.sh | sh

if [ $? -eq 0 ]; then
    echo "✅ ScreenshotBot CLI installed successfully"
else
    echo "❌ Failed to install ScreenshotBot CLI"
    exit 1
fi

# Check for API credentials
if [ -z "$SCREENSHOTBOT_API_KEY" ] || [ -z "$SCREENSHOTBOT_API_SECRET" ]; then
    echo ""
    echo "🔑 API Credentials Required!"
    echo "Please set your ScreenshotBot API credentials:"
    echo ""
    echo "export SCREENSHOTBOT_API_KEY=your_actual_api_key"
    echo "export SCREENSHOTBOT_API_SECRET=your_actual_api_secret"
    echo ""
    echo "Get your API keys from: https://screenshotbot.io/api-keys"
    echo ""
    echo "Then run this script again"
    exit 1
fi

echo "✅ API credentials found"

# Upload screenshots
echo "📤 Uploading screenshots to ScreenshotBot..."
~/screenshotbot/recorder --channel ScreenshotbotDemo --directory Screenshots/ --recursive

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Screenshots uploaded successfully!"
    echo "📈 View your results at: https://screenshotbot.io"
else
    echo "❌ Upload failed"
    exit 1
fi

echo ""
echo "✨ All done! Check your ScreenshotBot dashboard to see the beautiful screenshots!"
