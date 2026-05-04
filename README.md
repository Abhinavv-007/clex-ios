<!-- =====================================================================
     Clex iOS — clex.in on Apple silicon
     ===================================================================== -->

<div align="center">

<img src="Clex/Assets.xcassets/ClexLogo.imageset/clex_app_logo.png" alt="Clex iOS icon" width="120" />

# 🍎 Clex — iOS

### Standalone **SwiftUI** iOS client for [clex.in](https://clex.in) — Home, Vault, Chain, Settings, with Apple-style translucent glass UI aligned to the Android v1.9.x app direction.

<a href="https://clex.in"><img src="https://img.shields.io/badge/Live-clex.in-FFD83D?style=for-the-badge&labelColor=111111" alt="Live" /></a>
<img src="https://img.shields.io/badge/Platform-iOS-000000?style=for-the-badge&logo=apple&logoColor=white&labelColor=111111" alt="iOS" />
<img src="https://img.shields.io/badge/Min%20iOS-17.0-000000?style=for-the-badge&logo=apple&logoColor=white&labelColor=111111" alt="Min iOS" />
<img src="https://img.shields.io/badge/Built%20with-SwiftUI-FA7343?style=for-the-badge&logo=swift&logoColor=white&labelColor=111111" alt="SwiftUI" />
<img src="https://img.shields.io/badge/Swift-5-FA7343?style=for-the-badge&logo=swift&logoColor=white&labelColor=111111" alt="Swift" />

<br />

<a href="https://github.com/Abhinavv-007/clex-ios/stargazers"><img src="https://img.shields.io/github/stars/Abhinavv-007/clex-ios?style=flat-square&logo=github&color=FFD83D&labelColor=111111" alt="Stars" /></a>
<a href="https://github.com/Abhinavv-007/clex-ios/commits/main"><img src="https://img.shields.io/github/last-commit/Abhinavv-007/clex-ios?style=flat-square&logo=git&color=FFD83D&labelColor=111111" alt="Last commit" /></a>
<img src="https://img.shields.io/github/commit-activity/m/Abhinavv-007/clex-ios?style=flat-square&logo=github&color=FFD83D&labelColor=111111" alt="Commit activity" />
<img src="https://img.shields.io/github/repo-size/Abhinavv-007/clex-ios?style=flat-square&logo=files&color=FFD83D&labelColor=111111" alt="Repo size" />
<img src="https://img.shields.io/github/languages/top/Abhinavv-007/clex-ios?style=flat-square&logo=swift&color=FFD83D&labelColor=111111" alt="Top language" />
<img src="https://img.shields.io/github/v/tag/Abhinavv-007/clex-ios?style=flat-square&logo=semver&color=FFD83D&labelColor=111111&label=version" alt="Version" />

<br />

<sub><b>SwiftUI · Apple glass · iOS 17+ · in.clex.mobile</b></sub>

</div>

<br />

---

## ✦ Current Release — `1.9.5` (build `195`)

| | |
|---|---|
| Bundle ID | `in.clex.mobile` |
| Minimum iOS | `17.0` |
| Language / UI | Swift 5 + SwiftUI |
| Build | `195` |

> This repository contains the **active iOS app only**. It opens directly in Xcode and does not depend on the original monorepo at build time.

---

## ✦ What's Inside

<table>
  <tr>
    <td width="50%" valign="top">
      <h3>🏠 Tab Shell</h3>
      <p><b>HOME</b> · <b>VAULT</b> · <b>CHAIN</b> · <b>SETTINGS</b> — Apple-style translucent glass UI aligned with the Android v1.9.x app direction.</p>
    </td>
    <td width="50%" valign="top">
      <h3>🗝 Vault</h3>
      <p>Notes · Secret · Cloud · Vault+ configuration screens. Same Vault product surface as web/Android.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3>🔗 Chain</h3>
      <p>Chain workflow, chain presets, and verifiable-transfer presentation.</p>
    </td>
    <td width="50%" valign="top">
      <h3>⚙️ Settings</h3>
      <p>Theme mode, Privacy, Help/FAQ, Changelog/About, and About the Developer with portfolio links.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3>👤 Developer page</h3>
      <p>Direct links: Abhinav Raj's Instagram, LinkedIn, Clex emails, and experience websites.</p>
    </td>
    <td width="50%" valign="top">
      <h3>🌉 Service-aligned</h3>
      <p>Same backend service direction as Android/web — <code>clex.in</code>, <code>vault/api</code>, <code>vault/secret</code>, <code>signal.clex.in</code> WebSocket signaling, Drive cloud-share when enabled.</p>
    </td>
  </tr>
</table>

---

## ✦ Tech Stack

<p>
  <img src="https://img.shields.io/badge/Swift%205-FA7343?style=for-the-badge&logo=swift&logoColor=white" />
  <img src="https://img.shields.io/badge/SwiftUI-007AFF?style=for-the-badge&logo=swift&logoColor=white" />
  <img src="https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white" />
  <img src="https://img.shields.io/badge/XcodeGen-FFE4B5?style=for-the-badge&logoColor=black" />
  <img src="https://img.shields.io/badge/iOS%2017%2B-000000?style=for-the-badge&logo=apple&logoColor=white" />
  <br/>
  <img src="https://img.shields.io/badge/WebRTC-333333?style=for-the-badge&logo=webrtc&logoColor=white" />
  <img src="https://img.shields.io/badge/Google%20Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white" />
  <img src="https://img.shields.io/badge/Cloudflare%20Workers-F38020?style=for-the-badge&logo=cloudflareworkers&logoColor=white" />
</p>

---

## ✦ Open in Xcode

Open this file directly:

```text
Clex.xcodeproj
```

Do **not** open just the `Clex/` source folder.

---

## ✦ Build

### From Xcode

1. Open `Clex.xcodeproj`
2. Select the `Clex` scheme
3. Pick an iPhone simulator or connected iPhone
4. `Product > Clean Build Folder`
5. `Product > Run`

### From terminal

```bash
xcodebuild \
  -project Clex.xcodeproj \
  -scheme Clex \
  -destination 'generic/platform=iOS' \
  -configuration Debug \
  CODE_SIGNING_ALLOWED=NO \
  build
```

---

## ✦ App Store / TestFlight

1. Open `Clex.xcodeproj`
2. Set your Apple development team in **Signing & Capabilities**
3. Build for **Any iOS Device**
4. Use `Product > Archive`
5. Upload the archive through **Xcode Organizer**

---

## ✦ Project Layout

```text
clex-ios/
├── Clex.xcodeproj/         # generated project (XcodeGen optional)
├── Clex/
│   ├── ClexApp.swift       # App entry
│   ├── AppRelease.swift    # Release-only wiring
│   ├── Assets.xcassets/    # AppIcon, ClexLogo, AccentColor
│   ├── Components/         # shared SwiftUI views
│   ├── Data/               # local stores
│   ├── Navigation/         # tab shell
│   ├── Screens/            # Home, Vault, Chain, Settings, Developer
│   └── Theme/              # colors, typography, glass styles
├── project.yml             # XcodeGen spec
├── RELEASES.md
└── README.md
```

---

## ✦ Regenerating The Project

`project.yml` is included for XcodeGen users:

```bash
xcodegen generate --spec project.yml
```

The committed `Clex.xcodeproj` is already generated, so XcodeGen is not required just to open/build the app.

---

## ✦ Runtime Service Dependencies

The iOS app follows the same service direction as Android/web:

| Service | URL |
| --- | --- |
| Clex web + APIs | `https://clex.in` |
| Vault API | `https://clex.in/vault/api` |
| Vault secret | `https://clex.in/vault/secret` |
| WebRTC signaling | `wss://signal.clex.in` |
| Cloud share | Google Drive API (when enabled) |

> Some transfer/backend flows are still iOS UI/parity scaffolds while Android contains the fuller WebRTC implementation.

---

## ✦ Star History

<a href="https://star-history.com/#Abhinavv-007/clex-ios&Date">
  <img src="https://api.star-history.com/svg?repos=Abhinavv-007/clex-ios&type=Date" alt="Star history" width="100%" />
</a>

---

<div align="center">
  <sub>🍎 Built by <a href="https://abhnv.in"><b>Abhinav Raj</b></a> · siblings: <a href="https://github.com/Abhinavv-007/clex">clex</a> · <a href="https://github.com/Abhinavv-007/clex-android">clex-android</a> · <a href="https://github.com/Abhinavv-007/clex-ai">clex-ai</a>.</sub>
  <br/>
  <a href="https://abhnv.in">Portfolio</a> · <a href="https://www.linkedin.com/in/abhnv07/">LinkedIn</a> · <a href="https://x.com/Abhnv007">X</a> · <a href="https://www.instagram.com/abhinavv.007/">Instagram</a>
</div>
