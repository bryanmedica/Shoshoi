//
//  Cards.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 28/02/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Card: Hashable, Codable {
    var name: String
    var defaultRule: String
    var cardPrefix: String
}
