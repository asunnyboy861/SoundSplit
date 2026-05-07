import SwiftUI

struct ProfileCardView: View {
    let profile: VolumeProfile
    let isActive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: profile.iconName)
                    .font(.title3)
                    .foregroundStyle(isActive ? .blue : .primary)
                Spacer()
                if isActive {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                }
            }

            Text(profile.name)
                .font(.headline)
                .lineLimit(1)

            VStack(spacing: 4) {
                miniVolumeRow(label: "R", value: profile.ringerVolume)
                miniVolumeRow(label: "M", value: profile.mediaVolume)
                miniVolumeRow(label: "C", value: profile.callVolume)
            }
        }
        .padding()
        .background(isActive ? Color.blue.opacity(0.08) : Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isActive ? Color.blue : Color.clear, lineWidth: 2)
        )
    }

    private func miniVolumeRow(label: String, value: Float) -> some View {
        HStack(spacing: 4) {
            Text(label)
                .font(.caption2.bold())
                .foregroundStyle(.secondary)
                .frame(width: 12)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(.systemGray5))
                    RoundedRectangle(cornerRadius: 2)
                        .fill(isActive ? Color.blue : Color.gray)
                        .frame(width: geo.size.width * CGFloat(value))
                }
            }
            .frame(height: 4)
            Text("\(Int(value * 100))")
                .font(.caption2.monospacedDigit())
                .foregroundStyle(.secondary)
                .frame(width: 22, alignment: .trailing)
        }
    }
}
