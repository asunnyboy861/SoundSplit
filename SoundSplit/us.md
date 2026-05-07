# SoundSplit - iOS Development Guide

## Executive Summary

SoundSplit is a volume profile management app for iPhone that solves the critical pain point of iOS having a single unified volume control for ringer, notifications, and alarms. By creating switchable volume profiles with deep system integrations (Focus Mode, Shortcuts, Control Center, Dynamic Island), SoundSplit delivers the separate volume control experience that 1 billion+ iPhone users desperately need but Apple has never provided.

**Target Audience**: iPhone users who need different volume settings for different contexts (work, sleep, outdoor, gaming) — especially former Android users accustomed to granular volume control.

**Key Differentiators**:
- Volume Profile one-tap switching (competitors lack this)
- Deep Focus Mode integration for automatic profile switching
- Control Center widget for instant access without opening the app
- Dynamic Island / Live Activities for at-a-glance volume awareness
- Per-App automatic volume rules
- Custom notification sound levels via pre-rendered audio files

## Competitive Analysis

| App | Price | Rating | Strengths | Weaknesses | Our Advantage |
|-----|-------|--------|-----------|------------|---------------|
| Master of Volume Control | $0.99 | 5.0 (2 ratings) | Focus integration, Shortcuts, Control Center widget | Only 2 ratings, Chinese developer, limited UI polish | Better UI, more profiles, Live Activities, per-app rules |
| Volume Master | Free+IAP | 4.2 (142 ratings) | Simple, favorite volumes, widget | No profile concept, no Focus integration, no automation | Full profile system, Focus Mode, Shortcuts, Dynamic Island |
| volumeCTRL | $4.99 | 3.3 (7 ratings) | Precise dBFS control, fine-grained steps | No profiles, no automation, utility-only approach | Profile management, automation, system integrations |
| Sasha Volume Control | Free+$3.99 Pro | 4.5 | 100-level precision, Widget, Live Activities | No volume profile switching, no Focus integration | Profile switching, Focus Mode, per-app rules |
| Volume Blocker and Limiter | Free+IAP | 5.0 (1 rating) | Volume limiting for kids, pin protection | Niche use case, no profiles, no automation | Broader appeal, profile system, automation features |

## Apple Design Guidelines Compliance

- **Clarity**: Each screen serves one purpose — profile list, profile editing, or quick actions
- **Deference**: Content-first design with system-standard controls (sliders, toggles)
- **Depth**: Clear navigation hierarchy with iOS-native slide transitions
- **Consistency**: Follows iOS Settings app visual language for familiarity
- **Direct Manipulation**: Volume sliders provide immediate visual and audio feedback
- **Audio Session Categories**: Uses `.playback` for ringer control, `.ambient` for media control per Apple HIG
- **MPVolumeView**: Uses system-provided volume view for media volume adjustments per Apple guidelines
- **Focus Filter API**: Implements `FocusFilterIntent` for legitimate Focus Mode integration
- **AppIntents**: Provides Shortcuts integration with clear, descriptive intent phrases

## Technical Architecture

- **Language**: Swift 5.9+
- **Framework**: SwiftUI (primary)
- **Data**: SwiftData with `@Model` classes
- **Audio**: AVAudioSession + AVAudioPlayer + MPVolumeView
- **Notifications**: UserNotifications framework
- **Automation**: AppIntents framework (Shortcuts + Focus Filter)
- **Widgets**: WidgetKit (Home Screen + Control Center)
- **Live Activities**: ActivityKit + Dynamic Island
- **Monetization**: StoreKit 2 (Subscription IAP)

## Module Structure

```
SoundSplit/
├── App/
│   ├── SoundSplitApp.swift
│   └── AppDelegate.swift
├── Models/
│   ├── VolumeProfile.swift
│   ├── CustomNotificationSound.swift
│   └── AppVolumeRule.swift
├── Managers/
│   ├── AudioEngineManager.swift
│   ├── ProfileManager.swift
│   ├── NotificationSoundManager.swift
│   ├── MuteManager.swift
│   └── PurchaseManager.swift
├── Views/
│   ├── Main/
│   │   ├── ProfileListView.swift
│   │   ├── ProfileCardView.swift
│   │   └── QuickActionsView.swift
│   ├── Edit/
│   │   ├── ProfileEditView.swift
│   │   ├── VolumeSliderView.swift
│   │   └── IconPickerView.swift
│   ├── Onboarding/
│   │   └── OnboardingView.swift
│   ├── Settings/
│   │   ├── SettingsView.swift
│   │   └── ContactSupportView.swift
│   └── Paywall/
│       └── PaywallView.swift
├── Intents/
│   ├── SwitchVolumeProfileIntent.swift
│   ├── GetVolumeProfileIntent.swift
│   ├── VolumeFocusFilter.swift
│   └── VolumeProfileShortcutProvider.swift
├── Widgets/
│   ├── SoundSplitWidget.swift
│   ├── SoundSplitControlWidget.swift
│   └── SoundSplitLiveActivity.swift
├── Resources/
│   ├── Assets.xcassets
│   └── Sounds/
│       ├── silence.caf
│       ├── alert_whisper.caf
│       ├── alert_soft.caf
│       ├── alert_normal.caf
│       ├── alert_loud.caf
│       └── alert_maximum.caf
└── Info.plist
```

## Implementation Flow

1. Create Xcode project with SwiftUI + SwiftData, configure bundle ID and deployment target
2. Implement VolumeProfile, CustomNotificationSound, AppVolumeRule SwiftData models
3. Implement AudioEngineManager for volume control (AVAudioSession + MPVolumeView)
4. Implement ProfileManager for profile CRUD and active profile tracking
5. Implement main ProfileListView with current profile card and profile grid
6. Implement ProfileEditView with volume sliders and icon picker
7. Implement QuickActionsView (mute all, max volume, temporary volume)
8. Implement OnboardingView (3-step onboarding flow)
9. Implement AppIntents (SwitchVolumeProfileIntent, GetVolumeProfileIntent)
10. Implement VolumeFocusFilter for Focus Mode integration
11. Implement Control Center widgets and Home Screen widgets
12. Implement Live Activity and Dynamic Island
13. Implement PurchaseManager with StoreKit 2
14. Implement PaywallView with subscription options
15. Implement SettingsView with policy links, contact support, restore purchases
16. Implement ContactSupportView with feedback backend
17. Test on iPhone and iPad simulators
18. Push to GitHub and deploy policy pages

## UI/UX Design Specifications

- **Color Scheme**: System standard colors (Blue primary, Green success, Orange warning, Red danger)
- **Light Mode Background**: #F2F2F7 (systemGroupedBackground)
- **Dark Mode Background**: #000000 (pure black for OLED)
- **Card Background**: White (#FFFFFF) in light, #1C1C1E in dark
- **Typography**: SF Pro system font, standard iOS type scale
- **Layout**: 2-column profile grid, single-column edit form
- **iPad Layout**: Max width 720pt for content, centered
- **Animations**: Profile switch 0.3s easeInOut, slider 0.15s linear, toggle 0.2s spring
- **Tab Bar**: Profiles (main), Automate (shortcuts/focus), Settings

## Code Generation Rules

- Single responsibility: one feature per module
- MVVM pattern: View + ViewModel for each screen
- SwiftData models with `@Model`, unique UUID, explicit delete rules
- All SwiftData attributes must be optional or have default values
- No hardcoded colors — use Asset Catalog or system colors
- No comments in code unless asked
- Use `@Environment` for dependency injection
- Error handling with typed throws and custom Error enums
- Audio operations: async after main thread check, `.caf` format for sounds
- Permission requests: explain before asking, guide after denial

## Build & Deployment Checklist

- [ ] Bundle ID: com.zzoutuo.SoundSplit
- [ ] Deployment Target: iOS 17.0
- [ ] Swift Language Version: 5.0+
- [ ] Background Modes: Audio enabled
- [ ] App Intents capability configured
- [ ] Push Notifications capability configured
- [ ] StoreKit 2 subscription configured
- [ ] App Icon generated and added to Asset Catalog
- [ ] Build succeeds on iPhone simulator
- [ ] Build succeeds on iPad simulator
- [ ] No API keys or secrets in source code
- [ ] Policy pages deployed to GitHub Pages
- [ ] SettingsView links to policy pages
- [ ] Contact support functional
- [ ] IAP subscription flow tested
