import SwiftUI

struct InboxView: View {
    @StateObject var viewModel: InboxViewModel

    var body: some View {
        NavigationView {
            ZStack {
                DesignTokens.Colors.background
                    .ignoresSafeArea()

                if viewModel.state.isLoading {
                    ProgressView()
                        .tint(.white)
                } else if let error = viewModel.state.error {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(sortedSections, id: \.self) { section in
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(section)
                                        .font(DesignTokens.Typography.caption)
                                        .foregroundColor(DesignTokens.Colors.secondary)
                                        .padding(.horizontal, DesignTokens.Spacing.md)
                                        .padding(.vertical, DesignTokens.Spacing.sm)

                                    ForEach(groupedMessages[section] ?? []) { message in
                                        MessageRowView(message: message)
                                        Divider()
                                            .background(DesignTokens.Colors.separator)
                                    }
                                }
                            }
                        }
                    }
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "square.and.pencil")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(DesignTokens.Colors.accent)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding(DesignTokens.Spacing.md)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(alignment: .center, spacing: DesignTokens.Spacing.md) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.white)
                            .font(.title3)
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadMessages()
        }
    }

    private var groupedMessages: [String: [Message]] {
        Dictionary(grouping: viewModel.state.messages) { message in
            if Calendar.current.isDateInToday(message.date) {
                return "Today"
            } else if Calendar.current.isDateInYesterday(message.date) {
                return "Yesterday"
            } else {
                return "Earlier"
            }
        }
    }

    private var sortedSections: [String] {
        let sectionOrder = ["Today", "Yesterday", "Earlier"]
        return sectionOrder.filter { groupedMessages[$0] != nil }
    }
}
