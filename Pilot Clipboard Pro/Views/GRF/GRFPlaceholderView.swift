import SwiftUI

struct GRFPlaceholderView: View {
    var body: some View {
        VStack {
            Text("SNOWTAM - GLOBAL REPORTING FORMAT (GRF)")
                .font(AppTheme.subheadingFont)
                .foregroundColor(AppTheme.amber)
                .padding(.top, 16)

            Text("FOR RWY SURFACE CONDITIONS")
                .font(AppTheme.labelFont)
                .foregroundColor(AppTheme.lightGray)

            Spacer()
            Text("GRF / SNOWTAM decoder form will be displayed here")
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.lightGray)
            Text("Fields A through T")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.lightGray.opacity(0.6))
                .padding(.top, 4)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.background)
    }
}
