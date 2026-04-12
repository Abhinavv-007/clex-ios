import SwiftUI

private enum VaultTab: String, CaseIterable {
    case notes = "NOTES"
    case secret = "SECRET"
    case cloud = "CLOUD"
    case plus = "VAULT+"
}

struct VaultView: View {
    @Environment(\.clexPalette) private var palette
    @State private var tab: VaultTab = .notes

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ClexHeader(icon: "lock.shield.fill", title: "Vault", status: "ENCRYPTED")
                    .clexReveal(0)

                ClexGlassCard(padding: 12) {
                    Picker("Vault", selection: $tab) {
                        ForEach(VaultTab.allCases, id: \.self) { item in
                            Text(item.rawValue).tag(item)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .clexReveal(1)

                switch tab {
                case .notes:
                    VaultNotesPanel()
                case .secret:
                    VaultSecretPanel()
                case .cloud:
                    VaultCloudPanel()
                case .plus:
                    VaultPlusPanel()
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 130)
        }
    }
}

private struct VaultNotesPanel: View {
    @Environment(\.clexPalette) private var palette

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                ClexGlassCard(padding: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        ClexSectionTitle(title: "MY NOTES")
                        Text("PRIVATE")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(palette.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                ClexGlassCard(padding: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        ClexSectionTitle(title: "NEW NOTE")
                        Text("WRITE")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(palette.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .clexReveal(2)

            ClexGlassCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Encrypted notes live here")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(palette.textPrimary)
                    Text("Use Vault notes for private drafts, recovery details, and device-safe text that stays out of the public chain.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(palette.textSecondary)
                    Text("LOCAL FIRST")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .tracking(1.4)
                        .foregroundStyle(palette.accent)
                }
            }
            .clexReveal(3)

            ClexGlassCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Sync when you decide")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(palette.textPrimary)
                    Text("Cloud backup and multi-device sync can be enabled from Vault+ without exposing note contents publicly.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(palette.textSecondary)
                    Text("OPTIONAL CLOUD")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .tracking(1.4)
                        .foregroundStyle(palette.accent)
                }
            }
            .clexReveal(4)
        }
    }
}

private struct VaultSecretPanel: View {
    var body: some View {
        VStack(spacing: 16) {
            ClexGlassCard {
                VStack(alignment: .leading, spacing: 12) {
                    ClexSectionTitle(title: "SECRET SHARE")
                    Text("Create timed secret links with code-gated reveal and expiry rules.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    ClexPrimaryButton(title: "CREATE SECRET", systemImage: "key.horizontal.fill") {}
                }
            }
            .clexReveal(2)

            ClexGlassCard {
                HStack {
                    ClexMetricCard(title: "DEFAULT EXPIRY", value: "CUSTOM")
                    ClexMetricCard(title: "REVEAL FLOW", value: "CODE + LINK")
                }
            }
            .clexReveal(3)
        }
    }
}

private struct VaultCloudPanel: View {
    var body: some View {
        VStack(spacing: 16) {
            ClexGlassCard {
                VStack(alignment: .leading, spacing: 12) {
                    ClexSectionTitle(title: "CLOUD BACKUP")
                    Text("Encrypted backup snapshots, account sync, and device restore points.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    ClexPrimaryButton(title: "SYNC NOW", systemImage: "arrow.triangle.2.circlepath") {}
                }
            }
            .clexReveal(2)

            HStack(spacing: 14) {
                ClexMetricCard(title: "SYNC MODE", value: "MANUAL")
                ClexMetricCard(title: "BACKUP", value: "OPTIONAL")
            }
            .clexReveal(3)
        }
    }
}

private struct VaultPlusPanel: View {
    @Environment(\.clexPalette) private var palette

    private let items = [
        ("ACCOUNT", "Profile, identity, and account-backed vault state."),
        ("ENCRYPTION", "Choose how vault content is protected before export or sync."),
        ("SYNC CODE", "Pair a second device using the same private vault identity."),
        ("DEFAULT EXPIRY", "Set secret-link defaults for fast repeat sharing."),
        ("CLOUD BACKUP", "Control encrypted backup cadence and restore behavior."),
        ("ACCOUNT DEVICES", "Review trusted devices with vault access.")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                ClexGlassCard {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(item.0)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundStyle(palette.textPrimary)
                            Text(item.1)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(palette.textSecondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(palette.textSecondary)
                    }
                }
                .clexReveal(index + 2)
            }
        }
    }
}
