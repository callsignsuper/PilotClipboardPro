//
//  Item.swift
//  Pilot Clipboard Pro
//
//  Created by Iuliia Morozova on 01.04.2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
