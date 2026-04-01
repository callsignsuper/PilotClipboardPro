import SwiftUI

struct ApproachPlaceholderView: View {
    @State private var selectedSidebar = "TOD / APPROACH"

    private let sidebarItems = [
        SidebarItem("TOD / APPROACH", icon: "airplane.arrival"),
        SidebarItem("METERS TO FT CONVERSION", icon: "ruler"),
        SidebarItem("APP STABILIZATION", icon: "gauge.with.needle"),
        SidebarItem("HOLDING SPEEDS", icon: "arrow.clockwise"),
        SidebarItem("X-WIND LIMITS", icon: "wind"),
        SidebarItem("REQUIRED EQUIP. CAT II / III", icon: "list.bullet.clipboard"),
        SidebarItem("COLD TEMP CORRECTION", icon: "thermometer.snowflake"),
        SidebarItem("ALT CORRECTION", icon: "arrow.up.and.down"),
        SidebarItem("US ATIS RMKS", icon: "text.magnifyingglass"),
        SidebarItem("DEVIATION CALLS", icon: "arrow.left.and.right"),
        SidebarItem("FO LIMITATIONS", icon: "person"),
        SidebarItem("DIVERSION", icon: "arrow.triangle.branch"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            SidebarView(items: sidebarItems, selectedItem: $selectedSidebar)

            VStack {
                Spacer()
                Text(selectedSidebar)
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.lightGray)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppTheme.background)
        }
    }
}
