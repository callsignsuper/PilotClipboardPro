import SwiftUI

struct LoadingPlaceholderView: View {
    @State private var selectedSidebar = "CABIN LAYOUT"

    private let sidebarItems = [
        SidebarItem("CABIN LAYOUT", icon: "airplane"),
        SidebarItem("CARGO HOLD", icon: "shippingbox"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            SidebarView(items: sidebarItems, selectedItem: $selectedSidebar)

            VStack {
                Spacer()
                Text(selectedSidebar)
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.lightGray)
                Text("Seat map / cargo layout will be displayed here")
                    .font(AppTheme.bodyFont)
                    .foregroundColor(AppTheme.lightGray.opacity(0.6))
                    .padding(.top, 4)
                Text("PINCH TO ZOOM")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.cyan)
                    .padding(.top, 8)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppTheme.background)
        }
    }
}
