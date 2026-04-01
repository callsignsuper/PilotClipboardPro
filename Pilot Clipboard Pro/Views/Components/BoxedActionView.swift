import SwiftUI

struct BoxedActionView: View {
    let action: String
    let value: String

    var body: some View {
        HStack {
            Text(action)
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.white)

            Spacer()

            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(AppTheme.white)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(AppTheme.white, lineWidth: 1.5)
        )
    }
}
