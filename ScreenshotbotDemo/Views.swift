//
//  Views.swift
//  ScreenshotbotDemo
//
//  Created by kanagasabapathy on 02.08.25.
//

import SwiftUI

// MARK: - Products View

struct ProductsView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    @State private var showFavorites = false

    let categories = ["All", "Electronics", "Clothing", "Books", "Home"]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Search products...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10)
                .padding()

                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            CategoryChip(
                                title: category,
                                isSelected: selectedCategory == category
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Products Grid
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                        ForEach(filteredProducts, id: \.id) { product in
                            ProductCard(product: product)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showFavorites.toggle() }) {
                        Image(systemName: showFavorites ? "heart.fill" : "heart")
                            .foregroundColor(showFavorites ? .red : .gray)
                    }
                }
            }
        }
    }

    var filteredProducts: [Product] {
        let categoryFiltered = selectedCategory == "All" ? sampleProducts : sampleProducts.filter { $0.category == selectedCategory }

        if searchText.isEmpty {
            return showFavorites ? categoryFiltered.filter { $0.isFavorite } : categoryFiltered
        } else {
            let searchFiltered = categoryFiltered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            return showFavorites ? searchFiltered.filter { $0.isFavorite } : searchFiltered
        }
    }
}

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct ProductCard: View {
    let product: Product
    @State private var isFavorited = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product Image Placeholder
            RoundedRectangle(cornerRadius: 12)
                .fill(product.color.opacity(0.3))
                .frame(height: 120)
                .overlay(
                    Image(systemName: product.icon)
                        .font(.system(size: 40))
                        .foregroundColor(product.color)
                )
                .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: { isFavorited.toggle() }) {
                                Image(systemName: isFavorited || product.isFavorite ? "heart.fill" : "heart")
                                    .font(.system(size: 16))
                                    .foregroundColor(isFavorited || product.isFavorite ? .red : .gray)
                                    .background(Circle().fill(.white).frame(width: 28, height: 28))
                            }
                        }
                        Spacer()
                    }
                    .padding(8)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)

                Text(product.category)
                    .font(.caption)
                    .foregroundColor(.secondary)

                HStack {
                    Text(product.price)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Spacer()

                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", product.rating))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .onAppear {
            isFavorited = product.isFavorite
        }
    }
}

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let price: String
    let rating: Double
    let icon: String
    let color: Color
    let isFavorite: Bool
}

let sampleProducts: [Product] = [
    Product(name: "iPhone 15 Pro", category: "Electronics", price: "$999", rating: 4.8, icon: "iphone", color: .blue, isFavorite: true),
    Product(name: "MacBook Air", category: "Electronics", price: "$1299", rating: 4.7, icon: "laptopcomputer", color: .gray, isFavorite: false),
    Product(name: "Cotton T-Shirt", category: "Clothing", price: "$29", rating: 4.3, icon: "tshirt.fill", color: .green, isFavorite: true),
    Product(name: "Swift Programming", category: "Books", price: "$49", rating: 4.9, icon: "book.fill", color: .orange, isFavorite: false),
    Product(name: "Coffee Mug", category: "Home", price: "$19", rating: 4.2, icon: "cup.and.saucer.fill", color: .brown, isFavorite: false),
    Product(name: "AirPods Pro", category: "Electronics", price: "$249", rating: 4.6, icon: "airpods.pro", color: .blue, isFavorite: true),
    Product(name: "Denim Jeans", category: "Clothing", price: "$79", rating: 4.4, icon: "tshirt.fill", color: .indigo, isFavorite: false),
    Product(name: "Cooking Guide", category: "Books", price: "$35", rating: 4.5, icon: "book.fill", color: .red, isFavorite: true),
    Product(name: "Table Lamp", category: "Home", price: "$89", rating: 4.1, icon: "lamp.desk.fill", color: .yellow, isFavorite: false),
    Product(name: "iPad Pro", category: "Electronics", price: "$1099", rating: 4.8, icon: "ipad", color: .purple, isFavorite: false)
]

// MARK: - Profile View

struct ProfileView: View {
    @State private var isEditing = false
    @State private var userName = "John Doe"
    @State private var userEmail = "john.doe@example.com"
    @State private var userBio = "iOS Developer passionate about creating beautiful apps"

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    VStack(spacing: 16) {
                        // Profile Image
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 120, height: 120)

                            Text("JD")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .shadow(color: .black.opacity(0.1), radius: 5)
                        )

                        if isEditing {
                            VStack(spacing: 12) {
                                TextField("Name", text: $userName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())

                                TextField("Email", text: $userEmail)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.emailAddress)

                                TextField("Bio", text: $userBio, axis: .vertical)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .lineLimit(3, reservesSpace: true)
                            }
                            .padding(.horizontal)
                        } else {
                            VStack(spacing: 8) {
                                Text(userName)
                                    .font(.title2)
                                    .fontWeight(.bold)

                                Text(userEmail)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Text(userBio)
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top)

                    // Stats Section
                    HStack(spacing: 40) {
                        StatItem(title: "Posts", value: "127")
                        StatItem(title: "Followers", value: "1.2K")
                        StatItem(title: "Following", value: "456")
                    }
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Achievements Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Achievements")
                            .font(.headline)
                            .padding(.horizontal)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                            AchievementBadge(icon: "star.fill", title: "First Post", color: .yellow, isUnlocked: true)
                            AchievementBadge(icon: "heart.fill", title: "100 Likes", color: .red, isUnlocked: true)
                            AchievementBadge(icon: "person.2.fill", title: "1K Followers", color: .blue, isUnlocked: true)
                            AchievementBadge(icon: "flame.fill", title: "Streak Master", color: .orange, isUnlocked: false)
                            AchievementBadge(icon: "crown.fill", title: "Top Creator", color: .purple, isUnlocked: false)
                            AchievementBadge(icon: "trophy.fill", title: "Champion", color: .gold, isUnlocked: false)
                        }
                        .padding(.horizontal)
                    }

                    // Recent Activity
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Activity")
                            .font(.headline)
                            .padding(.horizontal)

                        VStack(spacing: 12) {
                            ActivityItemProfile(icon: "camera.fill", title: "Posted a new photo", time: "2 hours ago", color: .green)
                            ActivityItemProfile(icon: "heart.fill", title: "Liked 5 posts", time: "4 hours ago", color: .red)
                            ActivityItemProfile(icon: "message.fill", title: "Commented on a post", time: "6 hours ago", color: .blue)
                            ActivityItemProfile(icon: "person.badge.plus", title: "Followed 3 users", time: "1 day ago", color: .purple)
                        }
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }

                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share Profile")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }

                        Button(action: {}) {
                            HStack {
                                Image(systemName: "gear")
                                Text("Account Settings")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isEditing.toggle()
                        }
                    }
                }
            }
        }
    }
}

struct StatItem: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct AchievementBadge: View {
    let icon: String
    let title: String
    let color: Color
    let isUnlocked: Bool

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(isUnlocked ? color.opacity(0.2) : Color.gray.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(isUnlocked ? color : .gray)
                )
                .overlay(
                    Circle()
                        .stroke(isUnlocked ? color.opacity(0.3) : Color.gray.opacity(0.3), lineWidth: 2)
                )

            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(isUnlocked ? .primary : .secondary)
        }
        .opacity(isUnlocked ? 1.0 : 0.6)
    }
}

struct ActivityItemProfile: View {
    let icon: String
    let title: String
    let time: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 32, height: 32)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 14))
                        .foregroundColor(color)
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
    }
}

extension Color {
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
}

// MARK: - Settings View

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var faceIDEnabled = true
    @State private var autoSyncEnabled = true
    @State private var selectedLanguage = "English"
    @State private var selectedTheme = "Blue"
    @State private var cacheSize = "245 MB"
    @State private var showingDeleteAlert = false

    let languages = ["English", "Spanish", "French", "German", "Japanese"]
    let themes = ["Blue", "Purple", "Green", "Orange", "Red"]

    var body: some View {
        NavigationView {
            List {
                // Account Section
                Section("Account") {
                    SettingsRow(
                        icon: "person.circle.fill",
                        title: "Edit Profile",
                        subtitle: "Update your profile information",
                        iconColor: .blue
                    ) {}

                    SettingsRow(
                        icon: "key.fill",
                        title: "Change Password",
                        subtitle: "Update your password",
                        iconColor: .orange
                    ) {}

                    SettingsRow(
                        icon: "creditcard.fill",
                        title: "Payment Methods",
                        subtitle: "Manage payment options",
                        iconColor: .green
                    ) {}
                }

                // Privacy & Security
                Section("Privacy & Security") {
                    SettingsToggle(
                        icon: "faceid",
                        title: "Face ID",
                        subtitle: "Use Face ID to unlock the app",
                        iconColor: .red,
                        isOn: $faceIDEnabled
                    )

                    SettingsRow(
                        icon: "lock.shield.fill",
                        title: "Privacy Settings",
                        subtitle: "Control who can see your data",
                        iconColor: .purple
                    ) {}

                    SettingsRow(
                        icon: "exclamationmark.shield.fill",
                        title: "Security Checkup",
                        subtitle: "Review your security settings",
                        iconColor: .red
                    ) {}
                }

                // Notifications
                Section("Notifications") {
                    SettingsToggle(
                        icon: "bell.fill",
                        title: "Push Notifications",
                        subtitle: "Receive push notifications",
                        iconColor: .blue,
                        isOn: $notificationsEnabled
                    )

                    SettingsRow(
                        icon: "envelope.fill",
                        title: "Email Notifications",
                        subtitle: "Configure email preferences",
                        iconColor: .gray
                    ) {}
                }

                // Appearance
                Section("Appearance") {
                    SettingsToggle(
                        icon: "moon.fill",
                        title: "Dark Mode",
                        subtitle: "Use dark appearance",
                        iconColor: .indigo,
                        isOn: $darkModeEnabled
                    )

                    SettingsPicker(
                        icon: "paintbrush.fill",
                        title: "Theme",
                        subtitle: "Choose app theme",
                        iconColor: .pink,
                        selection: $selectedTheme,
                        options: themes
                    )
                }

                // Data & Storage
                Section("Data & Storage") {
                    SettingsToggle(
                        icon: "arrow.triangle.2.circlepath",
                        title: "Auto Sync",
                        subtitle: "Automatically sync data",
                        iconColor: .cyan,
                        isOn: $autoSyncEnabled
                    )

                    SettingsRow(
                        icon: "internaldrive.fill",
                        title: "Storage",
                        subtitle: "Cache: \(cacheSize)",
                        iconColor: .yellow
                    ) {}

                    SettingsRow(
                        icon: "trash.fill",
                        title: "Clear Cache",
                        subtitle: "Free up space",
                        iconColor: .red
                    ) {
                        showingDeleteAlert = true
                    }
                }

                // General
                Section("General") {
                    SettingsPicker(
                        icon: "globe",
                        title: "Language",
                        subtitle: "Choose your language",
                        iconColor: .green,
                        selection: $selectedLanguage,
                        options: languages
                    )

                    SettingsRow(
                        icon: "questionmark.circle.fill",
                        title: "Help & Support",
                        subtitle: "Get help and contact support",
                        iconColor: .blue
                    ) {}

                    SettingsRow(
                        icon: "doc.text.fill",
                        title: "Terms of Service",
                        subtitle: "Read our terms",
                        iconColor: .gray
                    ) {}

                    SettingsRow(
                        icon: "hand.raised.fill",
                        title: "Privacy Policy",
                        subtitle: "Read our privacy policy",
                        iconColor: .gray
                    ) {}
                }

                // About
                Section("About") {
                    SettingsRow(
                        icon: "info.circle.fill",
                        title: "Version",
                        subtitle: "1.0.0 (Build 123)",
                        iconColor: .blue
                    ) {}

                    SettingsRow(
                        icon: "star.fill",
                        title: "Rate App",
                        subtitle: "Rate us in the App Store",
                        iconColor: .yellow
                    ) {}
                }

                // Danger Zone
                Section("Account Actions") {
                    SettingsRow(
                        icon: "rectangle.portrait.and.arrow.right.fill",
                        title: "Sign Out",
                        subtitle: nil,
                        iconColor: .orange
                    ) {}

                    SettingsRow(
                        icon: "trash.fill",
                        title: "Delete Account",
                        subtitle: "Permanently delete your account",
                        iconColor: .red
                    ) {}
                }
            }
            .navigationTitle("Settings")
        }
        .alert("Clear Cache", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Clear", role: .destructive) {
                cacheSize = "0 MB"
            }
        } message: {
            Text("This will clear all cached data and free up \(cacheSize) of storage.")
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let subtitle: String?
    let iconColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(iconColor)
                    .frame(width: 24, height: 24)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .foregroundColor(.primary)
                        .fontWeight(.medium)

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SettingsToggle: View {
    let icon: String
    let title: String
    let subtitle: String
    let iconColor: Color
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(iconColor)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .fontWeight(.medium)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Toggle("", isOn: $isOn)
        }
    }
}

struct SettingsPicker: View {
    let icon: String
    let title: String
    let subtitle: String
    let iconColor: Color
    @Binding var selection: String
    let options: [String]

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(iconColor)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .fontWeight(.medium)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
}
