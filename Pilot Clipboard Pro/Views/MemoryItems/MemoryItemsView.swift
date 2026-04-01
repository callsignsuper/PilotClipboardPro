import SwiftUI

struct MemoryItemsView: View {
    @State private var selectedCategory = "EMERGENCY DESCENT"

    private let sidebarItems: [SidebarItem] = [
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
            SidebarView(items: sidebarItems, selectedItem: $selectedCategory)

            let item = MemoryItemsData.item(for: selectedCategory)

            HStack(spacing: 0) {
                // Left: Immediate Actions (60%)
                immediateActionsColumn(item)
                    .frame(maxWidth: .infinity)

                Divider()
                    .background(AppTheme.lightGray.opacity(0.3))

                // Right: Supplementary (40%)
                supplementaryColumn(item)
                    .frame(maxWidth: .infinity)
            }
            .background(AppTheme.background)
        }
    }

    // MARK: - Immediate Actions Column

    private func immediateActionsColumn(_ item: MemoryItem) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("IMMEDIATE ACTIONS (BOXED)")
                    .font(AppTheme.subheadingFont)
                    .foregroundColor(AppTheme.amber)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 8)

                Text(item.title)
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.white)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)

                ForEach(item.immediateActions) { step in
                    procedureStepView(step)
                }
            }
            .padding(.bottom, 40)
        }
    }

    private func procedureStepView(_ step: ProcedureStep) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            // Condition
            if let condition = step.condition {
                Text(condition)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.amber)
                    .padding(.horizontal, 16)
                    .padding(.top, 4)
            }

            // Action row
            if step.isBoxed {
                boxedRow(step)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
            } else if step.value.isEmpty && !step.action.isEmpty {
                // Header/label only
                Text(step.action)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(step.color.foreground)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
            } else if !step.action.isEmpty {
                // Normal action/value row
                HStack {
                    Text(step.action)
                        .font(AppTheme.bodyFont)
                        .foregroundColor(step.color.foreground)
                    Spacer()
                    if !step.value.isEmpty {
                        Text(step.value)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(step.color.foreground)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
        }
    }

    private func boxedRow(_ step: ProcedureStep) -> some View {
        HStack {
            Text(step.action)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(AppTheme.white)

            if !step.action.isEmpty && !step.value.isEmpty {
                // Dotted leader
                GeometryReader { geo in
                    Path { path in
                        let y = geo.size.height / 2
                        var x: CGFloat = 0
                        while x < geo.size.width {
                            path.move(to: CGPoint(x: x, y: y))
                            path.addLine(to: CGPoint(x: x + 2, y: y))
                            x += 6
                        }
                    }
                    .stroke(AppTheme.lightGray.opacity(0.4), lineWidth: 1)
                }
                .frame(height: 16)
            }

            if !step.value.isEmpty {
                Text(step.value)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppTheme.white)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(AppTheme.white, lineWidth: 1.5)
        )
    }

    // MARK: - Supplementary Column

    private func supplementaryColumn(_ item: MemoryItem) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("SUPPLEMENTARY INFO")
                    .font(AppTheme.subheadingFont)
                    .foregroundColor(AppTheme.amber)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 12)

                Text(item.supplementary)
                    .font(AppTheme.bodyFont)
                    .foregroundColor(AppTheme.lightGray)
                    .padding(.horizontal, 16)
                    .lineSpacing(4)
            }
            .padding(.bottom, 40)
        }
    }
}
