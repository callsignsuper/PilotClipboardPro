import SwiftUI

struct SettingsPlaceholderView: View {
    @State private var stdAlerts = false
    @State private var auralWarnings = false
    @State private var scratchpadVisible = true
    @State private var calculatorVisible = false
    @State private var sleepMode = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("SETTINGS")
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.amber)
                    .padding(.bottom, 8)

                settingToggle("STD TIME ALERTS", isOn: $stdAlerts)
                settingToggle("AURAL WARNINGS", isOn: $auralWarnings)
                settingToggle("PRE-FLIGHT SCRATCHPAD VISIBLE", isOn: $scratchpadVisible)
                settingToggle("CALCULATOR ALWAYS VISIBLE", isOn: $calculatorVisible)
                settingToggle("SLEEP MODE", isOn: $sleepMode)

                Divider().background(AppTheme.lightGray.opacity(0.3))

                Text("EDIT PRE-FLT CHECKLIST")
                    .font(AppTheme.subheadingFont)
                    .foregroundColor(AppTheme.white)
                Text("Long-press any checklist item to customize its title")
                    .font(AppTheme.bodyFont)
                    .foregroundColor(AppTheme.lightGray)
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppTheme.background)
    }

    private func settingToggle(_ title: String, isOn: Binding<Bool>) -> some View {
        HStack {
            Text(title)
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.white)
            Spacer()
            Toggle("", isOn: isOn)
                .tint(AppTheme.cyan)
                .labelsHidden()
        }
        .padding(.horizontal, 8)
    }
}
