import SwiftUI

struct MainTabView: View {
    let inboxViewModel: InboxViewModel
    let calendarViewModel: CalendarViewModel
    let profileViewModel: ProfileViewModel

    var body: some View {
        TabView {
            InboxView(viewModel: inboxViewModel)
                .tabItem {
                    Label("Inbox", systemImage: "envelope")
                }

            CalendarView(viewModel: calendarViewModel)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }

            ProfileView(viewModel: profileViewModel)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(DesignTokens.Colors.accent)
    }
}
