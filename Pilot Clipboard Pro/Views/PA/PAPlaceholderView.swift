import SwiftUI

struct PAPlaceholderView: View {
    @State private var selectedSidebar = "PRE - DEPARTURE"

    private let sidebarItems = [
        SidebarItem("PRE - DEPARTURE", icon: "mic"),
        SidebarItem("SECURITY FOR USA FLTS", icon: "shield"),
        SidebarItem("DE - ICING", icon: "snowflake"),
        SidebarItem("DELAYS", icon: "clock.badge.exclamationmark"),
        SidebarItem("TOP OF DESCENT", icon: "arrow.down.right"),
        SidebarItem("TOD - FLTS TO JEDDAH", icon: "building.2"),
        SidebarItem("DIVERSIONS", icon: "arrow.triangle.branch"),
        SidebarItem("REMOTE PARKING POSITION", icon: "parkingsign"),
        SidebarItem("REJECTED T.O.", icon: "xmark.circle"),
        SidebarItem("AFTER G.A.", icon: "arrow.up"),
        SidebarItem("EMERGENCY DESCENT", icon: "exclamationmark.triangle"),
        SidebarItem("BOMB ON BOARD", icon: "exclamationmark.octagon"),
        SidebarItem("PRECAUTIONARY DISEMBARKATION", icon: "figure.walk"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            SidebarView(items: sidebarItems, selectedItem: $selectedSidebar)

            VStack {
                Spacer()
                Text("PA Script: \(selectedSidebar)")
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.lightGray)
                Text("Script content will be displayed here")
                    .font(AppTheme.bodyFont)
                    .foregroundColor(AppTheme.lightGray.opacity(0.6))
                    .padding(.top, 4)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppTheme.background)
        }
    }
}
