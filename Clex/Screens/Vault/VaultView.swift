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
                        Text("2 LOCAL")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(palette.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                ClexGlassCard(padding: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        ClexSectionTitle(title: "NEW NOTE")
                        Text("CREATE")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(palette.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .clexReveal(2)

            ClexGlassCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Quarterly vault audit")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(palette.textPrimary)
                    Text("Recovery key rotated. Backup sync healthy across two devices.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(palette.textSecondary)
                    Text("UPDATED 29 MIN AGO")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .tracking(1.4)
                        .foregroundStyle(palette.accent)
                }
            }
            .clexReveal(3)

            ClexGlassCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Device pairing notes")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(palette.textPrimary)
                    Text("Sync code copied to secondary device. Cloud backup standing by.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(palette.textSecondary)
                    Text("UPDATED 2 H AGO")
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
                    ClexMetricCard(title: "DEFAULT EXPIRY", value: "24H")
                    ClexMetricCard(title: "SECURE VIEW", value: "ON")
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
                ClexMetricCard(title: "DEVICES", value: "2")
                ClexMetricCard(title: "STATUS", value: "READY")
            }
            .clexReveal(3)
        }
    }
}

private struct VaultPlusPanel: View {
    @Environment(\.clexPalette) private var palette

    private let items = [
        "ACCOUNT",
        "ENCRYPTION",
        "SYNC CODE",
        "DEFAULT EXPIRY",
        "CLOUD BACKUP",
        "ACCOUNT DEVICES"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                ClexGlassCard {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(item)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundStyle(palette.textPrimary)
                            Text("Tap to configure this vault setting.")
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
