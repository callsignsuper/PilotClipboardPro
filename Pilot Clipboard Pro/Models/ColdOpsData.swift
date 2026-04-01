import Foundation

// MARK: - Data Structures

struct ColdOpsPhase: Identifiable {
    let id: String
    let title: String
    let items: [ColdOpsItem]
}

struct ColdOpsItem: Identifiable {
    let id = UUID()
    let title: String
    let hasInfo: Bool
    let isSectionHeader: Bool

    init(_ title: String, hasInfo: Bool = false, isSectionHeader: Bool = false) {
        self.title = title
        self.hasInfo = hasInfo
        self.isSectionHeader = isSectionHeader
    }
}

// MARK: - All Cold Ops Data

enum ColdOpsData {

    static let phases: [String] = [
        "DISPATCH",
        "AT THE GATE",
        "TAXI",
        "DE-ICING BAY",
        "BEFORE TAKE-OFF",
        "APPROACH",
    ]

    static func phase(for name: String) -> ColdOpsPhase {
        switch name {
        case "DISPATCH": return dispatch
        case "AT THE GATE": return atTheGate
        case "TAXI": return taxi
        case "DE-ICING BAY": return deIcingBay
        case "BEFORE TAKE-OFF": return beforeTakeoff
        case "APPROACH": return approach
        default: return ColdOpsPhase(id: name, title: name, items: [])
        }
    }

    // MARK: - Dispatch

    static let dispatch = ColdOpsPhase(id: "DISPATCH", title: "DISPATCH", items: [
        ColdOpsItem("WX REPORT", hasInfo: true),
        ColdOpsItem("RCAM & SNOWTAM — CONTAMINATION TYPE", hasInfo: true),
        ColdOpsItem("AIRPORT SPECIAL PROCEDURES"),
        ColdOpsItem("PERFORMANCE BASIS FOR T.O.", hasInfo: true),
        ColdOpsItem("TAKE-OFF ALTERNATE", hasInfo: true),
        ColdOpsItem("REVIEW", isSectionHeader: true),
        ColdOpsItem("COLD WX OPS"),
        ColdOpsItem("HOT TABLES", hasInfo: true),
        ColdOpsItem("HOT TABLES WITH FREEZING CONDITIONS", hasInfo: true),
        ColdOpsItem("CONTAMINATION TYPE NOT ALLOWED", hasInfo: true),
        ColdOpsItem("DE-ICING / ANTI-ICING PROC"),
        ColdOpsItem("DE-ICING / ANTI-ICING WORKSHEET"),
        ColdOpsItem("SNOWFALL VS VISIBILITY TABLE", hasInfo: true),
        ColdOpsItem("COLD TEMP CORRECTIONS", hasInfo: true),
        ColdOpsItem("ENG ICE SHEDDING PROC"),
        ColdOpsItem("CABIN CREW — INFORM ABOUT DE-ICING"),
    ])

    // MARK: - At the Gate

    static let atTheGate = ColdOpsPhase(id: "AT THE GATE", title: "AT THE GATE", items: [
        ColdOpsItem("EXTERNAL INSPECTION — ICE/SNOW/FROST"),
        ColdOpsItem("APU BLEED — ON IF REQ. FOR HEATING"),
        ColdOpsItem("CONTAMINATION TYPE CHECK"),
        ColdOpsItem("WING ANTI-ICE — MONITOR IF NEEDED"),
        ColdOpsItem("HOT CHECK (IF ALREADY DE-ICED)"),
        ColdOpsItem("DE-ICING REQUEST IF REQUIRED"),
    ])

    // MARK: - Taxi

    static let taxi = ColdOpsPhase(id: "TAXI", title: "TAXI", items: [
        ColdOpsItem("TAXI SPEED — ADAPT TO CONDITIONS"),
        ColdOpsItem("RWY CONTAMINATION — CROSS-CHECK WITH SNOWTAM"),
        ColdOpsItem("WING ANTI-ICE"),
        ColdOpsItem("ENG ANTI-ICE"),
        ColdOpsItem("BRAKING ACTION — CHECK"),
        ColdOpsItem("CONTAMINATION TYPE — RE-CHECK"),
    ])

    // MARK: - De-Icing Bay

    static let deIcingBay = ColdOpsPhase(id: "DE-ICING BAY", title: "DE-ICING BAY", items: [
        ColdOpsItem("HOT CONFIRM"),
        ColdOpsItem("BRIEFING"),
        ColdOpsItem("DE-ICING / ANTI-ICING REPORT"),
    ])

    // MARK: - Before Take-Off

    static let beforeTakeoff = ColdOpsPhase(id: "BEFORE TAKE-OFF", title: "BEFORE TAKE-OFF", items: [
        ColdOpsItem("DE-ICING PROCEDURES"),
        ColdOpsItem("TAKE-OFF CONFIG SET"),
        ColdOpsItem("CHECKLISTS"),
        ColdOpsItem("MIN & MAX HOT LIMITS"),
        ColdOpsItem("PCI REQUIRED ?", hasInfo: true),
        ColdOpsItem("HEAVY SNOW CONDITIONS ?", hasInfo: true),
    ])

    // MARK: - Approach

    static let approach = ColdOpsPhase(id: "APPROACH", title: "APPROACH", items: [
        ColdOpsItem("COLD TEMP CORRECTIONS APPLIED"),
        ColdOpsItem("RWY CONDITION — RE-CHECK"),
        ColdOpsItem("BRAKING ACTION — CONFIRM"),
        ColdOpsItem("CONTAMINATION TYPE — VERIFY"),
        ColdOpsItem("AUTOLAND — RESTRICTIONS CHECK"),
        ColdOpsItem("GO-AROUND PROCEDURE — BRIEF"),
    ])
}
