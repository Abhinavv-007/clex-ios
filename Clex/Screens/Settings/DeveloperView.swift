import SwiftUI

struct DeveloperView: View {
    @Environment(\.clexPalette) private var palette

    private let socials: [(logo: String, label: String, url: String)] = [
        ("IG", "Instagram", "https://www.instagram.com/abhinavv.007/"),
        ("in", "LinkedIn", "https://www.linkedin.com/in/abhnv07/")
    ]

    private let emails: [(label: String, value: String, url: String)] = [
        ("EMAIL", "hello@clex.in", "mailto:hello@clex.in"),
        ("EMAIL", "abhnv@clex.in", "mailto:abhnv@clex.in"),
        ("EMAIL", "abhnv@abhnv.in", "mailto:abhnv@abhnv.in"),
    ]

    private let websites: [(label: String, value: String, url: String)] = [
        ("WEBSITE", "abhnv.in", "https://abhnv.in"),
        ("WEBSITE", "abhnv.me", "https://abhnv.me"),
        ("WEBSITE", "lnch.in", "https://lnch.in"),
        ("WEBSITE", "trgt.in", "https://trgt.in"),
        ("WEBSITE", "modih.in", "https://modih.in")
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ClexHeader(icon: "person.crop.circle.fill", title: "Developer", status: "v\(AppRelease.versionName)")
                    .clexReveal(0)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Abhinav Raj")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(palette.textPrimary)
                        Text("Built Clex around direct transfer, local-first privacy, and public verification without turning the product into a normal cloud wrapper.")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(palette.textSecondary)
                    }
                }
                .clexReveal(1)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        ClexSectionTitle(title: "SOCIAL")
                        HStack(spacing: 12) {
                            ForEach(Array(socials.enumerated()), id: \.offset) { _, item in
                                Link(destination: URL(string: item.url)!) {
                                    HStack(spacing: 10) {
                                        Text(item.logo)
                                            .font(.system(size: 14, weight: .black, design: .rounded))
                                            .foregroundStyle(palette.accent)
                                            .frame(width: 38, height: 38)
                                            .background(palette.accentSoft, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                                            .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(palette.accent.opacity(0.45), lineWidth: 1))
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(item.label.uppercased())
                                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                                .foregroundStyle(palette.textSecondary)
                                            Text("OPEN ↗")
                                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                                .foregroundStyle(palette.textPrimary)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(12)
                                    .background(palette.surfaceStrong, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .clexReveal(2)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        ClexSectionTitle(title: "EMAILS")
                        ForEach(Array(emails.enumerated()), id: \.offset) { _, item in
                            Link(destination: URL(string: item.url)!) {
                                DeveloperLinkRow(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .clexReveal(3)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        ClexSectionTitle(title: "EXPERIENCE / WEBSITES")
                        ForEach(Array(websites.enumerated()), id: \.offset) { _, item in
                            Link(destination: URL(string: item.url)!) {
                                DeveloperLinkRow(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .clexReveal(4)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 10) {
                        ClexSectionTitle(title: "CURRENT RELEASE")
                        Text("v\(AppRelease.versionName) (\(AppRelease.buildNumber))")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(palette.textPrimary)
                        Text("Current mobile release with glass-shell refinement, cleaned product copy, and aligned developer contact details.")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(palette.textSecondary)
                    }
                }
                .clexReveal(5)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .background(ClexGlassBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

private struct DeveloperLinkRow: View {
    @Environment(\.clexPalette) private var palette

    let item: (label: String, value: String, url: String)

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.label)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(palette.textSecondary)
                Text(item.value)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(palette.textPrimary)
            }
            Spacer()
            Image(systemName: "arrow.up.right")
                .foregroundStyle(palette.accent)
        }
        .padding(.vertical, 4)
    }
}
