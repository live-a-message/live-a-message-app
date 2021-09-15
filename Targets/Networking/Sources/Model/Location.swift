//
//  Location.swift
//  Networking
//
//  Created by Tales Conrado on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation

public struct Location: Codable {
    let lat: String
    let lon: String

    public init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
    }
}