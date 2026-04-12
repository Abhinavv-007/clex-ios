# iOS Releases

## v1.9.1

Release notes:

- Added the real Clex logo asset to the iOS app and placed it on the Home workspace header.
- Updated About the Developer with Abhinav Raj, Instagram, LinkedIn, current Clex emails, and experience websites.
- Published the active glass-style SwiftUI parity app as the standalone `clex-ios` repository.
- Kept version metadata aligned with Android v1.9.1 / build 191.

Validation:

- `xcodebuild -project Clex.xcodeproj -scheme Clex -destination 'generic/platform=iOS' -configuration Debug CODE_SIGNING_ALLOWED=NO build`
