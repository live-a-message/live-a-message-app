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
      didUpdatedLocation()
      notificateChange()
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

  func didUpdatedLocation() {
    self.getMessages()
    self.messages.forEach {
      let location = $0.location
      let anotation = MKPointAnnotation()
      anotation.coordinate.latitude = location.lat
      anotation.coordinate.longitude = location.lon
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
      let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000)
      self.mapView?.setRegion(coordinateRegion, animated: true)
      print(location.coordinate)
      self.currentLocation = location
    }}

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error.localizedDescription)
  }
}
