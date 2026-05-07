import SwiftData
import Foundation
import Observation

@Observable
final class ProfileManager {
    var activeProfile: VolumeProfile?

    private var modelContext: ModelContext?

    func configure(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadActiveProfile()
    }

    func switchTo(_ profile: VolumeProfile) {
        activeProfile = profile
        AudioEngineManager.shared.applyProfile(profile)
        UserDefaults.standard.set(profile.id.uuidString, forKey: "activeProfileId")
    }

    func createDefaultProfiles(modelContext: ModelContext) {
        let hasDefaults = UserDefaults.standard.bool(forKey: "hasDefaultProfiles")
        guard !hasDefaults else { return }

        let defaults: [(String, String, Float, Float, Float)] = [
            ("Home", "house.fill", 0.8, 0.6, 0.7),
            ("Office", "building.2.fill", 0.3, 0.2, 0.5),
            ("Sleep", "bed.double.fill", 0.1, 0.0, 0.3),
            ("Outdoor", "sun.max.fill", 1.0, 0.8, 0.9)
        ]

        for (index, item) in defaults.enumerated() {
            let profile = VolumeProfile(
                name: item.0,
                iconName: item.1,
                ringerVolume: item.2,
                mediaVolume: item.3,
                callVolume: item.4,
                isDefault: true
            )
            profile.order = index
            modelContext.insert(profile)
        }

        UserDefaults.standard.set(true, forKey: "hasDefaultProfiles")
        try? modelContext.save()
    }

    private func loadActiveProfile() {
        guard let modelContext else { return }
        guard let idString = UserDefaults.standard.string(forKey: "activeProfileId"),
              let uuid = UUID(uuidString: idString) else {
            let descriptor = FetchDescriptor<VolumeProfile>(sortBy: [SortDescriptor(\.order)])
            let profiles = try? modelContext.fetch(descriptor)
            if let first = profiles?.first {
                switchTo(first)
            }
            return
        }

        let id = uuid
        let descriptor = FetchDescriptor<VolumeProfile>(predicate: #Predicate { $0.id == id })
        if let profile = try? modelContext.fetch(descriptor).first {
            activeProfile = profile
            AudioEngineManager.shared.applyProfile(profile)
        }
    }
}
