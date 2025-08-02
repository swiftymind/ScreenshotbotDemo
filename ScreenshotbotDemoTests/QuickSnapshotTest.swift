import Testing
import SwiftUI
import SnapshotTesting
@testable import ScreenshotbotDemo

// MARK: - Quick Single Snapshot Test
@MainActor
struct QuickSnapshotTest {

        @Test("Generate ContentView Snapshot") 
    func generateContentViewSnapshot() async throws {
        let view = ContentView()
        
        // Always record in CI for ScreenshotBot demo
        if ProcessInfo.processInfo.environment["CI"] != nil {
            withSnapshotTesting(record: .all) {
                assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
            }
        } else {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
        }
    }
}