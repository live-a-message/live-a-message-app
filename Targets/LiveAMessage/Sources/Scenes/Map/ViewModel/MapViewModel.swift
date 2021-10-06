//
//  MapViewModel.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation
import Networking
import CoreLocation
import MapKit

class MapViewModel: NSObject, MapViewModelProtocol {

    lazy var annotations = [MKPointAnnotation: Message]()

    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        return locationManager
    }()

    var currentLocation = CLLocation() {
        didSet {
            didUpdatedLocation()
            notificateChange()
        }
    }
    var radius: Double = 300

    lazy var region: CLCircularRegion = {
      let region = CLCircularRegion(
        center: currentLocation.coordinate,
        radius: radius,
        identifier: UserData.shared.id
      )
      region.notifyOnEntry = true
      region.notifyOnExit = !region.notifyOnEntry
      return region
    }()

    weak var mapView: MapView?
    let localService = CloudKitMessagesService()
    var messages: [Message] = [] {
        didSet {
            addNearPins()
        }
    }

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func getMessages() {
        let location = Location(from: currentLocation.coordinate)
        localService.fetchMessages(location: location) { result in
            switch result {
            case .success(let messages):
                self.messages = messages
            case .failure(let error):
                NSLog(error.localizedDescription, "error")
            }
        }
    }

    func didUpdatedLocation() {
        self.getMessages()
        addNearPins()
    }

    func addNearPins() {
        self.messages.forEach {
            let location = $0.location
            let anotation = MKPointAnnotation()
            anotation.coordinate.latitude = location.lat
            anotation.coordinate.longitude = location.lon

            annotations[anotation] = $0
            self.mapView?.addAnnotation(anotation)
        }
    }

    func notificateChange() {
        NotificationCenter.default.post(name: .updateLocation, object: self.currentLocation)
    }

}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let shouldUpdateCurrentLocation = currentLocation.distance(from: location) > radius
            if shouldUpdateCurrentLocation {
                self.currentLocation = location
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard let circularRegion = region as? CLCircularRegion else { return }
        self.handleCircularRegion(circularRegion)
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        guard let circularRegion = region as? CLCircularRegion else { return }
        self.handleCircularRegion(circularRegion)
    }

    func handleCircularRegion(_ region: CLCircularRegion) {
        print("Geofence triggered!")
    }
}
