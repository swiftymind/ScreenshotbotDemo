#!/bin/bash

echo "🎯 ScreenshotBot Demo - Snapshot Testing Helper"
echo "=============================================="

case "$1" in
    "record")
        echo "📸 RECORDING MODE - Generating new snapshots..."
        echo "Setting RECORD_MODE = true..."

        # Update the record mode to true
        sed -i.bak 's/private let RECORD_MODE = false/private let RECORD_MODE = true/' ScreenshotbotDemoTests/WorkingSnapshotTests.swift

        # Run tests
        xcodebuild test -scheme ScreenshotbotDemo -destination 'platform=iOS Simulator,name=iPhone 16 Pro' -only-testing:ScreenshotbotDemoTests/WorkingSnapshotTests

        # Restore record mode to false
        sed -i.bak 's/private let RECORD_MODE = true/private let RECORD_MODE = false/' ScreenshotbotDemoTests/WorkingSnapshotTests.swift
        rm ScreenshotbotDemoTests/WorkingSnapshotTests.swift.bak

        echo "✅ Recording complete! Record mode reset to false."
        ;;

    "verify")
        echo "✅ VERIFICATION MODE - Testing against recorded snapshots..."

        # Ensure record mode is false
        sed -i.bak 's/private let RECORD_MODE = true/private let RECORD_MODE = false/' ScreenshotbotDemoTests/WorkingSnapshotTests.swift
        rm -f ScreenshotbotDemoTests/WorkingSnapshotTests.swift.bak

        # Run tests
        xcodebuild test -scheme ScreenshotbotDemo -destination 'platform=iOS Simulator,name=iPhone 16 Pro' -only-testing:ScreenshotbotDemoTests/WorkingSnapshotTests
        ;;

    "single")
        if [ -z "$2" ]; then
            echo "❌ Please specify a test method name"
            echo "Usage: ./run_snapshot_tests.sh single <testMethodName>"
            echo "Example: ./run_snapshot_tests.sh single contentViewSnapshot"
            exit 1
        fi

        echo "🎯 Running single test: $2"
        xcodebuild test -scheme ScreenshotbotDemo -destination 'platform=iOS Simulator,name=iPhone 16 Pro' -only-testing:ScreenshotbotDemoTests/WorkingSnapshotTests/$2
        ;;

    *)
        echo "Usage: ./run_snapshot_tests.sh [record|verify|single <testName>]"
        echo ""
        echo "Commands:"
        echo "  record  - Generate new snapshots (sets RECORD_MODE = true)"
        echo "  verify  - Test against existing snapshots (sets RECORD_MODE = false)"
        echo "  single  - Run a single test method"
        echo ""
        echo "Examples:"
        echo "  ./run_snapshot_tests.sh record"
        echo "  ./run_snapshot_tests.sh verify"
        echo "  ./run_snapshot_tests.sh single contentViewSnapshot"
        ;;
esac
