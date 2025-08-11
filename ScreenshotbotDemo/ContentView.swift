//
//  ContentView.swift
//  ScreenshotbotDemo
//
//  Created by kanagasabapathy on 02.08.25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            ProductsView()
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Products")
                }
                .tag(1)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(2)

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}

struct DashboardView: View {
    @State private var isNotificationsEnabled = true
    @State private var selectedMetric = "Revenue"

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header Section
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Welcome back!")
                                .font(.title2)
                                .foregroundColor(.secondary)
                            Text("John Doe")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        Spacer()

                        Button(action: {}) {
                            Image(systemName: "bell.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .overlay(
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 10, height: 10)
                                        .offset(x: 8, y: -8)
                                )
                        }
                    }
                    .padding(.horizontal)

                    // Metrics Cards
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                        MetricCard(title: "Total Sales", value: "$12,345", trend: "+12%", color: .green)
                        MetricCard(title: "New Users", value: "1,234", trend: "+8%", color: .blue)
                        MetricCard(title: "Revenue", value: "$45,678", trend: "+15%", color: .purple)
                        MetricCard(title: "Orders", value: "567", trend: "-2%", color: .orange)
                    }
                    .padding(.horizontal)

                    // Chart Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Analytics")
                                .font(.headline)
                            Spacer()
                            Picker("Metric", selection: $selectedMetric) {
                                Text("Revenue").tag("Revenue")
                                Text("Users").tag("Users")
                                Text("Orders").tag("Orders")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 200)
                        }

                        SimpleChartView(selectedMetric: selectedMetric)
                    }
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Recent Activity
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Activity")
                            .font(.headline)
                            .padding(.horizontal)

                        ForEach(0..<5) { index in
                            ActivityRow(
                                icon: ["cart.fill", "person.badge.plus", "creditcard.fill", "bell.fill", "star.fill"][index],
                                title: ["New Order #1234", "User Registration", "Payment Received", "System Alert", "5-Star Review"][index],
                                time: ["\(index + 1)m ago", "\(index + 2)m ago", "\(index + 5)m ago", "\(index + 10)m ago", "\(index + 15)m ago"][index],
                                color: [.green, .blue, .purple, .orange, .yellow][index]
                            )
                        }
                    }
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let trend: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Image(systemName: trend.hasPrefix("+") ? "arrow.up.right" : "arrow.down.right")
                    .font(.caption)
                    .foregroundColor(trend.hasPrefix("+") ? .green : .red)
            }

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(trend)
                .font(.caption)
                .foregroundColor(trend.hasPrefix("+") ? .green : .red)
        }
        .padding()
        .background(color.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

struct SimpleChartView: View {
    let selectedMetric: String
    @State private var animateChart = false

    var data: [Double] {
        switch selectedMetric {
        case "Revenue": return [30, 45, 35, 60, 55, 70, 65]
        case "Users": return [20, 35, 25, 45, 40, 55, 50]
        default: return [15, 25, 20, 35, 30, 40, 35]
        }
    }

    var body: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(0..<data.count, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue.opacity(0.7))
                        .frame(width: 30, height: animateChart ? data[index] * 2 : 0)
                        .animation(.easeInOut(duration: 0.8).delay(Double(index) * 0.1), value: animateChart)
                }
            }
            .frame(height: 150)

            HStack {
                ForEach(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(width: 30)
                }
            }
        }
        .onAppear {
            animateChart = true
        }
        .onChange(of: selectedMetric) { oldValue, newValue in
            animateChart = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animateChart = true
            }
        }
    }
}

struct ActivityRow: View {
    let icon: String
    let title: String
    let time: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 16, weight: .medium))
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
