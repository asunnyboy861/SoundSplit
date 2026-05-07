# Capabilities Configuration

## Analysis
Based on operation guide analysis:
- Volume Profile management requires audio session control → Background Modes (Audio)
- Shortcuts integration → App Intents capability
- Focus Mode integration → Focus Filter API
- Control Center widget → WidgetKit (Control Center)
- Live Activity / Dynamic Island → ActivityKit
- Subscription IAP → StoreKit 2 (In-App Purchase)
- Contact Support → Network (outgoing connections)

## Auto-Configured Capabilities

| Capability | Status | Method |
|------------|--------|--------|
| Background Modes (Audio) | ✅ Configured | Xcode project settings |
| App Intents | ✅ Configured | Code-based, auto-registered |
| In-App Purchase | ✅ Configured | StoreKit 2, code-based |
| Network (Outgoing) | ✅ Configured | Info.plist NSAllowsArbitraryLoads |

## Manual Configuration Required

| Capability | Status | Steps |
|------------|--------|-------|
| Push Notifications | ⏳ Pending | 1. Open Xcode → Signing & Capabilities → + Capability → Push Notifications. 2. Required for local notification scheduling. |
| Focus Filter API | ⏳ Pending | 1. Open Xcode → Signing & Capabilities → + Capability → App Intents. 2. FocusFilterIntent is auto-registered via code. 3. User must enable SoundSplit in Settings → Focus → [Focus Mode] → App Filters. |
| Control Center Widget | ⏳ Pending | 1. Add Widget Extension target to Xcode. 2. Implement ControlWidget protocol. 3. User adds widget via Control Center edit mode. |
| Live Activity | ⏳ Pending | 1. Add NSSupportsLiveActivities = YES to Info.plist. 2. Implement ActivityAttributes model. 3. Implement Live Activity widget. |

## No Configuration Needed

- Camera / Photo Library: Not required
- HealthKit: Not required
- Location Services: Not required
- iCloud / CloudKit: Deferred to Phase 3 (Pro feature)
- Apple Watch: Deferred to Phase 3 (Pro feature)
- Siri: Handled via AppIntents (no separate capability needed)

## Verification
- Build succeeded after configuration: ⏳ Pending (will verify after code generation)
- All entitlements correct: ⏳ Pending
