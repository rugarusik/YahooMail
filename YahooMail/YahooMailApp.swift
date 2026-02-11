//
//  YahooMailApp.swift
//  YahooMail
//
//  Created by Alina Golubeva on 11/02/2026.
//

import SwiftUI

@main
struct YahooMailApp: App {
    private let dependencyContainer = DependencyContainer()

    var body: some Scene {
        WindowGroup {
            MainTabView(
                inboxViewModel: dependencyContainer.makeInboxViewModel(),
                calendarViewModel: dependencyContainer.makeCalendarViewModel(),
                profileViewModel: dependencyContainer.makeProfileViewModel()
            )
            .preferredColorScheme(.dark)
        }
    }
}
