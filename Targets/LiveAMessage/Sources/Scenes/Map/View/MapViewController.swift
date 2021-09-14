//
//  MapViewController.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import DesignSystem

class MapViewController: UIViewController {
  
  let viewModel = MapViewModel()

  let mapView: MKMapView = {
    let mapView = MKMapView()
    mapView.isZoomEnabled = true
    mapView.tintColor = Colors.mainRed
    mapView.showsUserLocation = true
    mapView.translatesAutoresizingMaskIntoConstraints = false
    return mapView
  }()
  
  let locationManager: CLLocationManager = {
    let locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = kCLDistanceFilterNone
    return locationManager
  }()
  
  override func viewDidLoad() {
    self.view.backgroundColor = .white
    buildHierarchy()
    setupConstraints()
    configureViews()
  }
  
  func buildHierarchy() {
    self.view.addSubview(mapView)
  }
  func setupConstraints() {
    NSLayoutConstraint.activate([
                                  self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                  self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                  self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                  self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
  }
  
  func configureViews() {
    locationManager.delegate = self
    mapView.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
}

extension MapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000)
      mapView.setRegion(coordinateRegion, animated: true)
     }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error.localizedDescription)
  }
}

extension MapViewController: MKMapViewDelegate {
  func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    let circle = MKCircle(center: self.mapView.userLocation.coordinate, radius: 200)
    self.mapView.addOverlay(circle)
  }
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let circleRenderer = MKCircleRenderer(overlay: overlay)
      circleRenderer.fillColor = Colors.mainRed
      circleRenderer.alpha = 0.08
      return circleRenderer
  }
}
