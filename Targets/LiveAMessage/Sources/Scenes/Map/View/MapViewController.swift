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

    let headerView = MapHeaderView()

    let mapView = MapView()

    let locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        return locationManager
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    func buildHierarchy() {
        view.addSubview(mapView)
        view.addSubview(headerView)
    }
    func setupConstraints() {
        mapView.setupConstraints()
        headerView.setupConstraints()
    }

    func configureViews() {
        locationManager.delegate = self
        mapView.delegate = self
        headerView.rightButtonAction = addMessage
        headerView.leftButtonAction = showCloseMessages
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

extension MapViewController {
    func addMessage() {
        let controller = AddMessageViewController()
        controller.modalPresentationStyle = .formSheet
        present(controller, animated: true, completion: nil)
    }

    func showCloseMessages() {
        let closeMessagesViewModel = CloseMessagesViewModel(messages: viewModel.closeMessages)
        let controller = CloseMessagesViewController(viewModel: closeMessagesViewModel)
        let navController = UINavigationController(rootViewController: controller)

        navController.modalPresentationStyle = .overFullScreen
        present(navController, animated: true)
    }
}
