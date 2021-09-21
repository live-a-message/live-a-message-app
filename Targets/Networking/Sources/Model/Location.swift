//
//  Location.swift
//  Networking
//
//  Created by Tales Conrado on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation
import CoreLocation
public struct Location: Codable {
    public let lat: Double
    public let lon: Double

    public init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }

  public init(from coordinate: CLLocationCoordinate2D) {
    self.lat = coordinate.latitude
    self.lon = coordinate.longitude
  }
}
