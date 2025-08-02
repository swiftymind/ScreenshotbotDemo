import Testing
import SwiftUI
import SnapshotTesting
@testable import ScreenshotbotDemo

/// Simple working snapshot tests for ScreenshotBot demo
/// Change RECORD_MODE to true/false to control recording vs verification
@MainActor
struct WorkingSnapshotTests {

    // 🎛️ RECORD MODE: Always record in CI for ScreenshotBot demo
    private let RECORD_MODE = ProcessInfo.processInfo.environment["CI"] != nil

    @Test("ContentView Snapshot")
    func contentViewSnapshot() async throws {
        let view = ContentView()

        if RECORD_MODE {
            withSnapshotTesting(record: .all) {
                assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
            }
        } else {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
        }
    }

    @Test("ContentView Dark Mode")
    func contentViewDarkMode() async throws {
        let view = ContentView()
            .preferredColorScheme(.dark)

        if RECORD_MODE {
            withSnapshotTesting(record: .all) {
                assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
            }
        } else {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
        }
    }

    @Test("Settings View Dark Mode")
    func settingsViewDarkMode() async throws {
        let view = SettingsView()
            .preferredColorScheme(.dark)

        if RECORD_MODE {
            withSnapshotTesting(record: .all) {
                assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
            }
        } else {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
        }
    }

    @Test("Dashboard View")
    func dashboardViewSnapshot() async throws {
        let view = DashboardView()

        if RECORD_MODE {
            withSnapshotTesting(record: .all) {
                assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
            }
        } else {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
        }
    }

    @Test("Products View")
    func productsViewSnapshot() async throws {
        let view = ProductsView()

        if RECORD_MODE {
            withSnapshotTesting(record: .all) {
                assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
            }
        } else {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13ProMax)))
        }
    }

    @Test("MetricCard Component")
    func metricCardSnapshot() async throws {
        let view = MetricCard(
            title: "Total Revenue",
            value: "$24,567",
            trend: "+12.5%",
            color: .green
        )
        .frame(width: 300, height: 120)
        .padding()

        if RECORD_MODE {
            withSnapshotTesting(record: .all) {
                assertSnapshot(of: view, as: .image)
            }
        } else {
            assertSnapshot(of: view, as: .image)
        }
    }
}