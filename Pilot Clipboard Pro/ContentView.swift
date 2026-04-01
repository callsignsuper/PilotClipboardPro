import SwiftUI

enum MainTab: String, CaseIterable {
    case ownChecks = "OWN CHECKS"
    case preFlight = "PRE-FLT"
    case cruise = "CRZ"
    case approach = "APP"
    case pa = "PA"
    case notes = "NOTES"
    case contextual = "CONTEXTUAL"

    var iconName: String {
        switch self {
        case .ownChecks: return "doc.on.clipboard"
        case .preFlight: return "checkmark.square"
        case .cruise: return "airplane"
        case .approach: return "airplane.arrival"
        case .pa: return "speaker.wave.2"
        case .notes: return "pencil"
        case .contextual: return "square.grid.2x2"
        }
    }
}

enum MenuSection: String, CaseIterable, Identifiable {
    case limitations = "LIMITATIONS"
    case memoryItems = "MEMORY ITEMS"
    case diversion = "DIVERSION"
    case coldOps = "COLD OPS"
    case grf = "GRF"
    case snowtamRU = "SNOWTAM (RU)"
    case ftl = "FTL"
    case personalNotes = "PERSONAL NOTES"
    case loading = "LOADING"
    case settings = "SETTINGS"
    case support = "SUPPORT"
    case disclaimer = "DISCLAIMER"
    case whatsNew = "WHAT'S NEW?"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .limitations: return "exclamationmark.triangle"
        case .memoryItems: return "brain"
        case .diversion: return "arrow.triangle.branch"
        case .coldOps: return "snowflake"
        case .grf: return "cloud.snow"
        case .snowtamRU: return "cloud.snow"
        case .ftl: return "clock"
        case .personalNotes: return "note.text"
        case .loading: return "airplane.circle"
        case .settings: return "gearshape"
        case .support: return "envelope"
        case .disclaimer: return "doc.text"
        case .whatsNew: return "star"
        }
    }
}

struct ContentView: View {
    @State private var selectedTab: MainTab = .preFlight
    @State private var showMenu = false
    @State private var activeMenuSection: MenuSection? = nil

    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 0) {
                // Top bar
                topBar

                // Main content
                Group {
                    if let section = activeMenuSection, selectedTab == .contextual {
                        contextualView(for: section)
                    } else {
                        tabContentView
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Tab bar
                tabBar
            }
            .background(AppTheme.background)

            // Menu overlay
            if showMenu {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture { showMenu = false }

                menuDrawer
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: showMenu)
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            Button {
                showMenu.toggle()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "line.3.horizontal")
                    Text("MENU")
                        .font(AppTheme.labelFont)
                }
                .foregroundColor(AppTheme.white)
            }
            .padding(.leading, 16)

            Spacer()

            Text(topBarTitle)
                .font(AppTheme.subheadingFont)
                .foregroundColor(AppTheme.amber)

            Spacer()

            // Placeholder for top-right buttons
            Color.clear.frame(width: 60)
        }
        .frame(height: 44)
        .background(AppTheme.cardBackground)
    }

    private var topBarTitle: String {
        if let section = activeMenuSection, selectedTab == .contextual {
            return section.rawValue
        }
        return selectedTab.rawValue
    }

    // MARK: - Tab Bar

    private var tabBar: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                tabButton(for: tab)
            }
        }
        .frame(height: AppTheme.tabBarHeight)
        .background(AppTheme.cardBackground)
    }

    private func tabButton(for tab: MainTab) -> some View {
        Button {
            if tab == .contextual && activeMenuSection == nil {
                return
            }
            selectedTab = tab
        } label: {
            VStack(spacing: 3) {
                Image(systemName: tab == .contextual ? (activeMenuSection?.iconName ?? tab.iconName) : tab.iconName)
                    .font(.system(size: 18))

                Text(tab == .contextual ? (activeMenuSection?.rawValue ?? "") : tab.rawValue)
                    .font(AppTheme.tabFont)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .foregroundColor(selectedTab == tab ? AppTheme.cyan : AppTheme.lightGray)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Tab Content

    @ViewBuilder
    private var tabContentView: some View {
        switch selectedTab {
        case .ownChecks:
            OwnChecksPlaceholderView()
        case .preFlight:
            PreFlightPlaceholderView()
        case .cruise:
            CruisePlaceholderView()
        case .approach:
            ApproachPlaceholderView()
        case .pa:
            PAView()
        case .notes:
            NotesPlaceholderView()
        case .contextual:
            if let section = activeMenuSection {
                contextualView(for: section)
            } else {
                placeholderContent("Select a section from the menu")
            }
        }
    }

    @ViewBuilder
    private func contextualView(for section: MenuSection) -> some View {
        switch section {
        case .limitations:
            LimitationsView()
        case .memoryItems:
            MemoryItemsView()
        case .diversion:
            DiversionPlaceholderView()
        case .coldOps:
            ColdOpsView()
        case .grf, .snowtamRU:
            GRFPlaceholderView()
        case .ftl:
            FTLPlaceholderView()
        case .loading:
            LoadingPlaceholderView()
        case .settings:
            SettingsPlaceholderView()
        case .personalNotes:
            placeholderContent("PERSONAL NOTES")
        case .support:
            placeholderContent("SUPPORT\n\nEtihad A380 Clipboard\nVersion 1.0")
        case .disclaimer:
            placeholderContent("DISCLAIMER")
        case .whatsNew:
            placeholderContent("WHAT'S NEW?\n\nVersion 1.0 — Initial Release")
        }
    }

    private func placeholderContent(_ text: String) -> some View {
        VStack {
            Spacer()
            Text(text)
                .font(AppTheme.headingFont)
                .foregroundColor(AppTheme.lightGray)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.background)
    }

    // MARK: - Menu Drawer

    private var menuDrawer: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 4) {
                Text("ETIHAD A380")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(AppTheme.cyan)
                Text("CLIPBOARD")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppTheme.amber)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)

            Divider().background(AppTheme.lightGray.opacity(0.3))

            // Menu items
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(MenuSection.allCases) { section in
                        Button {
                            activeMenuSection = section
                            selectedTab = .contextual
                            showMenu = false
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: section.iconName)
                                    .font(.system(size: 16))
                                    .frame(width: 24)
                                    .foregroundColor(
                                        activeMenuSection == section ? AppTheme.cyan : AppTheme.lightGray
                                    )

                                Text(section.rawValue)
                                    .font(AppTheme.bodyFont)
                                    .foregroundColor(
                                        activeMenuSection == section ? AppTheme.cyan : AppTheme.white
                                    )

                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(
                                activeMenuSection == section
                                    ? AppTheme.cyan.opacity(0.1)
                                    : Color.clear
                            )
                        }
                        .buttonStyle(.plain)

                        if section == .loading || section == .whatsNew {
                            Divider()
                                .background(AppTheme.lightGray.opacity(0.3))
                                .padding(.vertical, 4)
                        }
                    }
                }
            }

            Divider().background(AppTheme.lightGray.opacity(0.3))

            // Footer
            HStack {
                Spacer()
                Text("v1.0.0")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.lightGray)
                Spacer()
            }
            .padding(.vertical, 12)
        }
        .frame(width: 280)
        .background(Color(hex: 0x0D0D0D))
        .ignoresSafeArea(edges: .vertical)
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
