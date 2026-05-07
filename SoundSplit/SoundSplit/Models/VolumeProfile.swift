import SwiftData
import Foundation

@Model
final class VolumeProfile {
    @Attribute(.unique) var id: UUID
    var name: String
    var iconName: String
    var ringerVolume: Float
    var mediaVolume: Float
    var callVolume: Float
    var isDefault: Bool
    var createdAt: Date
    var order: Int

    init(
        name: String,
        iconName: String = "speaker.wave.2",
        ringerVolume: Float = 0.8,
        mediaVolume: Float = 0.5,
        callVolume: Float = 0.7,
        isDefault: Bool = false
    ) {
        self.id = UUID()
        self.name = name
        self.iconName = iconName
        self.ringerVolume = ringerVolume
        self.mediaVolume = mediaVolume
        self.callVolume = callVolume
        self.isDefault = isDefault
        self.createdAt = Date()
        self.order = 0
    }
}
