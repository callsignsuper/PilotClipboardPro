import SwiftUI

// MARK: - Data Structures

struct MemoryItem: Identifiable {
    let id: String
    let title: String
    let immediateActions: [ProcedureStep]
    let supplementary: String
}

struct ProcedureStep: Identifiable {
    let id = UUID()
    let action: String
    let value: String
    let isBoxed: Bool
    let condition: String?
    let color: ProcedureColor

    init(_ action: String, _ value: String, isBoxed: Bool = false, condition: String? = nil, color: ProcedureColor = .normal) {
        self.action = action
        self.value = value
        self.isBoxed = isBoxed
        self.condition = condition
        self.color = color
    }
}

enum ProcedureColor {
    case normal      // white
    case annunciation // red/orange — callouts
    case pf          // cyan — Pilot Flying
    case pm          // green — Pilot Monitoring
    case caution     // amber

    var foreground: Color {
        switch self {
        case .normal: return .white
        case .annunciation: return AppTheme.red
        case .pf: return AppTheme.cyan
        case .pm: return Color(hex: 0x33CC33)
        case .caution: return AppTheme.amber
        }
    }
}

// MARK: - All Memory Items Data

enum MemoryItemsData {

    static let categories: [String] = [
        "EMERGENCY DESCENT",
        "UNRELIABLE SPEED INDICATION",
        "LOSS OF BRAKING",
        "REACTIVE WINDSHEAR WARNING",
        "TCAS",
        "TAWS",
        "TAWS (CAUTION)",
        "STALL INDICATIONS",
        "STALL WARNING AT LIFTOFF",
    ]

    static func item(for category: String) -> MemoryItem {
        switch category {
        case "EMERGENCY DESCENT": return emergencyDescent
        case "UNRELIABLE SPEED INDICATION": return unreliableSpeed
        case "LOSS OF BRAKING": return lossOfBraking
        case "REACTIVE WINDSHEAR WARNING": return reactiveWindshear
        case "TCAS": return tcas
        case "TAWS": return taws
        case "TAWS (CAUTION)": return tawsCaution
        case "STALL INDICATIONS": return stallIndications
        case "STALL WARNING AT LIFTOFF": return stallAtLiftoff
        default: return MemoryItem(id: category, title: category, immediateActions: [], supplementary: "")
        }
    }

    // MARK: - Emergency Descent

    static let emergencyDescent = MemoryItem(
        id: "EMERGENCY DESCENT",
        title: "EMERGENCY DESCENT",
        immediateActions: [
            ProcedureStep("ANNOUNCE", "\"EMERGENCY DESCENT\"", color: .annunciation),
            ProcedureStep("CREW OXY MASKS", "USE", isBoxed: true),
            ProcedureStep("SIGNS", "ON", isBoxed: true),
            ProcedureStep("EMER DESCENT", "INITIATE", isBoxed: true),
            ProcedureStep("ALT SEL KNOB", "TURN AND PULL"),
            ProcedureStep("HDG SEL KNOB", "TURN AND PULL"),
            ProcedureStep("SPD SEL KNOB", "PULL (INITIALLY)"),
            ProcedureStep("ALL THR LEVERS", "IDLE", isBoxed: true, condition: "IF A/THR NOT ACTIVE"),
            ProcedureStep("SPEED BRAKE LEVER", "FULL", isBoxed: true),
            ProcedureStep("SPEED", "MAX / APPROPRIATE", color: .caution),
            ProcedureStep("ATC", "NOTIFY"),
            ProcedureStep("EMER DESCENT (PA)", "ANNOUNCE"),
            ProcedureStep("ATC SQUAWK", "CONSIDER"),
            ProcedureStep("MAX FL", "100 / MEA / MORA"),
            ProcedureStep("PAX OXY MASKS MAN ON", "PRESS", condition: "IF CAB ALT ABOVE 14,000 FT"),
            ProcedureStep("CREW OXY MASKS DILUTION", "N", condition: "WHEN DESCENT ESTABLISHED"),
        ],
        supplementary: "PM checks FMA, PF presses SPD/MACH pb.\n\nWhen IDLE THR, high speed and SPD BRK extended, ROD approx 6,000 ft/min.\n\nFrom CRZ to FL100 approx 5 min / 40 NM.\n\nTCAS MUST remain on TA/RA.\n\nCAUTION: if structural damage suspected, use flight controls with care.\n\n\"This is the Captain. Descent, Descent.\""
    )

    // MARK: - Unreliable Speed Indication

    static let unreliableSpeed = MemoryItem(
        id: "UNRELIABLE SPEED INDICATION",
        title: "UNRELIABLE SPEED INDICATION",
        immediateActions: [
            ProcedureStep("FD", "OFF", isBoxed: true),
            ProcedureStep("A/THR", "OFF", isBoxed: true),
            ProcedureStep("PITCH / POWER", "SET", isBoxed: true, condition: "REFER TO TABLE"),
            ProcedureStep("A/P", "OFF — IF ENGAGED"),
            ProcedureStep("ISIS", "CROSS-CHECK"),
            ProcedureStep("GP/GS SELECTED", "CHECK"),
            ProcedureStep("ADR CHECK", "PERFORM"),
            ProcedureStep("UNRELIABLE SPD PROC", "APPLY"),
        ],
        supplementary: "Pitch / Power table:\n\n• CONF 0: PITCH 5° / N1 75%\n• CONF 1+F: PITCH 5° / N1 65%\n• CONF 2: PITCH 5° / N1 62%\n• CONF 3: PITCH 5° / N1 60%\n• CONF FULL: PITCH 5° / N1 58%\n\nUse GPS/GS to evaluate ground speed.\nADR disagreement may trigger.\nMonitor ISIS as primary reference."
    )

    // MARK: - Loss of Braking

    static let lossOfBraking = MemoryItem(
        id: "LOSS OF BRAKING",
        title: "LOSS OF BRAKING",
        immediateActions: [
            ProcedureStep("MAX REVERSE", "SELECT", isBoxed: true),
            ProcedureStep("PARKING BRAKE", "ON", isBoxed: true, condition: "IF A/C DOES NOT DECELERATE"),
            ProcedureStep("ATC", "NOTIFY"),
            ProcedureStep("EMER SERVICES", "REQUEST IF REQUIRED"),
        ],
        supplementary: "After landing, if deceleration is not as expected:\n\n1. Apply MAX reverse thrust immediately\n2. If aircraft does not decelerate, apply parking brake\n3. Notify ATC\n4. Request emergency services if required\n\nNote: Parking brake may cause tire burst at high speed."
    )

    // MARK: - Reactive Windshear Warning

    static let reactiveWindshear = MemoryItem(
        id: "REACTIVE WINDSHEAR WARNING",
        title: "REACTIVE WINDSHEAR WARNING",
        immediateActions: [
            ProcedureStep("WINDSHEAR, WINDSHEAR, WINDSHEAR", "", color: .annunciation),
            ProcedureStep("", "AT TAKE-OFF:", color: .caution),
            ProcedureStep("TOGA", "SET", isBoxed: true),
            ProcedureStep("ROTATE — IF NOT AIRBORNE", "AT VR OR CURRENT SPEED", isBoxed: true),
            ProcedureStep("FOLLOW SRS ORDERS", "", isBoxed: true),
            ProcedureStep("", "AT LANDING:", color: .caution),
            ProcedureStep("TOGA", "SET", isBoxed: true),
            ProcedureStep("FOLLOW SRS ORDERS", "", isBoxed: true),
            ProcedureStep("DO NOT CHANGE CONFIG", "UNTIL WINDSHEAR CLEARED"),
        ],
        supplementary: "PF ACTIONS:\n- Set TOGA thrust\n- Follow SRS pitch guidance\n- Do not change configuration\n\nPM ACTIONS:\n- Monitor parameters\n- Call out deviations\n\nDo NOT attempt to land.\nIf below 100 ft RA at T.O., rotation is critical.\n\nAfter windshear escape: evaluate fuel and consider diversion."
    )

    // MARK: - TCAS

    static let tcas = MemoryItem(
        id: "TCAS",
        title: "TCAS",
        immediateActions: [
            ProcedureStep("", "RA (Resolution Advisory):", color: .caution),
            ProcedureStep("A/P", "DISCONNECT", isBoxed: true),
            ProcedureStep("FOLLOW RA ORDERS", "FLY", isBoxed: true),
            ProcedureStep("A/THR", "AS REQUIRED"),
            ProcedureStep("ATC", "NOTIFY"),
            ProcedureStep("", "CLEAR OF CONFLICT:", color: .caution),
            ProcedureStep("RETURN TO ATC CLEARANCE", ""),
            ProcedureStep("A/P", "RE-ENGAGE AS REQUIRED"),
        ],
        supplementary: "TCAS RA takes priority over ATC instructions.\n\nFollow the green zone on the VSI.\n\nDo NOT maneuver in the opposite direction of the RA.\n\nIf \"ADJUST VERTICAL SPEED\" — reduce vertical rate to stay out of red zone.\n\nReport TCAS RA to ATC as soon as practical."
    )

    // MARK: - TAWS

    static let taws = MemoryItem(
        id: "TAWS",
        title: "TAWS (WARNING)",
        immediateActions: [
            ProcedureStep("TERRAIN, TERRAIN — PULL UP", "", color: .annunciation),
            ProcedureStep("A/P", "DISCONNECT", isBoxed: true),
            ProcedureStep("THRUST LEVERS", "TOGA", isBoxed: true),
            ProcedureStep("PITCH", "UP TO INITIAL PITCH 20°", isBoxed: true),
            ProcedureStep("SPEED BRAKE", "CHECK RETRACTED", isBoxed: true),
            ProcedureStep("LEVEL OFF", "WHEN CLEAR OF TERRAIN"),
        ],
        supplementary: "Do NOT attempt to investigate the cause during escape maneuver.\n\nMaintain TOGA and pitch until terrain is cleared.\n\nRetract speedbrake immediately if deployed.\n\nLanding gear: leave as-is during escape.\n\nAfter clearing terrain, notify ATC and assess situation."
    )

    // MARK: - TAWS (CAUTION)

    static let tawsCaution = MemoryItem(
        id: "TAWS (CAUTION)",
        title: "TAWS (CAUTION)",
        immediateActions: [
            ProcedureStep("TERRAIN AHEAD — CAUTION", "", color: .annunciation),
            ProcedureStep("ASSESS TERRAIN SITUATION", ""),
            ProcedureStep("IF TERRAIN CONFLICT", "FOLLOW TAWS WARNING PROCEDURE", isBoxed: true),
            ProcedureStep("IF NO TERRAIN CONFLICT", "CONTINUE APPROACH"),
            ProcedureStep("SPEED BRAKE", "CHECK RETRACTED"),
            ProcedureStep("ATC", "NOTIFY"),
        ],
        supplementary: "TAWS Caution may occur due to:\n- Terrain proximity during non-precision approach\n- Excessive descent rate\n- Premature descent\n\nPF assesses terrain clearance.\nPM cross-checks with charts.\n\nIf in doubt, execute TAWS WARNING escape maneuver."
    )

    // MARK: - Stall Indications

    static let stallIndications = MemoryItem(
        id: "STALL INDICATIONS",
        title: "STALL INDICATIONS",
        immediateActions: [
            ProcedureStep("STALL, STALL — CRICKET SOUND", "", color: .annunciation),
            ProcedureStep("A/P", "DISCONNECT", isBoxed: true),
            ProcedureStep("NOSE DOWN PITCH CONTROL", "APPLY", isBoxed: true),
            ProcedureStep("THRUST LEVERS", "TOGA", isBoxed: true),
            ProcedureStep("SPEED BRAKE", "CHECK RETRACTED", isBoxed: true),
            ProcedureStep("BANK", "WINGS LEVEL"),
            ProcedureStep("WHEN SPEED INCREASES", "RECOVER TO LEVEL FLIGHT"),
            ProcedureStep("AVOID SECONDARY STALL", ""),
        ],
        supplementary: "Priority: NOSE DOWN pitch to reduce angle of attack.\n\nDo NOT increase back pressure.\n\nAccept altitude loss during recovery.\n\nTOGA thrust required for recovery.\n\nRetract speedbrake immediately.\n\nNote: Autopilot MUST be disconnected — it may oppose recovery inputs."
    )

    // MARK: - Stall Warning at Liftoff

    static let stallAtLiftoff = MemoryItem(
        id: "STALL WARNING AT LIFTOFF",
        title: "STALL WARNING AT LIFTOFF",
        immediateActions: [
            ProcedureStep("STALL WARNING AT LIFTOFF", "", color: .annunciation),
            ProcedureStep("MAINTAIN / REDUCE PITCH ATTITUDE", "", isBoxed: true),
            ProcedureStep("THRUST LEVERS", "TOGA (IF NOT SET)", isBoxed: true),
            ProcedureStep("FOLLOW SRS", "IF AVAILABLE"),
            ProcedureStep("CONFIG", "DO NOT CHANGE UNTIL SAFE"),
            ProcedureStep("WHEN SPEED INCREASES", "RESUME NORMAL CLIMB"),
        ],
        supplementary: "Stall warning at liftoff may be caused by:\n- Incorrect takeoff speeds\n- Premature rotation\n- CG out of limits\n- Wind shear / gust effects\n\nDo NOT retract flaps until safe speed achieved.\n\nIf stick shaker activates, reduce pitch attitude immediately.\n\nNote: TOGA must be set if not already."
    )
}
