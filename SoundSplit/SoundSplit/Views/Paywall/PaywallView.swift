import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var purchaseManager = PurchaseManager.shared
    @State private var selectedPlan: Plan = .yearly

    enum Plan { case monthly, yearly }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.orange)
                        .padding(.top, 20)

                    Text("SoundSplit Pro")
                        .font(.title.bold())

                    Text("Unlock the full power of volume control")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                    proFeaturesList

                    planSelector

                    subscribeButton

                    restoreButton

                    legalText
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    private var proFeaturesList: some View {
        VStack(alignment: .leading, spacing: 10) {
            proFeatureRow(icon: "infinity", text: "Unlimited Volume Profiles")
            proFeatureRow(icon: "moon.fill", text: "Focus Mode Auto-Switch")
            proFeatureRow(icon: "rectangle.portrait", text: "Dynamic Island & Live Activities")
            proFeatureRow(icon: "app.badge", text: "Per-App Volume Rules")
            proFeatureRow(icon: "bell.badge", text: "Custom Notification Levels")
            proFeatureRow(icon: "icloud", text: "iCloud Sync")
            proFeatureRow(icon: "clock", text: "Scheduled Profile Switching")
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func proFeatureRow(icon: String, text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(.blue)
                .frame(width: 20)
            Text(text)
                .font(.subheadline)
        }
    }

    private var planSelector: some View {
        HStack(spacing: 12) {
            planCard(plan: .monthly)
            planCard(plan: .yearly)
        }
    }

    private func planCard(plan: Plan) -> some View {
        let isSelected = selectedPlan == plan
        return Button {
            selectedPlan = plan
        } label: {
            VStack(spacing: 6) {
                if plan == .yearly {
                    Text("BEST VALUE")
                        .font(.caption2.bold())
                        .foregroundStyle(.orange)
                } else {
                    Text(" ")
                        .font(.caption2)
                }
                Text(plan == .monthly ? "Monthly" : "Yearly")
                    .font(.headline)
                Text(plan == .monthly ? "$1.99/mo" : "$9.99/yr")
                    .font(.title3.bold())
                if plan == .yearly {
                    Text("Save 58%")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isSelected ? Color.blue.opacity(0.08) : Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
    }

    private var subscribeButton: some View {
        Button {
            Task {
                let product = selectedPlan == .monthly ? purchaseManager.monthlyProduct : purchaseManager.yearlyProduct
                if let product {
                    _ = await purchaseManager.purchase(product)
                }
            }
        } label: {
            Text("Subscribe Now")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var restoreButton: some View {
        Button {
            Task { await purchaseManager.restorePurchases() }
        } label: {
            Text("Restore Purchases")
                .font(.subheadline)
                .foregroundStyle(.blue)
        }
    }

    private var legalText: some View {
        Text("Payment will be charged to your Apple ID account at confirmation of purchase. Subscription automatically renews unless it is canceled at least 24 hours before the end of the current period. You can manage and cancel your subscriptions by going to your account settings on the App Store after purchase.")
            .font(.caption2)
            .foregroundStyle(.tertiary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
    }
}
