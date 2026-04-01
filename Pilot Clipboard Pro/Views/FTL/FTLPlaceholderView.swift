import SwiftUI

struct FTLPlaceholderView: View {
    var body: some View {
        VStack {
            Text("FLIGHT TIME LIMITATIONS")
                .font(AppTheme.subheadingFont)
                .foregroundColor(AppTheme.amber)
                .padding(.top, 16)

            Spacer()
            Text("FTL Calculator will be displayed here")
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.lightGray)
            Text("Interactive calculator with FDP computation")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.lightGray.opacity(0.6))
                .padding(.top, 4)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.background)
    }
}
