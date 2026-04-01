import SwiftUI

// MARK: - Data Structures

struct PAScript: Identifiable {
    let id: String
    let title: String
    let script: String
    let subTabs: [PASubTab]?
    let isEmergency: Bool

    init(_ title: String, script: String, subTabs: [PASubTab]? = nil, isEmergency: Bool = false) {
        self.id = title
        self.title = title
        self.script = script
        self.subTabs = subTabs
        self.isEmergency = isEmergency
    }
}

struct PASubTab: Identifiable {
    let id: String
    let label: String
    let script: String

    init(_ label: String, script: String) {
        self.id = label
        self.label = label
        self.script = script
    }
}

// MARK: - All PA Scripts Data

enum PAScriptsData {

    static let categories: [String] = [
        "PRE - DEPARTURE",
        "SECURITY FOR USA FLTS",
        "DE - ICING",
        "DELAYS",
        "TOP OF DESCENT",
        "TOD - FLTS TO JEDDAH",
        "DIVERSIONS",
        "REMOTE PARKING POSITION",
        "REJECTED T.O.",
        "AFTER G.A.",
        "EMERGENCY DESCENT",
        "BOMB ON BOARD",
        "PRECAUTIONARY DISEMBARKATION",
    ]

    static let emergencyCategories: Set<String> = [
        "EMERGENCY DESCENT",
        "BOMB ON BOARD",
        "PRECAUTIONARY DISEMBARKATION",
    ]

    static func script(for category: String) -> PAScript {
        switch category {
        case "PRE - DEPARTURE": return preDeparture
        case "SECURITY FOR USA FLTS": return securityUSA
        case "DE - ICING": return deIcing
        case "DELAYS": return delays
        case "TOP OF DESCENT": return topOfDescent
        case "TOD - FLTS TO JEDDAH": return todJeddah
        case "DIVERSIONS": return diversions
        case "REMOTE PARKING POSITION": return remoteParking
        case "REJECTED T.O.": return rejectedTO
        case "AFTER G.A.": return afterGA
        case "EMERGENCY DESCENT": return emergencyDescent
        case "BOMB ON BOARD": return bombOnBoard
        case "PRECAUTIONARY DISEMBARKATION": return precautionaryDisembark
        default: return PAScript(category, script: "Script not available.")
        }
    }

    // MARK: - Normal Scripts [ETIHAD: VERIFY — All scripts need Etihad-specific wording]

    static let preDeparture = PAScript("PRE - DEPARTURE", script: """
    Ladies and gentlemen, good ___(morning/afternoon/evening).

    This is your Captain speaking. On behalf of Etihad Airways and the entire crew, I would like to welcome you aboard this Airbus A380, flight EY___ to ___.

    Our flight time today will be approximately ___ hours and ___ minutes, and we will be cruising at an altitude of ___ feet.

    The weather in ___ is currently ___, with a temperature of ___ degrees Celsius.

    I would like to ask you to please direct your attention to the safety demonstration. Even if you are a frequent flyer, the safety features on this aircraft may differ from others you have flown on.

    On behalf of the flight deck crew, we wish you a pleasant flight. Thank you.
    """)

    static let securityUSA = PAScript("SECURITY FOR USA FLTS", script: """
    [ETIHAD: VERIFY — USA-specific security PA]

    Ladies and gentlemen, as we are operating to the United States of America, enhanced security procedures are in effect for this flight.

    We kindly request that you remain seated for the last ___ minutes of the flight. The use of lavatories during this time is strictly prohibited.

    We appreciate your understanding and cooperation with these security measures.

    Thank you.
    """)

    static let deIcing = PAScript("DE - ICING", script: """
    Ladies and gentlemen, this is your Captain.

    Due to the current weather conditions, it is necessary to de-ice our aircraft before departure. This is a standard procedure for your safety.

    During the de-icing process, you may notice a spraying sound and fluid on the windows. This is completely normal.

    This procedure will take approximately ___ minutes. We will keep you informed of any changes to our departure time.

    Thank you for your patience.
    """)

    static let delays = PAScript("DELAYS", script: """
    Ladies and gentlemen, this is your Captain speaking.

    I regret to inform you that our departure will be delayed by approximately ___ minutes due to ___(reason: ATC flow control / technical checks / weather / late connecting passengers / operational requirements).

    We apologise for any inconvenience this may cause and appreciate your patience. We will keep you updated on our departure time.

    Thank you.
    """)

    static let topOfDescent = PAScript("TOP OF DESCENT", script: """
    Ladies and gentlemen, this is your Captain.

    We have now commenced our descent into ___. We expect to land in approximately ___ minutes.

    The current weather in ___ is ___, with a temperature of ___ degrees Celsius.

    On behalf of the entire Etihad crew, we hope you have enjoyed your flight with us today. Please ensure your seat belts are fastened, your tray tables are stowed, and your seats are in the upright position.

    Cabin crew, please prepare the cabin for landing.

    Thank you for flying Etihad Airways.
    """)

    static let todJeddah = PAScript("TOD - FLTS TO JEDDAH", script: """
    [ETIHAD: VERIFY — Jeddah/Hajj-specific PA if applicable]

    Ladies and gentlemen, this is your Captain.

    We have now commenced our descent into Jeddah — King Abdulaziz International Airport. We expect to land in approximately ___ minutes.

    The current weather in Jeddah is ___, with a temperature of ___ degrees Celsius.

    For those of you travelling for Hajj or Umrah, we wish you a blessed and accepted pilgrimage.

    Cabin crew, please prepare the cabin for landing.

    Thank you for flying Etihad Airways.
    """)

    static let diversions = PAScript(
        "DIVERSIONS",
        script: "Select a sub-category below.",
        subTabs: [
            PASubTab("EN-ROUTE / EMER", script: """
            Ladies and gentlemen, this is your Captain.

            Due to ___(a medical emergency on board / a technical requirement / weather conditions at our destination / operational requirements), we will be diverting to ___.

            This is purely a precautionary measure, and there is no cause for concern. We expect to be on the ground in approximately ___ minutes.

            The cabin crew will provide you with further information. Please follow their instructions.

            Thank you for your understanding.
            """),
            PASubTab("ALT DEST", script: """
            Ladies and gentlemen, this is your Captain.

            Unfortunately, we are unable to land at ___ due to ___. We will therefore be landing at ___ instead.

            We apologise for the inconvenience and our ground staff will assist you with onward travel arrangements upon arrival.

            We expect to be on the ground in approximately ___ minutes.

            Thank you for your patience and understanding.
            """),
            PASubTab("AFTER G.A.", script: """
            Ladies and gentlemen, this is your Captain.

            As you may have noticed, we were unable to land on our first approach. This is a standard procedure and there is no cause for concern.

            We will be repositioning for another approach and expect to land in approximately ___ minutes.

            Please keep your seat belts fastened.

            Thank you.
            """),
        ]
    )

    static let remoteParking = PAScript("REMOTE PARKING POSITION", script: """
    Ladies and gentlemen, this is your Captain.

    We have arrived at ___ and will be parking at a remote stand. Buses will be provided to transport you to the terminal.

    Please remain seated with your seat belt fastened until the aircraft has come to a complete stop and the seat belt sign has been switched off.

    We ask for your patience during the bus transfer.

    Thank you for flying Etihad Airways.
    """)

    static let rejectedTO = PAScript("REJECTED T.O.", script: """
    Ladies and gentlemen, this is your Captain.

    We have stopped the aircraft on the runway for safety reasons. There is no cause for alarm.

    Please remain seated with your seat belts fastened. Do not attempt to leave your seats or open the overhead bins.

    We will provide you with further information shortly.

    Cabin crew, remain seated.

    Thank you.
    """)

    static let afterGA = PAScript("AFTER G.A.", script: """
    Ladies and gentlemen, this is your Captain.

    As you may have noticed, we were unable to complete our landing. This is a standard safety procedure and there is no cause for concern.

    We are now climbing to a safe altitude and will reposition for another approach.

    We expect to land in approximately ___ minutes.

    Please keep your seat belts fastened.

    Thank you.
    """)

    // MARK: - Emergency Scripts

    static let emergencyDescent = PAScript("EMERGENCY DESCENT", script: """
    THIS IS THE CAPTAIN.

    DESCENT. DESCENT.

    BRACE FOR LANDING. BRACE. BRACE.
    """, isEmergency: true)

    static let bombOnBoard = PAScript(
        "BOMB ON BOARD",
        script: "Select the applicable situation below.",
        subTabs: [
            PASubTab("GATE / TAXI", script: """
            THIS IS THE CAPTAIN.

            [ETIHAD: VERIFY — Bomb threat PA at gate/taxi]

            Ladies and gentlemen, for safety reasons we need to return to the gate / stop the aircraft immediately.

            When instructed by the cabin crew, please leave the aircraft immediately using the nearest exit. Leave all personal belongings behind.

            Cabin crew, initiate evacuation on my command.
            """),
            PASubTab("FLIGHT", script: """
            THIS IS THE CAPTAIN.

            [ETIHAD: VERIFY — Bomb threat PA in flight]

            Ladies and gentlemen, for safety reasons we will be making a precautionary landing at ___.

            Please follow all instructions from the cabin crew carefully. When we land, you may be asked to leave the aircraft quickly.

            Cabin crew, prepare for precautionary landing.
            """),
        ],
        isEmergency: true
    )

    static let precautionaryDisembark = PAScript(
        "PRECAUTIONARY DISEMBARKATION",
        script: "Select the applicable situation below.",
        subTabs: [
            PASubTab("STEPS AVAIL", script: """
            Ladies and gentlemen, this is your Captain.

            For safety reasons, we need you to leave the aircraft. Steps are available.

            Please leave all personal belongings and proceed calmly to the nearest exit. Follow the instructions of the cabin crew.

            Cabin crew, commence precautionary disembarkation using steps.
            """),
            PASubTab("STEPS N/A", script: """
            Ladies and gentlemen, this is your Captain.

            For safety reasons, we need you to leave the aircraft immediately.

            Please leave all personal belongings. Move to the nearest exit and use the escape slides. Jump and slide — do not sit down on the slide.

            Cabin crew, initiate evacuation.

            UNFASTEN YOUR SEAT BELTS AND GET OUT.
            """),
        ],
        isEmergency: true
    )
}
