# Clex iOS

Standalone SwiftUI iOS app for Clex.

This repository contains the active iOS app only. It can be opened directly in Xcode and does not depend on the original monorepo at build time.

## Current Release

- Version: `1.9.1`
- Build: `191`
- Bundle ID: `in.clex.mobile`
- Minimum iOS: `17.0`
- Language/UI: Swift 5 + SwiftUI

## What The App Includes

- HOME / VAULT / CHAIN / SETTINGS tab shell
- Apple-style translucent glass UI aligned with the Android v1.9.1 app direction
- Clex logo asset on the Home workspace header
- Vault notes, secret, cloud, and vault+ configuration screens
- Chain workflow, chain presets, and verifiable-transfer presentation
- Settings with theme mode, Privacy, Help/FAQ, Changelog/About, and About the Developer
- Developer page with Abhinav Raj, Instagram, LinkedIn, Clex emails, and experience websites

## Project Layout

```text
clex-ios/
├── Clex.xcodeproj/
├── Clex/
│   ├── ClexApp.swift
│   ├── AppRelease.swift
│   ├── Assets.xcassets/
│   ├── Components/
│   ├── Data/
│   ├── Navigation/
│   ├── Screens/
│   └── Theme/
└── project.yml
```

## Open In Xcode

Open this file directly:

```text
Clex.xcodeproj
```

Do not open only the `Clex/` source folder.

## Build

From Xcode:

1. Open `Clex.xcodeproj`.
2. Select the `Clex` scheme.
3. Select an iPhone simulator or connected iPhone.
4. Run `Product > Clean Build Folder`.
5. Run `Product > Run`.

From terminal:

```bash
xcodebuild \
  -project Clex.xcodeproj \
  -scheme Clex \
  -destination 'generic/platform=iOS' \
  -configuration Debug \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## App Store / TestFlight

For App Store or TestFlight upload:

1. Open `Clex.xcodeproj`.
2. Set your Apple development team in Signing & Capabilities.
3. Build `Any iOS Device`.
4. Use `Product > Archive`.
5. Upload the archive through Xcode Organizer.

## Runtime Service Dependencies

The iOS app follows the same service direction as Android/web:

- `https://clex.in`
- `https://clex.in/vault/api`
- `https://clex.in/vault/secret`
- `wss://signal.clex.in`
- Google Drive API for cloud-share flows when enabled

Some transfer/backend flows are still iOS UI/parity scaffolds while Android contains the fuller WebRTC implementation.

## Regenerating The Project

`project.yml` is included for XcodeGen users. If needed:

```bash
xcodegen generate --spec project.yml
```

The committed `Clex.xcodeproj` is already generated, so XcodeGen is not required just to open/build the app.
