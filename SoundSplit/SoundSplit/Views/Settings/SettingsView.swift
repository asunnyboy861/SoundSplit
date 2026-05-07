import SwiftUI

struct SettingsView: View {
    @State private var purchaseManager = PurchaseManager.shared
    @State private var showingPaywall = false

    private let supportURL = "https://asunnyboy861.github.io/SoundSplit/support.html"
    private let privacyURL = "https://asunnyboy861.github.io/SoundSplit/privacy.html"
    private let termsURL = "https://asunnyboy861.github.io/SoundSplit/terms.html"

    var body: some View {
        Form {
            if !purchaseManager.isProUser {
                Section {
                    Button {
                        showingPaywall = true
                    } label: {
                        HStack {
                            Image(systemName: "crown.fill")
                                .foregroundStyle(.orange)
                            Text("Upgrade to Pro")
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            Section {
                NavigationLink {
                    ContactSupportView()
                } label: {
                    Label("Contact Support", systemImage: "envelope.fill")
                }
            } header: {
                Text("SUPPORT")
            }

            Section {
                Link(destination: URL(string: supportURL)!) {
                    Label("Support Page", systemImage: "questionmark.circle")
                }
                Link(destination: URL(string: privacyURL)!) {
                    Label("Privacy Policy", systemImage: "hand.raised.fill")
                }
                if purchaseManager.isProUser {
                    Link(destination: URL(string: termsURL)!) {
                        Label("Terms of Use", systemImage: "doc.text.fill")
                    }
                }
            } header: {
                Text("LEGAL")
            }

            if purchaseManager.isProUser {
                Section {
                    Button {
                        Task { await purchaseManager.restorePurchases() }
                    } label: {
                        Label("Restore Purchases", systemImage: "arrow.clockwise")
                    }
                }
            }

            Section {
                HStack {
                    Text("Version")
                    Spacer()
                    Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Settings")
        .sheet(isPresented: $showingPaywall) {
            PaywallView()
        }
    }
}
