import Testing
import SwiftUI
import SnapshotTesting
@testable import ScreenshotbotDemo

// MARK: - Simple Working Tests for ScreenshotBot Demo
@MainActor
struct SimpleWorkingTests {
    
    @Test("Basic Text Snapshot")
    func basicTextSnapshot() async throws {
        let view = Text("ScreenshotBot Demo")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .padding()
        
        withSnapshotTesting(record: .all) {
            assertSnapshot(of: view, as: .image)
        }
    }
    
    @Test("Dashboard Card Demo")
    func dashboardCardSnapshot() async throws {
        let view = VStack(spacing: 16) {
            Text("Dashboard")
                .font(.title)
                .fontWeight(.bold)
            
            HStack(spacing: 12) {
                VStack {
                    Text("$24,567")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Revenue")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
                
                VStack {
                    Text("1,234")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Orders")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            }
        }
        .padding()
        .frame(width: 350, height: 200)
        
        withSnapshotTesting(record: .all) {
            assertSnapshot(of: view, as: .image)
        }
    }
    
    @Test("Product List Demo")
    func productListSnapshot() async throws {
        let view = VStack(spacing: 12) {
            Text("Products")
                .font(.title)
                .fontWeight(.bold)
            
            ForEach(0..<3) { index in
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Product \(index + 1)")
                            .font(.headline)
                        Text("$\((index + 1) * 10).99")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button("Buy") {
                        // Action
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .frame(width: 350, height: 250)
        
        withSnapshotTesting(record: .all) {
            assertSnapshot(of: view, as: .image)
        }
    }
    
    @Test("Settings Demo - Dark Mode")
    func settingsDarkModeSnapshot() async throws {
        let view = VStack(spacing: 16) {
            Text("Settings")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: "person.circle")
                        .foregroundColor(.blue)
                    Text("Account")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
                
                HStack {
                    Image(systemName: "bell")
                        .foregroundColor(.orange)
                    Text("Notifications")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
                
                HStack {
                    Image(systemName: "moon")
                        .foregroundColor(.purple)
                    Text("Dark Mode")
                    Spacer()
                    Toggle("", isOn: .constant(true))
                }
                .padding()
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .padding()
        .frame(width: 350, height: 300)
        .preferredColorScheme(.dark)
        
        withSnapshotTesting(record: .all) {
            assertSnapshot(of: view, as: .image)
        }
    }
    
    @Test("App Icon Style Demo")
    func appIconSnapshot() async throws {
        let view = VStack(spacing: 20) {
            // App icon style design
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                
                Image(systemName: "camera.viewfinder")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
            }
            
            Text("ScreenshotBot")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Beautiful screenshots, automatically")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 250, height: 250)
        
        withSnapshotTesting(record: .all) {
            assertSnapshot(of: view, as: .image)
        }
    }
}