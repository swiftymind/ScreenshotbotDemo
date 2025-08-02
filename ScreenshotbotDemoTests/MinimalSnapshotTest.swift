import Testing
import SwiftUI
import SnapshotTesting

// MARK: - Minimal Test That Should Always Work
@MainActor
struct MinimalSnapshotTest {
    
    @Test("Simple Text View")
    func simpleTextSnapshot() async throws {
        let view = Text("Hello ScreenshotBot!")
            .font(.title)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        
        withSnapshotTesting(record: .all) {
            assertSnapshot(of: view, as: .image)
        }
    }
    
    @Test("Simple VStack")
    func simpleVStackSnapshot() async throws {
        let view = VStack(spacing: 20) {
            Text("ScreenshotBot Demo")
                .font(.title)
                .fontWeight(.bold)
            
            Text("This is a simple test")
                .font(.body)
            
            Button("Test Button") {
                // Action
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(width: 300, height: 200)
        
        withSnapshotTesting(record: .all) {
            assertSnapshot(of: view, as: .image)
        }
    }
}