import SwiftUI

struct VolumeSliderView: View {
    let icon: String
    let label: String
    @Binding var value: Float
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)
                Text(label)
                    .font(.subheadline.bold())
                Spacer()
                Text("\(Int(value * 100))%")
                    .font(.subheadline.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
            Slider(value: $value, in: 0...1, step: 0.01) {
                Text(label)
            }
            .tint(color)
        }
    }
}
