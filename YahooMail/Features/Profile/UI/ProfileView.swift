import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        NavigationView {
            ZStack {
                DesignTokens.Colors.background
                    .ignoresSafeArea()

                if viewModel.state.isLoading {
                    ProgressView()
                        .tint(.white)
                } else if let profile = viewModel.state.profile {
                    ScrollView {
                        VStack(spacing: DesignTokens.Spacing.lg) {
                            VStack(spacing: DesignTokens.Spacing.md) {
                                Text(profile.avatarEmoji)
                                    .font(.system(size: 80))
                                    .frame(width: 120, height: 120)
                                    .background(DesignTokens.Colors.secondaryBackground)
                                    .clipShape(Circle())

                                Text(profile.name)
                                    .font(DesignTokens.Typography.title)
                                    .foregroundColor(.white)

                                Text(profile.email)
                                    .font(DesignTokens.Typography.body)
                                    .foregroundColor(DesignTokens.Colors.secondary)
                            }
                            .padding(.top, DesignTokens.Spacing.xl)

                            VStack(spacing: 0) {
                                ProfileSettingRow(icon: "gear", title: "Settings")
                                Divider().background(DesignTokens.Colors.separator)

                                ProfileSettingRow(icon: "bell", title: "Notifications")
                                Divider().background(DesignTokens.Colors.separator)

                                ProfileSettingRow(icon: "lock", title: "Privacy")
                                Divider().background(DesignTokens.Colors.separator)

                                ProfileSettingRow(icon: "questionmark.circle", title: "Help & Support")
                                Divider().background(DesignTokens.Colors.separator)

                                ProfileSettingRow(icon: "info.circle", title: "About")
                            }
                            .background(DesignTokens.Colors.secondaryBackground)
                            .cornerRadius(DesignTokens.CornerRadius.md)
                            .padding(.horizontal, DesignTokens.Spacing.md)

                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.loadProfile()
        }
    }
}
