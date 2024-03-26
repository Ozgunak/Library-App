//
//  Item.swift
//  Library
//
//  Created by özgün aksoy on 2024-03-26.
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
