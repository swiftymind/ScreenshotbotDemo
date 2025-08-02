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
        
        // Always record for ScreenshotBot demo
        withSnapshotTesting(record: .all) {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
        }
    }
}