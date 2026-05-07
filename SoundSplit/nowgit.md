# Git Repositories

## Main App (iOS Application)

| Item | Value |
|------|-------|
| **Repository Name** | SoundSplit |
| **Git URL** | git@github.com:asunnyboy861/SoundSplit.git |
| **Repo URL** | https://github.com/asunnyboy861/SoundSplit |
| **Visibility** | Public |
| **Primary Language** | Swift |
| **GitHub Pages** | ✅ **ENABLED** (from `/docs` folder) |

## Policy Pages (Deployed from Main Repository /docs)

| Page | URL | Status |
|------|-----|--------|
| Landing Page | https://asunnyboy861.github.io/SoundSplit/ | ✅ Active |
| Support | https://asunnyboy861.github.io/SoundSplit/support.html | ✅ Active |
| Privacy Policy | https://asunnyboy861.github.io/SoundSplit/privacy.html | ✅ Active |
| Terms of Use | https://asunnyboy861.github.io/SoundSplit/terms.html | ✅ Active |

Note: Terms of Use required for IAP subscription apps.

## Repository Structure

```
SoundSplit/
├── SoundSplit/                        # iOS App Source Code
│   ├── SoundSplit.xcodeproj/          # Xcode Project
│   ├── SoundSplit/                    # Swift Source Files
│   │   ├── Views/
│   │   │   ├── Main/
│   │   │   │   ├── ProfileListView.swift
│   │   │   │   └── ProfileCardView.swift
│   │   │   ├── Edit/
│   │   │   │   ├── ProfileEditView.swift
│   │   │   │   ├── VolumeSliderView.swift
│   │   │   │   └── IconPickerView.swift
│   │   │   ├── Onboarding/
│   │   │   │   └── OnboardingView.swift
│   │   │   ├── Settings/
│   │   │   │   ├── SettingsView.swift
│   │   │   │   └── ContactSupportView.swift
│   │   │   └── Paywall/
│   │   │       └── PaywallView.swift
│   │   ├── Models/
│   │   │   └── VolumeProfile.swift
│   │   ├── Managers/
│   │   │   ├── AudioEngineManager.swift
│   │   │   ├── ProfileManager.swift
│   │   │   └── PurchaseManager.swift
│   │   ├── Assets.xcassets/
│   │   ├── ContentView.swift
│   │   └── SoundSplitApp.swift
│   ├── SoundSplitTests/
│   └── SoundSplitUITests/
├── docs/                              # Policy Pages (GitHub Pages source)
│   ├── support.html                   # Support Page
│   ├── privacy.html                   # Privacy Policy
│   └── terms.html                     # Terms of Use
├── .gitignore
├── us.md                              # English Development Guide
├── keytext.md                         # App Store Metadata
├── capabilities.md                    # Capabilities Configuration
├── icon.md                            # App Icon Details
├── price.md                           # Pricing Configuration
└── nowgit.md                          # This File
```

## App Overview

**SoundSplit** gives iPhone users independent control over ringer, media, and call volumes through customizable Volume Profiles.

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

## Build Status

- ✅ Build succeeded on iOS Simulator (iPhone XS Max, iOS 18.4)
- ✅ App launches and runs correctly
- ✅ Pushed to GitHub: main branch

## Next Steps

- [ ] Add App Intents for Shortcuts integration
- [ ] Add Focus Filter API for Focus Mode
- [ ] Add Control Center Widget
- [ ] Add Live Activity / Dynamic Island support
- [ ] Add per-app volume switching automation
- [ ] Configure In-App Purchase in App Store Connect
- [ ] Submit for App Store Review
