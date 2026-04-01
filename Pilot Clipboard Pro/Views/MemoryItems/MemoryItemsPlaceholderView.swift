import SwiftUI

struct MemoryItemsPlaceholderView: View {
    @State private var selectedSidebar = "EMERGENCY DESCENT"

    private let sidebarItems = [
        SidebarItem("EMERGENCY DESCENT", icon: "arrow.down.circle"),
        SidebarItem("UNRELIABLE SPEED INDICATION", icon: "speedometer"),
        SidebarItem("LOSS OF BRAKING", icon: "exclamationmark.triangle"),
        SidebarItem("REACTIVE WINDSHEAR WARNING", icon: "wind"),
        SidebarItem("TCAS", icon: "airplane.circle"),
        SidebarItem("TAWS", icon: "mountain.2"),
        SidebarItem("TAWS (CAUTION)", icon: "mountain.2"),
        SidebarItem("STALL INDICATIONS", icon: "exclamationmark.octagon"),
        SidebarItem("STALL WARNING AT LIFTOFF", icon: "exclamationmark.octagon"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            SidebarView(items: sidebarItems, selectedItem: $selectedSidebar)

            HStack(spacing: 0) {
                // Left: Immediate Actions
                VStack(alignment: .leading) {
                    Text("IMMEDIATE ACTIONS (BOXED)")
                        .font(AppTheme.subheadingFont)
                        .foregroundColor(AppTheme.amber)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)

                    Spacer()
                    Text("Boxed memory items will appear here")
                        .font(AppTheme.bodyFont)
                        .foregroundColor(AppTheme.lightGray)
                        .padding(.horizontal, 16)
                    Spacer()
                }
                .frame(maxWidth: .infinity)

                Divider().background(AppTheme.lightGray.opacity(0.3))

                // Right: Supplementary Info
                VStack(alignment: .leading) {
                    Text("SUPPLEMENTARY INFO")
                        .font(AppTheme.subheadingFont)
                        .foregroundColor(AppTheme.amber)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)

                    Spacer()
                    Text("PF/PM tasks and notes")
                        .font(AppTheme.bodyFont)
                        .foregroundColor(AppTheme.lightGray)
                        .padding(.horizontal, 16)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(AppTheme.background)
        }
    }
}
