import SwiftUI

struct LimitationsPlaceholderView: View {
    @State private var selectedSidebar = "APU"

    private let sidebarItems = [
        SidebarItem("APU", icon: "bolt.circle"),
        SidebarItem("AUTOPILOT", icon: "gauge.with.needle"),
        SidebarItem("BTV", icon: "stop.circle"),
        SidebarItem("ENG", icon: "fan"),
        SidebarItem("FLAPS", icon: "rectangle.expand.vertical"),
        SidebarItem("FO LIMITATIONS", icon: "person"),
        SidebarItem("FUEL", icon: "fuelpump"),
        SidebarItem("L/G", icon: "circle.bottomhalf.filled"),
        SidebarItem("OIL", icon: "drop"),
        SidebarItem("OXYGEN", icon: "lungs"),
        SidebarItem("WIND", icon: "wind"),
        SidebarItem("WINDOWS / DOORS", icon: "door.left.hand.open"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            SidebarView(items: sidebarItems, selectedItem: $selectedSidebar)

            VStack {
                Spacer()
                Text(selectedSidebar)
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.lightGray)
                Text("Limitation data will be displayed here")
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
