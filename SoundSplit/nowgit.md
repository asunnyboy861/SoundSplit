# SoundSplit - NowGit

## App Overview
**SoundSplit** gives iPhone users independent control over ringer, media, and call volumes through customizable Volume Profiles.

## Repository
- **GitHub**: https://github.com/asunnyboy861/SoundSplit
- **Bundle ID**: com.zzoutuo.SoundSplit
- **Platform**: iOS 17.0+
- **Language**: Swift / SwiftUI / SwiftData

## Key Features
- Volume Profiles: Save and switch between custom volume configurations
- Quick Actions: One-tap mute all or max volume
- Onboarding: 3-screen guided introduction
- Paywall: Monthly ($1.99) / Yearly ($9.99) subscription with 7-day free trial
- Contact Support: In-app feedback form with topic selection

## Architecture
- **MVVM Pattern**: Views → Managers → Models
- **SwiftData**: Persistent storage for VolumeProfile
- **StoreKit 2**: Subscription management
- **Observation Framework**: @Observable for managers

## File Structure
```
SoundSplit/
├── Models/
│   └── VolumeProfile.swift          # SwiftData model
├── Managers/
│   ├── AudioEngineManager.swift     # Volume control engine
│   ├── ProfileManager.swift         # Profile switching logic
│   └── PurchaseManager.swift        # StoreKit 2 subscriptions
├── Views/
│   ├── Main/
│   │   ├── ProfileListView.swift    # Main screen
│   │   └── ProfileCardView.swift    # Profile card component
│   ├── Edit/
│   │   ├── ProfileEditView.swift    # Create/edit profile
│   │   ├── VolumeSliderView.swift   # Volume slider component
│   │   └── IconPickerView.swift     # Icon selection grid
│   ├── Onboarding/
│   │   └── OnboardingView.swift     # 3-page onboarding
│   ├── Settings/
│   │   ├── SettingsView.swift       # Settings screen
│   │   └── ContactSupportView.swift # Feedback form
│   └── Paywall/
│       └── PaywallView.swift        # Subscription paywall
├── SoundSplitApp.swift              # App entry point
└── ContentView.swift                # Root content view
```

## Build Status
- ✅ Build succeeded on iOS Simulator (iPhone Xs Max, iOS 18.4)
- ✅ App launches and runs correctly
- ✅ Pushed to GitHub: main branch

## Policy Pages
- Support: https://asunnyboy861.github.io/SoundSplit/support.html
- Privacy: https://asunnyboy861.github.io/SoundSplit/privacy.html
- Terms: https://asunnyboy861.github.io/SoundSplit/terms.html

## Next Steps
- [ ] Add App Intents for Shortcuts integration
- [ ] Add Focus Filter API for Focus Mode
- [ ] Add Control Center Widget
- [ ] Add Live Activity / Dynamic Island support
- [ ] Add per-app volume switching automation
- [ ] Configure In-App Purchase in App Store Connect
- [ ] Submit for App Store Review
