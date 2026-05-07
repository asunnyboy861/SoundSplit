import SwiftUI
import SwiftData

@main
struct SoundSplitApp: App {
    var body: some Scene {
        WindowGroup {
            ProfileListView()
        }
        .modelContainer(for: VolumeProfile.self)
    }
}
