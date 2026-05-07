import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String

    private let icons = [
        "house.fill", "building.2.fill", "bed.double.fill", "sun.max.fill",
        "speaker.wave.2.fill", "bell.fill", "music.note", "gamecontroller.fill",
        "book.fill", "figure.run", "briefcase.fill", "car.fill",
        "airplane", "heart.fill", "star.fill", "leaf.fill",
        "drop.fill", "flame.fill", "snowflake", "bolt.fill"
    ]

    let columns = [GridItem(.adaptive(minimum: 44))]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(icons, id: \.self) { icon in
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: 44, height: 44)
                    .background(selectedIcon == icon ? Color.blue.opacity(0.15) : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selectedIcon == icon ? Color.blue : Color(.systemGray4), lineWidth: selectedIcon == icon ? 2 : 1)
                    )
                    .onTapGesture {
                        selectedIcon = icon
                    }
            }
        }
    }
}
