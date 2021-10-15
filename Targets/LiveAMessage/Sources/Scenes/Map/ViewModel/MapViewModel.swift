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

    // MARK: Clousures
    var didChangeLocation: (() -> Void)?

    // MARK: - Data

    var radius: Double = 300
    var messages: [Message] = [] {
        didSet {
            addNearPins()
            checkForUnreadMessages()
        }
    }

    lazy var annotations = [MKPointAnnotation: Message]()

    // MARK: - Properties

    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        return locationManager
    }()

    var currentLocation = CLLocation() {
        didSet {
            fetchMessages()
            postNotificationUpdateLocation()
            didChangeLocation?()
        }
    }

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

    let service: MessageService
    weak var mapView: MapView?

    public init(service: MessageService = CloudKitMessagesService()) {
        self.service = service
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.fetchMessages()
    }

    public func fetchMessages() {
        let location = Location(from: currentLocation.coordinate)
        service.fetchMessages(location: location, radius: .greatestFiniteMagnitude) { result in
            switch result {
            case .success(let messages):
                self.messages = messages
            case .failure(let error):
                NSLog(error.localizedDescription, "error")
            }
        }
    }

    public func checkForUnreadMessages() {
        let counter = messages.filter({ $0.status == .unread }).count

        if counter > 0 {
            MessageNotificationManager.shared.createNotification(
                title: AkeeStrings.titleNotifCloseMessage,
                body: AkeeStrings.bodyNotifCloseMessage,
                badgeNumber: counter
            )
        }
    }

    private func addNearPins() {
        self.messages.forEach({ addPin($0) })
    }

    func addPin(_ message: Message) {
        let location = message.location
        let anotation = MKPointAnnotation()
        anotation.coordinate.latitude = location.lat
        anotation.coordinate.longitude = location.lon

        annotations[anotation] = message
        self.mapView?.addAnnotation(anotation)
    }

    func postNotificationUpdateLocation() {
        NotificationCenter.default.post(name: .updateLocation, object: self.currentLocation)
    }

    func drawOverlayCircle(location: CLLocation) {
        if let overlays = mapView?.overlays {
            mapView?.removeOverlays(overlays)
        }
        let circle = MKCircle(
            center: location.coordinate,
            radius: radius
        )
       mapView?.addOverlay(circle)
    }

}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // draw circle
            drawOverlayCircle(location: location)

            let coordinateRegion = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000)
            self.mapView?.setRegion(coordinateRegion, animated: true)
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
