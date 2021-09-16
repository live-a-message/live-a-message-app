//
//  MapView.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import MapKit
import DesignSystem
import TinyConstraints
import Networking

class MapView: MKMapView {
  
  var viewModel = MapViewModel()
  
  let locationManager: CLLocationManager = {
    let locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = kCLDistanceFilterNone
    return locationManager
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.isZoomEnabled = true
    self.isZoomEnabled = true
    self.tintColor = Colors.mainRed
    self.showsUserLocation = true
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupConstraints() {
    self.edgesToSuperview()
  }
  
  func bind(){
    self.delegate = self
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
}


extension MapView: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000)
      self.setRegion(coordinateRegion, animated: true)
      self.viewModel.getMessages()
     }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error.localizedDescription)
  }
}

extension MapView: MKMapViewDelegate {
  func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    let circle = MKCircle(center: mapView.userLocation.coordinate, radius: 200)
    mapView.addOverlay(circle)
  }
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let circleRenderer = MKCircleRenderer(overlay: overlay)
      circleRenderer.fillColor = Colors.mainRed
      circleRenderer.alpha = 0.08
      return circleRenderer
  }
}
