import SwiftUI

struct NotesPlaceholderView: View {
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                ForEach(["IMPORT IMAGE", "DELETE IMAGE", "SCREENSHOT", "DELETE NOTES", "TEXTBOX"], id: \.self) { tool in
                    Button {
                        // TODO: Implement tool actions
                    } label: {
                        Text(tool)
                            .font(AppTheme.labelFont)
                            .foregroundColor(AppTheme.lightGray)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(AppTheme.lightGray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(AppTheme.cardBackground)

            Spacer()
            Text("PencilKit Scratchpad")
                .font(AppTheme.headingFont)
                .foregroundColor(AppTheme.lightGray)
            Text("Drawing canvas will be available here")
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.lightGray.opacity(0.6))
                .padding(.top, 4)
            Spacer()
        }
        .background(AppTheme.background)
    }
}
