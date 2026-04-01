import SwiftUI

struct PAView: View {
    @State private var selectedCategory = "PRE - DEPARTURE"
    @State private var selectedSubTab: String? = nil

    private let sidebarItems: [SidebarItem] = [
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
            // Custom sidebar with emergency coloring
            paSidebar

            // Content
            paContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppTheme.background)
        }
        .onChange(of: selectedCategory) { _, _ in
            selectedSubTab = nil
        }
    }

    // MARK: - Custom Sidebar with Emergency Colors

    private var paSidebar: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 2) {
                ForEach(sidebarItems) { item in
                    let isEmergency = PAScriptsData.emergencyCategories.contains(item.id)

                    Button {
                        selectedCategory = item.id
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: item.iconName)
                                .font(.system(size: 14))
                                .foregroundColor(itemColor(for: item.id, isEmergency: isEmergency))
                                .frame(width: 20, height: 20)

                            Text(item.label)
                                .font(AppTheme.bodyFont)
                                .foregroundColor(itemColor(for: item.id, isEmergency: isEmergency))
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)

                            Spacer()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            selectedCategory == item.id
                                ? (isEmergency ? AppTheme.red.opacity(0.15) : AppTheme.cyan.opacity(0.1))
                                : Color.clear
                        )
                        .cornerRadius(6)
                    }
                    .buttonStyle(.plain)

                    // Divider before emergency items
                    if item.id == "AFTER G.A." {
                        Divider()
                            .background(AppTheme.red.opacity(0.3))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                    }
                }
            }
            .padding(.vertical, 8)
        }
        .frame(width: AppTheme.sidebarWidth)
        .background(AppTheme.cardBackground)
    }

    private func itemColor(for id: String, isEmergency: Bool) -> Color {
        if selectedCategory == id {
            return isEmergency ? AppTheme.red : AppTheme.cyan
        }
        return isEmergency ? AppTheme.red.opacity(0.7) : AppTheme.white
    }

    // MARK: - Content

    private var paContent: some View {
        let paScript = PAScriptsData.script(for: selectedCategory)

        return ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Title
                HStack {
                    if paScript.isEmergency {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(AppTheme.red)
                    }

                    Text(paScript.title)
                        .font(AppTheme.headingFont)
                        .foregroundColor(paScript.isEmergency ? AppTheme.red : AppTheme.amber)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 8)

                if paScript.title.contains("VERIFY") || paScript.script.contains("VERIFY") {
                    HStack(spacing: 6) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 12))
                        Text("ETIHAD: SCRIPT REQUIRES VERIFICATION")
                            .font(AppTheme.captionFont)
                    }
                    .foregroundColor(AppTheme.amber)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
                }

                Divider().background(AppTheme.lightGray.opacity(0.2))

                // Sub-tabs if available
                if let subTabs = paScript.subTabs {
                    subTabBar(subTabs, isEmergency: paScript.isEmergency)

                    if let selected = selectedSubTab,
                       let tab = subTabs.first(where: { $0.id == selected }) {
                        scriptText(tab.script, isEmergency: paScript.isEmergency)
                    } else if let first = subTabs.first {
                        scriptText(first.script, isEmergency: paScript.isEmergency)
                    }
                } else {
                    scriptText(paScript.script, isEmergency: paScript.isEmergency)
                }
            }
            .padding(.bottom, 40)
        }
    }

    private func subTabBar(_ tabs: [PASubTab], isEmergency: Bool) -> some View {
        HStack(spacing: 8) {
            ForEach(tabs) { tab in
                let isSelected = (selectedSubTab ?? tabs.first?.id) == tab.id

                Button {
                    selectedSubTab = tab.id
                } label: {
                    Text(tab.label)
                        .font(AppTheme.labelFont)
                        .foregroundColor(isSelected ? (isEmergency ? AppTheme.red : AppTheme.cyan) : AppTheme.lightGray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(
                                    isSelected ? (isEmergency ? AppTheme.red : AppTheme.cyan) : AppTheme.lightGray.opacity(0.3),
                                    lineWidth: isSelected ? 1.5 : 1
                                )
                        )
                }
                .buttonStyle(.plain)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
    }

    private func scriptText(_ text: String, isEmergency: Bool) -> some View {
        Text(text)
            .font(.system(size: 15, weight: isEmergency ? .bold : .regular))
            .foregroundColor(isEmergency ? AppTheme.red : AppTheme.white)
            .lineSpacing(6)
            .padding(.horizontal, 24)
            .padding(.top, 8)
    }
}
