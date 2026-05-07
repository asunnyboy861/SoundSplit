import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        ProfileListView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: VolumeProfile.self, inMemory: true)
}
