//
//  MapViewModelProtocol.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 15/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import MapKit
import Networking

protocol MapViewModelProtocol: NSObject {
    var coordinator: Coordinator? { get set }
    var didChangeLocation: (() -> Void)? { get set }
    var locationManager: CLLocationManager { get }
    var currentLocation: CLLocation { get set }
    var annotations: [MKPointAnnotation: Message] { get }
    var messages: [Message] { get }
    var radius: Double { get }

    var mapView: MapView? { get set }

    func fetchMessages()
    func postNotificationUpdateLocation()
    func addPin(_ message: Message)
}
