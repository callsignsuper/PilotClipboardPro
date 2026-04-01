import SwiftUI

struct CruisePlaceholderView: View {
    @State private var selectedSidebar = "TOC / CRZ"

    private let sidebarItems = [
        SidebarItem("TOC / CRZ", icon: "airplane"),
        SidebarItem("COMMS BROADCAST PROCEDURES", icon: "antenna.radiowaves.left.and.right"),
        SidebarItem("METERS TO FT CONVERSION", icon: "ruler"),
        SidebarItem("OCA IN-FLIGHT PROCs", icon: "globe"),
        SidebarItem("SPECIAL PROCs FOR IN-FLIGHT CONTINGENCIES", icon: "exclamationmark.triangle"),
        SidebarItem("IN-FLT FUEL MANAGEMENT", icon: "fuelpump"),
        SidebarItem("CRZ FAILURES", icon: "xmark.octagon"),
        SidebarItem("IRS / POLAR", icon: "location.north"),
        SidebarItem("DIVERSION", icon: "arrow.triangle.branch"),
        SidebarItem("BREAKS CALCULATOR", icon: "clock"),
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
