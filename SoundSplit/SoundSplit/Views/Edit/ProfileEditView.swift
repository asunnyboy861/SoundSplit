import SwiftUI
import SwiftData

enum ProfileEditMode {
    case create
    case edit(VolumeProfile)
}

struct ProfileEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let mode: ProfileEditMode

    @State private var name: String = ""
    @State private var iconName: String = "speaker.wave.2.fill"
    @State private var ringerVolume: Float = 0.8
    @State private var mediaVolume: Float = 0.5
    @State private var callVolume: Float = 0.7

    @State private var purchaseManager = PurchaseManager.shared

    private var isEditing: Bool {
        if case .edit = mode { return true }
        return false
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Profile Name", text: $name)
                } header: {
                    Text("PROFILE NAME")
                }

                Section {
                    IconPickerView(selectedIcon: $iconName)
                } header: {
                    Text("ICON")
                }

                Section {
                    VolumeSliderView(
                        icon: "bell.fill",
                        label: "Ringer & Alerts",
                        value: $ringerVolume,
                        color: .blue
                    )
                    VolumeSliderView(
                        icon: "music.note",
                        label: "Media & Apps",
                        value: $mediaVolume,
                        color: .green
                    )
                    VolumeSliderView(
                        icon: "phone.fill",
                        label: "Phone Calls",
                        value: $callVolume,
                        color: .orange
                    )
                } header: {
                    Text("VOLUME LEVELS")
                }

                Section {
                    Button {
                        saveProfile()
                    } label: {
                        Text(isEditing ? "Save Changes" : "Create Profile")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle(isEditing ? "Edit Profile" : "New Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onAppear {
                if case .edit(let profile) = mode {
                    name = profile.name
                    iconName = profile.iconName
                    ringerVolume = profile.ringerVolume
                    mediaVolume = profile.mediaVolume
                    callVolume = profile.callVolume
                }
            }
        }
    }

    private func saveProfile() {
        switch mode {
        case .create:
            let profile = VolumeProfile(
                name: name.trimmingCharacters(in: .whitespaces),
                iconName: iconName,
                ringerVolume: ringerVolume,
                mediaVolume: mediaVolume,
                callVolume: callVolume
            )
            modelContext.insert(profile)
            try? modelContext.save()

        case .edit(let profile):
            profile.name = name.trimmingCharacters(in: .whitespaces)
            profile.iconName = iconName
            profile.ringerVolume = ringerVolume
            profile.mediaVolume = mediaVolume
            profile.callVolume = callVolume
            try? modelContext.save()
        }
        dismiss()
    }
}
