# iOS Releases

## v1.9.2

Release notes:

- Cleaned placeholder/demo content across the active Home, Vault, Chain, Settings, Help, and Developer screens.
- Kept the glass-style SwiftUI shell while replacing random values with stable product copy.
- Bumped the iOS app to v1.9.2 / build 192 and aligned the repo metadata with the new release.

Validation:

- `xcodebuild -project Clex.xcodeproj -scheme Clex -destination 'generic/platform=iOS' -configuration Debug CODE_SIGNING_ALLOWED=NO build`
