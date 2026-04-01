import SwiftUI

struct OwnChecksPlaceholderView: View {
    var body: some View {
        HStack(spacing: 0) {
            // Sidebar
            VStack {
                Button {
                    // TODO: Add new checklist
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("NEW")
                    }
                    .font(AppTheme.subheadingFont)
                    .foregroundColor(AppTheme.cyan)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(AppTheme.cyan, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
                .padding(16)

                Spacer()
            }
            .frame(width: AppTheme.sidebarWidth)
            .background(AppTheme.cardBackground)

            // Content
            VStack {
                Spacer()
                Text("Create your own checklists")
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.lightGray)
                Text("Tap + NEW to get started")
                    .font(AppTheme.bodyFont)
                    .foregroundColor(AppTheme.lightGray.opacity(0.6))
                    .padding(.top, 4)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(AppTheme.background)
    }
}
