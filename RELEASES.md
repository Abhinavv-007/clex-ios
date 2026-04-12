# iOS Releases

## v1.9.5

Release notes:

- Replaced the placeholder iOS chain client with the real `/chain/stats`, `/chain/explorer`, and `/chain/session/:id` endpoints.
- Added live-ledger detail for file type, size, hash, receiver chain ID, and event timeline inside the native iOS glass shell.
- Aligned iOS release metadata to v1.9.5 / build 195 and kept the active and V19 targets in sync.

Validation:

- `xcodebuild -project Clex.xcodeproj -scheme Clex -destination 'generic/platform=iOS' -configuration Debug CODE_SIGNING_ALLOWED=NO build`

## v1.9.3

Release notes:

- Fixed the duplicate-ID warning in the Home receive code boxes.
- Replaced raw developer `Link` actions with safe URL handling and copy fallback for mail addresses on simulator/device setups without Mail.
- Bumped local iOS project metadata to v1.9.3 / build 193 so Xcode no longer shows stale version data.

Validation:

- `xcodebuild -project Clex.xcodeproj -scheme Clex -destination 'generic/platform=iOS' -configuration Debug CODE_SIGNING_ALLOWED=NO build`
