import SwiftUI

struct LimitationsView: View {
    @State private var selectedCategory = "APU"

    private let sidebarItems: [SidebarItem] = [
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
            SidebarView(items: sidebarItems, selectedItem: $selectedCategory)

            limitationContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppTheme.background)
        }
    }

    // MARK: - Content

    private var limitationContent: some View {
        let section = LimitationsData.section(for: selectedCategory)

        return ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Section title
                Text(section.title)
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.amber)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 12)

                // Verify tag if present
                if section.title.contains("VERIFY") {
                    HStack(spacing: 6) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 12))
                        Text("ETIHAD: DATA REQUIRES VERIFICATION")
                            .font(AppTheme.captionFont)
                    }
                    .foregroundColor(AppTheme.amber)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                }

                Divider()
                    .background(AppTheme.lightGray.opacity(0.2))

                // Limitation rows
                ForEach(section.items) { item in
                    limitationRow(item)

                    Divider()
                        .background(AppTheme.lightGray.opacity(0.1))
                        .padding(.leading, item.isSubItem ? 52 : 20)
                }
            }
            .padding(.bottom, 40)
        }
    }

    private func limitationRow(_ item: LimitationItem) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top, spacing: 0) {
                // Left: name
                HStack(spacing: 8) {
                    if item.isSubItem {
                        Text("—")
                            .font(AppTheme.bodyFont)
                            .foregroundColor(AppTheme.lightGray)
                            .frame(width: 16)
                    }

                    if item.isWarning {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.red)
                    }

                    Text(item.name)
                        .font(item.isSubItem ? AppTheme.bodyFont : .system(size: 14, weight: .semibold))
                        .foregroundColor(item.isWarning ? AppTheme.red : AppTheme.white)
                        .textCase(.uppercase)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Right: value
                if !item.value.isEmpty {
                    Text(item.value)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(item.isWarning ? AppTheme.red : AppTheme.white)
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }

            // Note
            if let note = item.note {
                Text(note)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.lightGray)
                    .padding(.leading, item.isSubItem ? 24 : 0)
            }
        }
        .padding(.horizontal, 20)
        .padding(.leading, item.isSubItem ? 32 : 0)
        .padding(.vertical, 8)
    }
}
