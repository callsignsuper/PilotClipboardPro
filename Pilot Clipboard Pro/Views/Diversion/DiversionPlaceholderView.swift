import SwiftUI

struct DiversionPlaceholderView: View {
    @State private var selectedSidebar = "\"CAN WE\" CHECKLIST"

    private let sidebarItems = [
        SidebarItem("\"CAN WE\" CHECKLIST", icon: "checklist"),
        SidebarItem("\"CAN WE\" MODEL", icon: "rectangle.3.group"),
        SidebarItem("DIVERSION CHECKLIST", icon: "list.bullet"),
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
