import SwiftUI

struct PreFlightPlaceholderView: View {
    var body: some View {
        HStack(spacing: 0) {
            // Left checklist column
            VStack(alignment: .leading) {
                Text("PRE-FLIGHT CHECKLIST")
                    .font(AppTheme.subheadingFont)
                    .foregroundColor(AppTheme.amber)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(preFlightItems, id: \.self) { item in
                            HStack(spacing: 12) {
                                Image(systemName: "square")
                                    .font(.system(size: 18))
                                    .foregroundColor(AppTheme.cyan.opacity(0.6))
                                Text(item)
                                    .font(AppTheme.bodyFont)
                                    .foregroundColor(AppTheme.cyan)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                        }
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(AppTheme.background)

            // Center column
            VStack(alignment: .leading) {
                Text("LOADSHEET")
                    .font(AppTheme.subheadingFont)
                    .foregroundColor(AppTheme.amber)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(AppTheme.background)

            // Right panel
            VStack {
                Text("UTC")
                    .font(AppTheme.labelFont)
                    .foregroundColor(AppTheme.amber)
                    .padding(.top, 12)

                Text("--:--:--")
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                    .foregroundColor(AppTheme.white)

                Spacer()
            }
            .frame(width: 250)
            .background(AppTheme.cardBackground)
        }
        .background(AppTheme.background)
    }

    private var preFlightItems: [String] {
        [
            "BRAKES TEMP",
            "BATT CHECK / ADIRs",
            "POWER UP",
            "OIS",
            "TECH LOG / MEL",
            "A/C CONF. DIFF / O.E.B.s",
            "APU / ENG FIRE TEST",
            "APU START - CONSIDER",
            "T.O.P.A.",
            "NADP",
            "DE-RATES",
            "US Units"
        ]
    }
}
