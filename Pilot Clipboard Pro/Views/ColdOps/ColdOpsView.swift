import SwiftUI

struct ColdOpsView: View {
    @State private var selectedPhase = "DISPATCH"
    @State private var checkedItems: Set<UUID> = []

    private let sidebarItems: [SidebarItem] = [
        SidebarItem("DISPATCH", icon: "doc.text"),
        SidebarItem("AT THE GATE", icon: "airplane.circle"),
        SidebarItem("TAXI", icon: "road.lanes"),
        SidebarItem("DE-ICING BAY", icon: "snowflake"),
        SidebarItem("BEFORE TAKE-OFF", icon: "checkmark.circle"),
        SidebarItem("APPROACH", icon: "airplane.arrival"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            SidebarView(items: sidebarItems, selectedItem: $selectedPhase)

            coldOpsContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppTheme.background)
        }
    }

    // MARK: - Content

    private var coldOpsContent: some View {
        let phase = ColdOpsData.phase(for: selectedPhase)

        return VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Title
                    Text(phase.title)
                        .font(AppTheme.headingFont)
                        .foregroundColor(AppTheme.amber)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 12)

                    Divider().background(AppTheme.lightGray.opacity(0.2))

                    // Checklist items
                    ForEach(phase.items) { item in
                        if item.isSectionHeader {
                            sectionHeader(item.title)
                        } else {
                            checklistRow(item)

                            Divider()
                                .background(AppTheme.lightGray.opacity(0.1))
                                .padding(.leading, 52)
                        }
                    }
                }
                .padding(.bottom, 40)
            }

            // Bottom buttons
            bottomBar
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(AppTheme.subheadingFont)
            .foregroundColor(AppTheme.amber)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 8)
    }

    private func checklistRow(_ item: ColdOpsItem) -> some View {
        let isChecked = checkedItems.contains(item.id)

        return HStack(spacing: 12) {
            Button {
                if isChecked {
                    checkedItems.remove(item.id)
                } else {
                    checkedItems.insert(item.id)
                }
            } label: {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .font(.system(size: 20))
                    .foregroundColor(isChecked ? AppTheme.cyan : AppTheme.cyan.opacity(0.6))
            }
            .buttonStyle(.plain)

            Text(item.title)
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.cyan)
                .strikethrough(isChecked, color: AppTheme.cyan.opacity(0.4))

            Spacer()

            if item.hasInfo {
                Button {
                    // TODO: Show info popup
                } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 16))
                        .foregroundColor(AppTheme.lightGray)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }

    // MARK: - Bottom Bar

    private var bottomBar: some View {
        HStack(spacing: 16) {
            Spacer()

            Button {
                // Reset current page only
                let phase = ColdOpsData.phase(for: selectedPhase)
                for item in phase.items {
                    checkedItems.remove(item.id)
                }
            } label: {
                Text("RESET PAGE")
                    .font(AppTheme.labelFont)
                    .foregroundColor(AppTheme.lightGray)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(AppTheme.lightGray.opacity(0.4), lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)

            Button {
                checkedItems.removeAll()
            } label: {
                Text("RESET ALL")
                    .font(AppTheme.labelFont)
                    .foregroundColor(AppTheme.red)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(AppTheme.red.opacity(0.4), lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(AppTheme.cardBackground)
    }
}
