import SwiftUI

struct SidebarItem: Identifiable, Hashable {
    let id: String
    let label: String
    let iconName: String

    init(_ label: String, icon: String = "circle.fill") {
        self.id = label
        self.label = label
        self.iconName = icon
    }
}

struct SidebarView: View {
    let items: [SidebarItem]
    @Binding var selectedItem: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 2) {
                ForEach(items) { item in
                    Button {
                        selectedItem = item.id
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: item.iconName)
                                .font(.system(size: 14))
                                .foregroundColor(selectedItem == item.id ? AppTheme.cyan : AppTheme.lightGray)
                                .frame(width: 20, height: 20)

                            Text(item.label)
                                .font(AppTheme.bodyFont)
                                .foregroundColor(selectedItem == item.id ? AppTheme.cyan : AppTheme.white)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)

                            Spacer()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            selectedItem == item.id
                                ? AppTheme.cyan.opacity(0.1)
                                : Color.clear
                        )
                        .cornerRadius(6)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 8)
        }
        .frame(width: AppTheme.sidebarWidth)
        .background(AppTheme.cardBackground)
    }
}
