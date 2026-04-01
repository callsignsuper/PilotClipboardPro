import SwiftUI

struct LimitationRowView: View {
    let name: String
    let value: String
    var isSubItem: Bool = false
    var note: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top) {
                if isSubItem {
                    Text("—")
                        .font(AppTheme.bodyFont)
                        .foregroundColor(AppTheme.lightGray)
                        .padding(.leading, 20)
                }

                Text(name)
                    .font(isSubItem ? AppTheme.bodyFont : AppTheme.subheadingFont)
                    .foregroundColor(AppTheme.white)
                    .textCase(.uppercase)

                Spacer()

                Text(value)
                    .font(AppTheme.bodyFont)
                    .foregroundColor(AppTheme.white)
                    .multilineTextAlignment(.trailing)
            }

            if let note = note {
                Text(note)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.lightGray)
                    .padding(.leading, isSubItem ? 40 : 0)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}
