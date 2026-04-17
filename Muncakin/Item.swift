//
//  Item.swift
//  Muncakin
//
//  Created by Darren Christian Liharja on 18/04/26.
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
