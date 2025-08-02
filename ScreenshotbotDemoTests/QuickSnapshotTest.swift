import Testing
import SwiftUI
import SnapshotTesting
@testable import ScreenshotbotDemo

// MARK: - Quick Single Snapshot Test
@MainActor
struct QuickSnapshotTest {

        @Test("Generate ContentView Snapshot") 
    func generateContentViewSnapshot() async throws {
        // Now test against the recorded snapshot (record mode off)
        let view = ContentView()
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
    }
}
