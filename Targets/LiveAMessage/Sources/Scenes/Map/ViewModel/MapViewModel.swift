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

  lazy var locationManager: CLLocationManager = {
    let locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = kCLDistanceFilterNone
    return locationManager
  }()

  var currentLocation = CLLocation() {
    didSet {
      didUpdatedLocation(for: self.currentLocation)
    }
  }
  weak var mapView: MapView?
  let localService = LocalMessageService()
  var messages: [Message] = []
  var radius: Double = 300

  override init() {
    super.init()
    self.locationManager.delegate = self
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }

  func getMessages() {
    localService.fetchMessages { result in
      switch result {
      case .success(let messages):
        self.messages = messages
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

  func didUpdatedLocation(for location: CLLocation) {
    self.getMessages()
    self.messages.forEach {
      let location = $0.location
      let anotation = MKPointAnnotation()
      anotation.coordinate.latitude = Double(location.lat) ?? 0
      anotation.coordinate.longitude = Double(location.lon) ?? 0
      self.mapView?.addAnnotation(anotation)
    }
  }
}

extension MapViewModel: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000)
      self.mapView?.setRegion(coordinateRegion, animated: true)
      self.currentLocation = location
    }}

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error.localizedDescription)
  }
}
