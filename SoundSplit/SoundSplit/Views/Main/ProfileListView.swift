import SwiftUI
import SwiftData

struct ProfileListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \VolumeProfile.order) var profiles: [VolumeProfile]
    @State private var profileManager = ProfileManager()
    @State private var showingAddProfile = false
    @State private var showingOnboarding = false
    @State private var selectedProfile: VolumeProfile?

    init() {}

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    activeProfileCard

                    profileGrid

                    quickActionsSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("SoundSplit")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddProfile = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(isPresented: $showingAddProfile) {
                ProfileEditView(mode: .create)
            }
            .sheet(item: $selectedProfile) { profile in
                ProfileEditView(mode: .edit(profile))
            }
            .fullScreenCover(isPresented: $showingOnboarding) {
                OnboardingView()
            }
            .onAppear {
                profileManager.configure(modelContext: modelContext)
                profileManager.createDefaultProfiles(modelContext: modelContext)
                if !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
                    showingOnboarding = true
                }
            }
        }
    }

    private var activeProfileCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: profileManager.activeProfile?.iconName ?? "speaker.wave.2")
                    .font(.title2)
                    .foregroundStyle(.blue)
                Text(profileManager.activeProfile?.name ?? "Default")
                    .font(.title2.bold())
                Spacer()
            }

            VStack(spacing: 8) {
                volumeRow(icon: "bell.fill", label: "Ringer", value: profileManager.activeProfile?.ringerVolume ?? 0.8)
                volumeRow(icon: "music.note", label: "Media", value: profileManager.activeProfile?.mediaVolume ?? 0.5)
                volumeRow(icon: "phone.fill", label: "Call", value: profileManager.activeProfile?.callVolume ?? 0.7)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func volumeRow(icon: String, label: String, value: Float) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 20)
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(width: 50, alignment: .leading)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(.systemGray5))
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.blue)
                        .frame(width: geo.size.width * CGFloat(value))
                }
            }
            .frame(height: 6)
            Text("\(Int(value * 100))%")
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
                .frame(width: 35, alignment: .trailing)
        }
    }

    private var profileGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("MY PROFILES")
                .font(.footnote.bold())
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(profiles) { profile in
                    ProfileCardView(profile: profile, isActive: profileManager.activeProfile?.id == profile.id)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                profileManager.switchTo(profile)
                            }
                        }
                        .onLongPressGesture {
                            selectedProfile = profile
                        }
                }
            }
        }
    }

    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("QUICK ACTIONS")
                .font(.footnote.bold())
                .foregroundStyle(.secondary)

            VStack(spacing: 0) {
                Button {
                    withAnimation { AudioEngineManager.shared.muteAll() }
                } label: {
                    quickActionRow(icon: "speaker.slash.fill", title: "Mute All", color: .red)
                }
                Divider().padding(.leading, 44)
                Button {
                    withAnimation { AudioEngineManager.shared.maxAll() }
                } label: {
                    quickActionRow(icon: "speaker.wave.3.fill", title: "Max Volume", color: .green)
                }
            }
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private func quickActionRow(icon: String, title: String, color: Color) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 24)
            Text(title)
                .font(.body)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}
