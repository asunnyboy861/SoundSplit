import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @Environment(\.dismiss) private var dismiss

    private let pages: [(icon: String, title: String, subtitle: String, description: String)] = [
        (
            "speaker.wave.1",
            "One volume controls all.",
            "Ringer, alerts, alarms, media — all tied together.",
            "Your iPhone has a single volume for ringer, notifications, and alarms. Turn down the ringer at work, and your alarm might not wake you up."
        ),
        (
            "speaker.wave.2",
            "SoundSplit separates them.",
            "Set different volumes for each sound category.",
            "Create volume profiles for every moment of your day. Keep your alarm loud at night but notifications quiet at work."
        ),
        (
            "square.grid.2x2",
            "Pick your first profiles.",
            "Home, Office, Sleep, Outdoor — or create your own.",
            "Switch profiles with one tap, or let Focus Mode switch them automatically. Take control of your volume."
        )
    ]

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<pages.count, id: \.self) { index in
                onboardingPage(index: index)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }

    private func onboardingPage(index: Int) -> some View {
        let page = pages[index]
        return VStack(spacing: 24) {
            Spacer()

            Image(systemName: page.icon)
                .font(.system(size: 64))
                .foregroundStyle(.blue)
                .padding(.bottom, 8)

            Text(page.title)
                .font(.title.bold())
                .multilineTextAlignment(.center)

            Text(page.subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Text(page.description)
                .font(.body)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()

            if index == pages.count - 1 {
                Button {
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                    dismiss()
                } label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 40)
            } else {
                Button {
                    withAnimation { currentPage += 1 }
                } label: {
                    Text("Next")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 40)
            }

            Spacer(minLength: 40)
        }
    }
}
