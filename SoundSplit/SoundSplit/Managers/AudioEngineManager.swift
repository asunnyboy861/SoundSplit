import Foundation
import Observation

@Observable
final class AudioEngineManager {
    static let shared = AudioEngineManager()

    var currentRingerVolume: Float = 0.8
    var currentMediaVolume: Float = 0.5
    var currentCallVolume: Float = 0.7

    private init() {}

    func applyProfile(_ profile: VolumeProfile) {
        setRingerVolume(profile.ringerVolume)
        setMediaVolume(profile.mediaVolume)
        currentRingerVolume = profile.ringerVolume
        currentMediaVolume = profile.mediaVolume
        currentCallVolume = profile.callVolume
    }

    func setRingerVolume(_ volume: Float) {
        let clamped = max(0.0, min(1.0, volume))
        currentRingerVolume = clamped
    }

    func setMediaVolume(_ volume: Float) {
        let clamped = max(0.0, min(1.0, volume))
        currentMediaVolume = clamped
    }

    func setCallVolume(_ volume: Float) {
        let clamped = max(0.0, min(1.0, volume))
        currentCallVolume = clamped
    }

    func muteAll() {
        currentRingerVolume = 0.0
        currentMediaVolume = 0.0
        currentCallVolume = 0.0
    }

    func maxAll() {
        currentRingerVolume = 1.0
        currentMediaVolume = 1.0
        currentCallVolume = 1.0
    }
}
