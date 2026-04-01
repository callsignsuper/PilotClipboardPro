import SwiftUI

struct ColdOpsPlaceholderView: View {
    @State private var selectedSidebar = "DISPATCH"

    private let sidebarItems = [
        SidebarItem("DISPATCH", icon: "doc.text"),
        SidebarItem("AT THE GATE", icon: "airplane.circle"),
        SidebarItem("TAXI", icon: "road.lanes"),
        SidebarItem("DE-ICING BAY", icon: "snowflake"),
        SidebarItem("BEFORE TAKE-OFF", icon: "checkmark.circle"),
        SidebarItem("APPROACH", icon: "airplane.arrival"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            SidebarView(items: sidebarItems, selectedItem: $selectedSidebar)

            VStack {
                Spacer()
                Text("Cold Ops: \(selectedSidebar)")
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.lightGray)
                Text("Phase checklist will be displayed here")
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
