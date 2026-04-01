import Foundation

// MARK: - Data Structures

struct LimitationSection: Identifiable {
    let id: String
    let title: String
    let items: [LimitationItem]
}

struct LimitationItem: Identifiable {
    let id = UUID()
    let name: String
    let value: String
    let isSubItem: Bool
    let note: String?
    let isWarning: Bool

    init(_ name: String, _ value: String, isSubItem: Bool = false, note: String? = nil, isWarning: Bool = false) {
        self.name = name
        self.value = value
        self.isSubItem = isSubItem
        self.note = note
        self.isWarning = isWarning
    }
}

// MARK: - All Limitations Data

enum LimitationsData {

    static let categories: [String] = [
        "APU", "AUTOPILOT", "BTV", "ENG", "FLAPS",
        "FO LIMITATIONS", "FUEL", "L/G", "OIL",
        "OXYGEN", "WIND", "WINDOWS / DOORS"
    ]

    static func section(for category: String) -> LimitationSection {
        switch category {
        case "APU": return apu
        case "AUTOPILOT": return autopilot
        case "BTV": return btv
        case "ENG": return eng
        case "FLAPS": return flaps
        case "FO LIMITATIONS": return foLimitations
        case "FUEL": return fuel
        case "L/G": return landingGear
        case "OIL": return oil
        case "OXYGEN": return oxygen
        case "WIND": return wind
        case "WINDOWS / DOORS": return windowsDoors
        default: return LimitationSection(id: category, title: category, items: [])
        }
    }

    // MARK: - APU

    static let apu = LimitationSection(id: "APU", title: "APU LIMITATIONS", items: [
        LimitationItem("APU START", "Wait 5 sec before pushing APU START P/B ON after MASTER SW ON"),
        LimitationItem("IN CASE OF ABORTED START OR APU SHUTDOWN", "Wait 60 seconds", isSubItem: true),
        LimitationItem("AFTER 3 ATTEMPTS", "Wait 1h before another attempt", isSubItem: true),
        LimitationItem("APU GENERATORS — ON GND", "Both GEN's supply A/C"),
        LimitationItem("APU GENERATORS — IN FLT", "1 GEN up to 22,500 ft"),
        LimitationItem("APU BLEED", "Supplied up to 22,500 ft", note: "Provided SPD below M0.56"),
        LimitationItem("APU START IN FLT", "Up to 20,000 ft"),
    ])

    // MARK: - AUTOPILOT

    static let autopilot = LimitationSection(id: "AUTOPILOT", title: "AUTOPILOT LIMITATIONS", items: [
        LimitationItem("AUTOPILOT MIN HEIGHT", ""),
        LimitationItem("At T.O.", "100 ft AGL and 5 seconds", isSubItem: true),
        LimitationItem("At Landing", "10 Kt", isSubItem: true),
        LimitationItem("ILS with APPR1", "160 ft", isSubItem: true),
        LimitationItem("NON-PRECISION APP", "200 ft", isSubItem: true),
        LimitationItem("CIRCLING", "200 ft", isSubItem: true),
        LimitationItem("AFTER G/A", "100 ft", isSubItem: true),
        LimitationItem("ALL OTHER", "500 ft", isSubItem: true),
    ])

    // MARK: - BTV

    static let btv = LimitationSection(id: "BTV", title: "BTV (BRAKE TO VACATE) LIMITATIONS", items: [
        LimitationItem("MAX DISCREPANCY BETWEEN RWY LENGTH AND OANS", "35 m"),
        LimitationItem("BTV DECELERATION TARGET", "10 Kt approx. at 65 m from selected exit", note: "Other limitations and informations:"),
        LimitationItem("CONTAMINATED RWY", "BTV NOT PERMITTED (MUST USE BRK HIGH)", isWarning: true),
        LimitationItem("ECAM IMPACTING LDG PERF", "BTV NOT AVAILABLE", isWarning: true),
        LimitationItem("REV INOP", "BTV NOT AVAILABLE", isWarning: true),
        LimitationItem("FMS RWY CHANGED AFTER BTV SET", "Above 700 ft: BTV will disarm\nBelow 700 ft: reconfigures to AUTO BRK HI"),
    ])

    // MARK: - ENG

    static let eng = LimitationSection(id: "ENG", title: "ENGINE LIMITATIONS (GP7200)", items: [
        LimitationItem("ENG START", "3 periods of 5 min CONTINUOUS STARTER"),
        LimitationItem("COOLING TIME", "2 min FOR EACH MINUTE STARTER TIME"),
        LimitationItem("STARTER ACCUMULATES 15 min", "Cooldown for 30 minutes"),
        LimitationItem("FLEX THR", "NOT ALLOWED ON CONTAMINATED RWYs", isWarning: true),
        LimitationItem("SOFT G/A", "NOT PERMITTED ON MAP GRADIENTS > 8%", isWarning: true),
        LimitationItem("TAILWIND IMPACT ON ENG START", "Winds greater than 25 kts"),
    ])

    // MARK: - FLAPS

    static let flaps = LimitationSection(id: "FLAPS", title: "FLAPS LIMITATIONS", items: [
        LimitationItem("FLAPS MAX ALT EXTENDED", "20,000 ft", note: "Due to compressibility of air"),
    ])

    // MARK: - FO LIMITATIONS

    static let foLimitations = LimitationSection(id: "FO LIMITATIONS", title: "FIRST OFFICER LIMITATIONS [ETIHAD: VERIFY]", items: [
        LimitationItem("FO SHALL NOT CONDUCT T.O. AND LANDING WHEN:", ""),
        LimitationItem("a) RWY CONDITION CODE", "Less than 5", isSubItem: true),
        LimitationItem("b) CROSSWIND incl. GUSTS", "Exceeds 20 kt", isSubItem: true),
        LimitationItem("c) AERODROME", "'Commander only (T.O. and landing)' aerodrome", isSubItem: true),
        LimitationItem("d) RVR/VISIBILITY FOR T.O.", "500 m or less", isSubItem: true),
        LimitationItem("e) APPROACH CONDUCTED", "CAT I ILS/GLS with autoland, CAT II, or CAT III", isSubItem: true),
        LimitationItem("NOTE", "For landing in non-normal/abnormal situation, refer to 1.5.4.1", note: nil),
    ])

    // MARK: - FUEL

    static let fuel = LimitationSection(id: "FUEL", title: "FUEL LIMITATIONS", items: [
        LimitationItem("FUEL MIN TEMP — JET A1", "-47°C"),
        LimitationItem("FUEL MIN TEMP — JET A", "-40°C"),
        LimitationItem("FUEL MIN TEMP — JP8", "-47°C"),
        LimitationItem("FUEL MIN TEMP — JP5", "-46°C"),
        LimitationItem("FUEL MAX TEMP", "+53°C"),
        LimitationItem("MAX IMBALANCE — FEEDS 1 AND 4", "3,000 kg"),
        LimitationItem("MAX IMBALANCE — FEEDS 2 AND 3", "3,000 kg"),
        LimitationItem("MAX IMBALANCE — INNER", "3,000 kg"),
        LimitationItem("MAX IMBALANCE — MID", "2,500 kg"),
        LimitationItem("MAX IMBALANCE — OUTER", "1,200 kg"),
        LimitationItem("NOTE", "In Abnormal conditions (Fuel Sys Fail) above values may be exceeded"),
        LimitationItem("MAX UPLIFT ERROR", "Depends on uplifted Qty — check FCOM table"),
    ])

    // MARK: - L/G

    static let landingGear = LimitationSection(id: "L/G", title: "LANDING GEAR LIMITATIONS", items: [
        LimitationItem("MAX ALT L/G EXTENDED", "21,000 ft", note: "Emergency: respect SPD limit M0.55"),
        LimitationItem("L/G GRVTY EXT MAX SPD", "220 Kt / M0.48"),
        LimitationItem("VLO (MAX L/G OPERATING)", "250 Kt / M0.55"),
        LimitationItem("VLE (MAX L/G EXTENDED)", "250 Kt / M0.55"),
        LimitationItem("TIRES MAX GROUND SPD", "204 Kt"),
        LimitationItem("TIRES DEFLATED MAX SPD", "3 Kt"),
        LimitationItem("BRK MAX TEMP FOR T.O.", "300°C"),
        LimitationItem("BTV MAX DISCREPANCY RWY/OANS", "35 m"),
    ])

    // MARK: - OIL

    static let oil = LimitationSection(id: "OIL", title: "OIL LIMITATIONS — EA (GP7200)", items: [
        LimitationItem("FT BELOW 10 h", "MIN 10 qts"),
        LimitationItem("FT AT OR ABOVE 10 h", "MIN 6 qts + 0.4 qt/h"),
        LimitationItem("MAX OIL CONSUMPTION", "0.4 qt/h (normal operations)"),
    ])

    // MARK: - OXYGEN

    static let oxygen = LimitationSection(id: "OXYGEN", title: "OXYGEN LIMITATIONS", items: [
        // FD section
        LimitationItem("FLIGHT DECK OXYGEN", ""),
        LimitationItem("IF NO FLT DECK OXY AVAILABLE", "MAX FL250 ONLY", isSubItem: true, note: "Provided portable OXY bottles are available for each pilot", isWarning: true),
        // Cabin section — With First Class (Etihad standard)
        LimitationItem("CABIN OXYGEN — WITH FIRST CLASS", ""),
        LimitationItem("ROUTES WITH DEPRESS. STRATEGIES IN OFP", "1,300 PSI", isSubItem: true),
        LimitationItem("ROUTES WITH STRATEGIES IN DRIFTDOWN CHART", "1,650 PSI", isSubItem: true),
        LimitationItem("ROUTES WHERE LIDO-OFP COULD NOT CALCULATE", "Company NOTAMS", isSubItem: true),
        LimitationItem("BASIS", "552 passengers and cabin crew", isSubItem: true),
    ])

    // MARK: - WIND

    static let wind = LimitationSection(id: "WIND", title: "WIND LIMITATIONS [ETIHAD: VERIFY]", items: [
        LimitationItem("MAX CERTIFIED X-WIND AT T.O.", "35 Kt", note: "Due to Engines limitations"),
        LimitationItem("MAX CERTIFIED X-WIND AT LANDING", "40 Kt", note: "Gust included"),
        LimitationItem("MAX CERTIFIED X-WIND FOR FO", "20 Kt"),
        LimitationItem("MAX TAILWIND FOR T.O.", "15 Kt"),
        LimitationItem("AUTO APP/LDG/ROLL-OUT", "GLS CAT I, ILS CAT II, ILS CAT III"),
        LimitationItem("MAX HEADWIND", "38 Kt", isSubItem: true),
        LimitationItem("MAX X-WIND", "30 Kt", isSubItem: true),
        LimitationItem("MAX TAILWIND — AIRPORTS BELOW 8000 ft", "15 Kt *", isSubItem: true),
        LimitationItem("MAX TAILWIND — AIRPORTS ABOVE 8000 ft", "10 Kt", isSubItem: true),
        LimitationItem("* EA ENGINES ONLY", "If tailwind > 10 kt, FLAPS 3 NOT permitted for landing", note: "As reported by ATC or ATIS"),
    ])

    // MARK: - WINDOWS / DOORS

    static let windowsDoors = LimitationSection(id: "WINDOWS / DOORS", title: "WINDOWS / DOORS LIMITATIONS", items: [
        LimitationItem("WINDOW MAX SPD (OPENING)", "250 Kt"),
        LimitationItem("WINDOW MAX SPD (CLOSING)", "160 Kt"),
        LimitationItem("NOTE", "Opening CKPT WINDOW is not possible with PACKS ON"),
        LimitationItem("WINDSHIELD WIPERS MAX SPD", "250 Kt"),
        LimitationItem("CKPT WINDOW CRACKED (INTERNAL LAYER)", "MAX FL 230"),
        LimitationItem("CABIN DOOR OPERATION MAX SPD", "40 Kt", note: "Nose into wind: 50 Kt"),
        LimitationItem("CARGO DOOR OPERATION MAX SPD", "40 Kt", note: "Nose into wind or leeward side: 50 Kt"),
        LimitationItem("DOORS MUST BE CLOSED BEFORE WIND REACHES", "60 Kts", isWarning: true),
    ])
}
