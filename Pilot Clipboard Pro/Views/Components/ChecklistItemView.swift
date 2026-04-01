import SwiftUI

struct ChecklistItemView: View {
    let title: String
    @Binding var isChecked: Bool
    var hasInfo: Bool = false
    var isAdvisory: Bool = false
    var onInfoTap: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 12) {
            Button {
                isChecked.toggle()
            } label: {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .font(.system(size: 20))
                    .foregroundColor(isChecked ? AppTheme.cyan : AppTheme.cyan.opacity(0.6))
            }
            .buttonStyle(.plain)

            Text(title)
                .font(AppTheme.bodyFont)
                .foregroundColor(isAdvisory ? AppTheme.amber : AppTheme.cyan)
                .strikethrough(isChecked, color: AppTheme.cyan.opacity(0.4))

            Spacer()

            if hasInfo {
                Button {
                    onInfoTap?()
                } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 16))
                        .foregroundColor(AppTheme.lightGray)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .contentShape(Rectangle())
    }
}
