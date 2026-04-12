# iOS Releases

## v1.9.3

Release notes:

- Fixed the duplicate-ID warning in the Home receive code boxes.
- Replaced raw developer `Link` actions with safe URL handling and copy fallback for mail addresses on simulator/device setups without Mail.
- Bumped the iOS app to v1.9.3 / build 193 and aligned the repo metadata with the fix.

Validation:

- `xcodebuild -project Clex.xcodeproj -scheme Clex -destination 'generic/platform=iOS' -configuration Debug CODE_SIGNING_ALLOWED=NO build`
